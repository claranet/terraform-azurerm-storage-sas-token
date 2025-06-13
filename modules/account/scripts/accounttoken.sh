#!/bin/bash

# Shell script to generate an account SAS token for Azure Storage using Azure CLI
# This script is designed to work with Terraform's external data source provider
# It accepts JSON input via stdin and returns JSON output via stdout

set -euo pipefail

# Function to log errors to stderr (won't interfere with JSON output)
log_error() {
    echo "ERROR: $1" >&2
}

# Function to validate required parameters
validate_input() {
    local required_params=("storage_account_name" "permissions" "expiry" "resource_types" "services")

    for param in "${required_params[@]}"; do
        if [[ -z "${!param:-}" ]]; then
            log_error "Missing required parameter: $param"
            exit 1
        fi
    done
}

# Main execution
main() {
    # Check if Azure CLI is installed
    if ! command -v az &> /dev/null; then
        log_error "Azure CLI is not installed or not in PATH"
        exit 1
    fi

    # Check if user is logged in to Azure CLI
    if ! az account show &> /dev/null; then
        log_error "Not logged in to Azure CLI. Please run 'az login' first"
        exit 1
    fi

    # Read JSON input from stdin
    local input
    input=$(cat)

    # Parse input parameters
    local storage_account_name
    local resource_group_name
    local permissions
    local expiry
    local start_time
    local resource_types
    local services
    local storage_key_name
    local subscription_id

    storage_account_name=$(echo "$input" | jq -r '.storage_account_name // empty')
    resource_group_name=$(echo "$input" | jq -r '.resource_group_name // empty')
    permissions=$(echo "$input" | jq -r '.permissions // empty')
    expiry=$(echo "$input" | jq -r '.expiry // empty')
    start_time=$(echo "$input" | jq -r '.start_time // empty')
    resource_types=$(echo "$input" | jq -r '.resource_types // empty')
    services=$(echo "$input" | jq -r '.services // empty')
    storage_key_name=$(echo "$input" | jq -r '.storage_key_name // "key1"')
    subscription_id=$(echo "$input" | jq -r '.subscription_id // empty')

    # Validate required parameters
    validate_input

    # Build the Azure CLI command for account SAS
    local az_command="az storage account generate-sas"

    # Add common parameters
    az_command+=" --account-name $storage_account_name"
    az_command+=" --permissions $permissions"
    az_command+=" --expiry $expiry"
    az_command+=" --resource-types $resource_types"
    az_command+=" --services $services"

    # Add optional parameters
    if [[ -n "$start_time" && "$start_time" != "null" ]]; then
        az_command+=" --start $start_time"
    fi

    # Add subscription if provided
    if [[ -n "$subscription_id" && "$subscription_id" != "null" ]]; then
        az_command+=" --subscription $subscription_id"
    fi

    # Add storage key specification
    if [[ "$storage_key_name" == "key2" ]]; then
        az_command+=" --account-key \$(az storage account keys list --account-name $storage_account_name"
        if [[ -n "$resource_group_name" && "$resource_group_name" != "null" ]]; then
            az_command+=" --resource-group $resource_group_name"
        fi
        if [[ -n "$subscription_id" && "$subscription_id" != "null" ]]; then
            az_command+=" --subscription $subscription_id"
        fi
        az_command+=" --query '[1].value' -o tsv)"
    fi

    # Add output format
    az_command+=" --output tsv"

    # Execute the command and capture the result
    local sas_token

    if ! sas_token=$(eval "$az_command" 2>/dev/null); then
        log_error "Failed to generate account SAS token using Azure CLI"
        log_error "Command: $az_command"
        exit 1
    fi

    # Validate that we got a token
    if [[ -z "$sas_token" ]]; then
        log_error "Generated account SAS token is empty"
        exit 1
    fi

    # Return JSON output as required by Terraform external provider
    jq -n \
        --arg token "$sas_token" \
        --arg full_token "?$sas_token" \
        '{
            "sas_token": $token,
            "sas_token_with_prefix": $full_token,
            "expiry": $ARGS.named.expiry,
            "permissions": $ARGS.named.permissions,
            "resource_types": $ARGS.named.resource_types,
            "services": $ARGS.named.services
        }' \
        --arg expiry "$expiry" \
        --arg permissions "$permissions" \
        --arg resource_types "$resource_types" \
        --arg services "$services"
}

# Execute main function
main "$@"
