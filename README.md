# Azure Storage Account SAS token
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-sas-token/azurerm/)

This Terraform module generates a [SAS token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview) 
for a given [Azure Storage Account](https://docs.microsoft.com/en-us/azure/storage/common/storage-account-overview).

## Terraform version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| 2.x.x          | 0.12.x            |
| 1.x.x          | 0.11.x            |

## Usage

You can use this module by including it this way:

```hcl
module "storage-sas-token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  storage_account_name = "mystorageaccount"
  resource_group_name  = "my-resource-group-rg"
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|:----:|:-----:|:-----:|
| sas\_token\_expiry | Storage Account SAS Token end date (expiry). Specifies the UTC datetime (Y-m-d'T'H:M'Z') at which the SAS becomes invalid. | string | "2042-01-01T00:00:00Z" | no |
| storage\_account\_name | Name of the Storage Account | string | n/a | yes |
| resource\_group\_name | Resource Group of the storage account | string | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| storage\_account\_sas\_token | SAS Token generated for access on Storage Account with full permissions on containers and objects for blob and table services. |

## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview)

Microsoft Azure CLI command documentation [https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas](docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas)
