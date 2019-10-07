#!/bin/bash

set -xe

# Extract "storage_account_name" and "token_expiry" arguments from the input into
# jq will ensure that the values are properly quoted
# and escaped for consumption by the shell.
eval "$(jq -r '@sh "AZSTACCOUNT=\(.storage_account_name) TOKENEXP=\(.token_expiry) AZSTCON=\(.storage_connection_string) CONTAINER=\(.storage_container) CONTPERMS=\(.permissions_container) ACCPERMS=\(.permissions_account) RTYPES=\(.resources_types) SERVICES=\(.services)"')"

if [[ "${CONTAINER}" ]]; then
  # Official doc https://docs.microsoft.com/en-us/cli/azure/storage/container?view=azure-cli-latest#az-storage-container-generate-sas
  SASTOKEN=$(az storage container generate-sas \
      --account-name "${AZSTACCOUNT}" \
      --name "${CONTAINER}" \
      --connection-string "${AZSTCON}" \
      --expiry "${TOKENEXP}" \
      --permissions "${CONTPERMS}" \
      -o tsv)
else
  # Official doc https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas
  SASTOKEN=$(az storage account generate-sas \
      --account-name "${AZSTACCOUNT}" \
      --connection-string "${AZSTCON}" \
      --expiry "${TOKENEXP}" \
      --permissions "${ACCPERMS}" \
      --resource-types "${RTYPES}" \
      --services "${SERVICES}" \
      -o tsv)
fi

# Safely produce a JSON object containing the result value.
# jq will ensure that the value is properly quoted
# and escaped to produce a valid JSON string.
jq -n --arg sastoken "?$SASTOKEN" '{"sastoken":$sastoken}'
