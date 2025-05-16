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

More details are available in the [CONTRIBUTING.md](../../CONTRIBUTING.md#pull-request-process) file.

## Usage

This module is optimized to work with the [Claranet terraform-wrapper](https://github.com/claranet/terraform-wrapper) tool
which set some terraform variables in the environment needed by this module.
More details about variables set by the `terraform-wrapper` available in the [documentation](https://github.com/claranet/terraform-wrapper#environment).

⚠️ Since modules version v8.0.0, we do not maintain/check anymore the compatibility with
[Hashicorp Terraform](https://github.com/hashicorp/terraform/). Instead, we recommend to use [OpenTofu](https://github.com/opentofu/opentofu/).

```hcl
module "sas_token" {
  source  = "claranet/storage-sas-token/azurerm//modules/account"
  version = "x.x.x"

  expiration_start_date        = "2025-12-05T15:00:00Z"
  expiration_duration_in_hours = 8760 # 1 year
  storage_account_id           = module.storage.id

  resources_types  = ["service", "container", "object"]
  services         = ["blob", "file", "queue", "table"]
  storage_key_name = "key1" # key1 or key2
  permissions      = ["read", "list", "write", "add", "create", "update", "process"]
}
```

## Providers

| Name | Version |
|------|---------|
| azapi | ~> 2.3 |
| time | ~> 0.13 |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [time_static.main](https://registry.terraform.io/providers/hashicorp/time/latest/docs/resources/static) | resource |
| [azapi_resource_action.main](https://registry.terraform.io/providers/Azure/azapi/latest/docs/data-sources/resource_action) | data source |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| expiration\_duration\_in\_hours | Duration in hours for which the SAS token will be valid. Default is 1 hour. | `number` | `1` | no |
| expiration\_start\_date | Date and time when the SAS token becomes valid. Should be an RFC3339 formatted string. Change this to trigger a new token. | `string` | n/a | yes |
| permissions | Permissions to grant for the service. Must be one of : read, write, delete, list, add, create, update, process. | `list(string)` | n/a | yes |
| resources\_types | The resource types the Account SAS is applicable for. Allowed values: service, container, object. Can be combined. | `list(string)` | <pre>[<br/>  "service",<br/>  "container",<br/>  "object"<br/>]</pre> | no |
| services | The storage services the Account SAS is applicable for. Allowed values: `blob`, `file`, `queue`, `table`. Can be combined. | `list(string)` | <pre>[<br/>  "blob",<br/>  "file",<br/>  "queue",<br/>  "table"<br/>]</pre> | no |
| storage\_account\_id | The storage account ID to generate the SAS token for. | `string` | n/a | yes |
| storage\_key\_name | Name of the storage key to use for generating the SAS token. Default is `key1`. | `string` | `"key1"` | no |

## Outputs

| Name | Description |
|------|-------------|
| resource | AzAPI resource action object. |
| sas\_token | SAS Token for accessing the Storage Account. |
<!-- END_TF_DOCS -->
