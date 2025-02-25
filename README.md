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

  storage_account_connection_string = azurerm_storage_account.my_storage.primary_connection_string
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

  storage_account_connection_string = azurerm_storage_account.my_storage.primary_connection_string
  storage_container                 = azurerm_storage_container.my_container.name
}
```

## Providers

| Name | Version |
|------|---------|
| external | >= 2.0 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [external_external.generate_storage_sas_token](https://registry.terraform.io/providers/hashicorp/external/latest/docs/data-sources/external) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| permissions\_account | The permissions the Account SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (p)rocess (r)ead (u)pdate (w)rite. Can be combined. | `string` | `"wlacu"` | no |
| permissions\_container | The permissions the Container SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (r)ead (w)rite. Can be combined. | `string` | `"dlrw"` | no |
| resources\_types | The resource types the Account SAS is applicable for. Allowed values: (s)ervice (c)ontainer (o)bject. Can be combined. | `string` | `"sco"` | no |
| sas\_token\_expiry | Storage Account SAS Token end date (expiry). Specifies the UTC datetime (Y-m-d'T'H:M'Z') at which the SAS becomes invalid. | `string` | `"2042-01-01T00:00:00Z"` | no |
| services | The storage services the Account SAS is applicable for. Allowed values: (b)lob (f)ile (q)ueue (t)able. Can be combined. | `string` | `"bfqt"` | no |
| storage\_account\_connection\_string | Connection String of the Storage Account. | `string` | n/a | yes |
| storage\_container | Storage Account Container to use in order to generate a Service SAS Token. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage\_account\_sas\_container\_uri | SAS URI generated for access on Storage Account Container. |
| storage\_account\_sas\_token | SAS Token generated for access on Storage Account. |
<!-- END_TF_DOCS -->
## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview)

Microsoft Azure CLI command documentation [docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas](https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas)
