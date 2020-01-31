# Azure Storage Account SAS token
[![Changelog](https://img.shields.io/badge/changelog-release-green.svg)](CHANGELOG.md) [![Notice](https://img.shields.io/badge/notice-copyright-yellow.svg)](NOTICE) [![Apache V2 License](https://img.shields.io/badge/license-Apache%20V2-orange.svg)](LICENSE) [![TF Registry](https://img.shields.io/badge/terraform-registry-blue.svg)](https://registry.terraform.io/modules/claranet/storage-sas-token/azurerm/)

This Terraform module generates a [SAS token](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview).

It could be either an [Account SAS](https://docs.microsoft.com/en-us/rest/api/storageservices/create-account-sas) 
or a [Container Service SAS](https://docs.microsoft.com/en-us/rest/api/storageservices/create-service-sas).

## Limitations

Only the Service SAS for containers is implemented right now. 

## Terraform version compatibility

| Module version | Terraform version |
|----------------|-------------------|
| >= 2.x.x       | 0.12.x            |
| < 2.x.x        | 0.11.x            |

## Usage

### Account SAS

You can use this module by including it this way:

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location     = module.azure-region.location
  client_name  = var.client_name
  environment  = var.environment
  stack        = var.stack
}

resource "azurerm_storage_account" "my_storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = module.azure-region.location
  name                     = "mystorage"
  resource_group_name      = module.rg.resource_group_name
}

module "storage-sas-token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  storage_account_name = azurerm_storage_account.my_storage
  resource_group_name  = module.rg.resource_group_name
}
```

### Service SAS for a container

You can use this module by including it this way:

```hcl
module "azure-region" {
  source  = "claranet/regions/azurerm"
  version = "x.x.x"

  azure_region = var.azure_region
}

module "rg" {
  source  = "claranet/rg/azurerm"
  version = "x.x.x"

  location     = module.azure-region.location
  client_name  = var.client_name
  environment  = var.environment
  stack        = var.stack
}

resource "azurerm_storage_account" "my_storage" {
  account_replication_type = "LRS"
  account_tier             = "Standard"
  location                 = module.azure-region.location
  name                     = "mystorage"
  resource_group_name      = module.rg.resource_group_name
}

resource "azurerm_storage_container" "my_container" {
  name                  = "mycontainer"
  resource_group_name   = module.rg.resource_group_name
  storage_account_name  = azurerm_storage_account.my_storage
  container_access_type = "private"
}

module "container-sas-token" {
  source  = "claranet/storage-sas-token/azurerm"
  version = "x.x.x"

  storage_account_name = azurerm_storage_account.my_storage
  resource_group_name  = module.rg.resource_group_name
  storage_container    = azurerm_storage_container.my_container.name
}
```

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:-----:|
| enabled | "false" to disable this module. This variable aims to workaround the lack of count for modules. | `bool` | `true` | no |
| permissions\_account | The permissions the Account SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (p)rocess (r)ead (u)pdate (w)rite. Can be combined. | `string` | `"wlacu"` | no |
| permissions\_container | The permissions the Container SAS grants. Allowed values: (a)dd (c)reate (d)elete (l)ist (r)ead (w)rite. Can be combined. | `string` | `"dlrw"` | no |
| resource\_group\_name | Resource Group of the storage account | `string` | n/a | yes |
| resources\_types | The resource types the Account SAS is applicable for. Allowed values: (s)ervice (c)ontainer (o)bject. Can be combined. | `string` | `"sco"` | no |
| sas\_token\_expiry | Storage Account SAS Token end date (expiry). Specifies the UTC datetime (Y-m-d'T'H:M'Z') at which the SAS becomes invalid. | `string` | `"2042-01-01T00:00:00Z"` | no |
| services | The storage services the Account SAS is applicable for. Allowed values: (b)lob (f)ile (q)ueue (t)able. Can be combined. | `string` | `"bfqt"` | no |
| storage\_account\_name | Name of the Storage Account | `string` | n/a | yes |
| storage\_container | Storage Account Container to use in order to generate a Service SAS Token. | `string` | `""` | no |

## Outputs

| Name | Description |
|------|-------------|
| storage\_account\_sas\_container\_uri | SAS URI generated for access on Storage Account Container. |
| storage\_account\_sas\_token | SAS Token generated for access on Storage Account. |

## Related documentation

Microsoft Azure documentation: [docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview](https://docs.microsoft.com/en-us/azure/storage/common/storage-sas-overview)

Microsoft Azure CLI command documentation [docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas](https://docs.microsoft.com/en-us/cli/azure/storage/account?view=azure-cli-latest#az-storage-account-generate-sas)
