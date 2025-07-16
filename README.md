# Azure Storage Account SAS token
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-blue.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![OpenTofu Registry](https://img.shields.io/badge/opentofu-registry-yellow.svg)](https://search.opentofu.org/module/claranet/storage-sas-token/azurerm/)

This Terraform module generates a [SAS token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview).

It could be either an [Account SAS](https://docs.microsoft.com/en-us/rest/api/storageservices/create-account-sas)
or a [Container Service SAS](https://docs.microsoft.com/en-us/rest/api/storageservices/create-service-sas).

## Limitations

Only the Service SAS for containers is implemented right now.

<!-- BEGIN_TF_DOCS -->
## Global versioning rule for Claranet Azure modules

| Module version | Terraform version | OpenTofu version | AzureRM version |
| -------------- | ----------------- | ---------------- | --------------- |
| >= 8.x.x       | **Unverified**    | 1.8.x            | >= 4.0          |
| >= 7.x.x       | 1.3.x             |                  | >= 3.0          |
| >= 6.x.x       | 1.x               |                  | >= 3.0          |
| >= 5.x.x       | 0.15.x            |                  | >= 2.0          |
| >= 4.x.x       | 0.13.x / 0.14.x   |                  | >= 2.0          |
| >= 3.x.x       | 0.12.x            |                  | >= 2.0          |
| >= 2.x.x       | 0.12.x            |                  | < 2.0           |
| <  2.x.x       | 0.11.x            |                  | < 2.0           |

## Contributing

If you want to contribute to this repository, feel free to use our [pre-commit](https://pre-commit.com/) git hook configuration
which will help you automatically update and format some files for you by enforcing our Terraform code module best-practices.

More details are available in the [CONTRIBUTING.md](./CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
### Account SAS
resource "azurerm_storage_account" "my_storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = module.azure_region.location
  name                     = "mystorage"
  resource_group_name      = module.rg.name
  min_tls_version          = "TLS1_2"
}

module "storage_sas_token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  expiration_start_date          = time_static.main.rfc3339 # change this to trigger a new token
  expiration_duration_in_hours   = 1
  storage_account_id             = azurerm_storage_account.my_storage.id
  token_type                     = "account"
  account_token_resources_types  = ["service", "container", "object"]
  account_token_services         = ["blob", "file"]
  permissions                    = ["read", "list"]
  account_token_storage_key_name = "key2" # key1 or key2

}

### Service SAS for a container
resource "azurerm_storage_container" "my_container" {
  name                  = "mycontainer"
  storage_account_name  = azurerm_storage_account.my_storage.name
  container_access_type = "private"
}

module "container_sas_token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  expiration_start_date = time_static.main.rfc3339 # change this to trigger a new token
  token_type            = "service"

  service_token_service_name = "mycontainer"
  service_token_service_type = "blob"
  storage_account_id         = azurerm_storage_account.my_storage.id
  permissions                = ["read", "list", "write", "append", "create", "delete"]

}


resource "time_static" "main" {}
```

## Providers

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| account\_token | ./modules/account | n/a |
| service\_token | ./modules/service | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| account\_token\_resources\_types | The resource types the Account SAS is applicable for. Allowed values: service, container, object. Can be combined. | `list(string)` | <pre>[<br/>  "service",<br/>  "container",<br/>  "object"<br/>]</pre> | no |
| account\_token\_services | The storage services the Account SAS is applicable for. Allowed values: `blob`, `file`, `queue`, `table`. Can be combined. | `list(string)` | <pre>[<br/>  "blob",<br/>  "file",<br/>  "queue",<br/>  "table"<br/>]</pre> | no |
| account\_token\_storage\_key\_name | Name of the storage key to use for generating the Service SAS token. Default is `key1`. | `string` | `"key1"` | no |
| expiration\_duration\_in\_hours | Duration in hours for which the SAS token will be valid. Default is 1 hour. | `number` | `1` | no |
| expiration\_start\_date | Date and time when the SAS token becomes valid. Should be an RFC3339 formatted string. Change this to trigger a new token. | `string` | n/a | yes |
| permissions | Permissions to grant for the service. Must be one of: read, add, create, write, delete, delete version, permanent delete, list, tags, find, move, execute, ownership, permissions, set immutability policy, update, process, query. | `list(string)` | <pre>[<br/>  "read",<br/>  "append",<br/>  "create",<br/>  "write",<br/>  "delete",<br/>  "list"<br/>]</pre> | no |
| service\_token\_service\_name | Name of the service to generate the SAS token for. It can be a container name, blob name, file share name, etc. | `string` | `""` | no |
| service\_token\_service\_type | Type of the service to generate a SAS token for. Must be one of : container, blob, file, share. | `string` | `""` | no |
| storage\_account\_id | ID of the Storage Account to generate the SAS token for. | `string` | n/a | yes |
| token\_type | Type of the token to generate. Must be one of: account, service. | `string` | `"service"` | no |

## Outputs

| Name | Description |
|------|-------------|
| module\_account | Account sas token module output. |
| module\_service | Service sas token module output. |
| sas\_token | SAS Token for accessing the Storage Account. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview)

Microsoft Azure CLI command documentation [docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas](https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas)
