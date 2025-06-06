## 8.1.1 (2025-06-06)

### Bug Fixes

* **AZ-1570:** 🔧 update output value to use `one` for SAS token retrieval 8b811db

### Miscellaneous Chores

* **deps:** update dependency tflint to v0.58.0 6c4a91b
* **deps:** update dependency trivy to v0.63.0 8157261

## 8.1.0 (2025-05-16)

### Features

* **AZ-1551:** ✨ force tofu 1.9 for validation constraints 6ec32b5
* **AZ-1551:** 💥 ✨ rework module with AzAPI 9086b53

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.9.1 8abfbdb
* **deps:** update dependency pre-commit to v4.2.0 9c47c0a
* **deps:** update dependency terraform-docs to v0.20.0 1734dbc
* **deps:** update dependency tflint to v0.57.0 9b12915
* **deps:** update dependency trivy to v0.60.0 1275ef1
* **deps:** update dependency trivy to v0.61.1 6384f33
* **deps:** update dependency trivy to v0.62.0 3555058
* **deps:** update dependency trivy to v0.62.1 912b1de
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.22.0 58b0d74
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.2.0 7008ac2
* **deps:** update tools 1656889

## 8.0.0 (2025-02-28)

### ⚠ BREAKING CHANGES

* **AZ-1088:** OpenTofu 1.8+

### Features

* **AZ-1088:** module v8 structure and updates 7cc7e1f

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.3 f1df51a
* **deps:** update dependency opentofu to v1.8.4 6f33552
* **deps:** update dependency opentofu to v1.8.6 ac8ad75
* **deps:** update dependency opentofu to v1.8.8 53dc4c6
* **deps:** update dependency opentofu to v1.9.0 1696fc9
* **deps:** update dependency pre-commit to v4 3d5f584
* **deps:** update dependency pre-commit to v4.0.1 541b6eb
* **deps:** update dependency pre-commit to v4.1.0 b4a8542
* **deps:** update dependency tflint to v0.54.0 37d6049
* **deps:** update dependency tflint to v0.55.0 ba117d2
* **deps:** update dependency tflint to v0.55.1 b1c06b3
* **deps:** update dependency trivy to v0.56.2 4164274
* **deps:** update dependency trivy to v0.57.1 43b77d8
* **deps:** update dependency trivy to v0.58.1 61f1203
* **deps:** update dependency trivy to v0.58.2 69b1f9d
* **deps:** update dependency trivy to v0.59.0 5738688
* **deps:** update dependency trivy to v0.59.1 e0a481a
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.19.0 2593797
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.20.0 7847a30
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.21.0 e40dd0e
* **deps:** update pre-commit hook pre-commit/pre-commit-hooks to v5 397b50a
* **deps:** update pre-commit hook tofuutils/pre-commit-opentofu to v2.1.0 4948722
* **deps:** update tools 55673e8
* **deps:** update tools 5c22f80
* prepare for new examples structure 33b0619
* update examples structure a08a62b
* update Github templates ac7c755
* update tflint config for v0.55.0 7e914f4

## 7.0.1 (2024-10-04)

### Documentation

* update README badge to use OpenTofu registry cc226ef

### Miscellaneous Chores

* **deps:** update dependency opentofu to v1.8.2 8c27c62
* **deps:** update dependency terraform-docs to v0.19.0 38f14c7
* **deps:** update dependency trivy to v0.55.0 5738c73
* **deps:** update dependency trivy to v0.55.1 0998526
* **deps:** update dependency trivy to v0.55.2 7b5024f
* **deps:** update dependency trivy to v0.56.1 1e137ff
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.18.0 77e0048
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.1 b725765
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.2 ef88b1f
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.3 f7324a6
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.95.0 8fd7824
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.0 2c5065a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.96.1 aede2fd

## 7.0.0 (2024-08-30)

### ⚠ BREAKING CHANGES

* bump to TF 1.3 / AzureRM v3

### Features

* bump to TF 1.3 / AzureRM v3 d752e64

### Continuous Integration

* **AZ-1391:** enable semantic-release [skip ci] de892ee
* **AZ-1391:** update semantic-release config [skip ci] ea409ad

### Miscellaneous Chores

* **deps:** enable automerge on renovate 11fdb6a
* **deps:** update dependency opentofu to v1.7.0 3cd5e44
* **deps:** update dependency opentofu to v1.7.1 91f1998
* **deps:** update dependency opentofu to v1.7.2 716927a
* **deps:** update dependency opentofu to v1.7.3 8197e5b
* **deps:** update dependency opentofu to v1.8.1 18cb9a7
* **deps:** update dependency pre-commit to v3.7.1 7944024
* **deps:** update dependency pre-commit to v3.8.0 e79e76a
* **deps:** update dependency terraform-docs to v0.18.0 039dd70
* **deps:** update dependency tflint to v0.51.0 3042e0f
* **deps:** update dependency tflint to v0.51.1 03ed64c
* **deps:** update dependency tflint to v0.51.2 371d429
* **deps:** update dependency tflint to v0.52.0 dad00a8
* **deps:** update dependency trivy to v0.50.2 48c61d9
* **deps:** update dependency trivy to v0.50.4 6682175
* **deps:** update dependency trivy to v0.51.0 0e7f8af
* **deps:** update dependency trivy to v0.51.1 a3cf5aa
* **deps:** update dependency trivy to v0.51.2 9f114e7
* **deps:** update dependency trivy to v0.51.4 bfe8826
* **deps:** update dependency trivy to v0.52.0 d7476e2
* **deps:** update dependency trivy to v0.52.1 62af82f
* **deps:** update dependency trivy to v0.52.2 0704fa5
* **deps:** update dependency trivy to v0.53.0 6eebb9b
* **deps:** update dependency trivy to v0.54.1 f071061
* **deps:** update pre-commit hook alessandrojcm/commitlint-pre-commit-hook to v9.17.0 f95378a
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.0 be512b1
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.92.1 8004159
* **deps:** update pre-commit hook antonbabenko/pre-commit-terraform to v1.94.0 82394c3
* **deps:** update renovate.json 25aad83
* **deps:** update tools e6d71aa
* **deps:** update tools ae6bcad
* **pre-commit:** update commitlint hook 9486992

# v4.2.0 - 2022-02-11

Fixed
  * AZ-674: Fix SAS token generation bug (datasource that reference a non created resource). Clean no more needed module variables.

# v4.1.0 - 2022-01-12

Breaking
  * AZ-647: Fix `external` provider version constraint (compatible Terraform 0.13+ only)

Changed
  * AZ-572: Revamp examples and improve CI

# v3.0.1/v4.0.1 - 2021-08-27

Changed
  * AZ-532: Revamp README with latest `terraform-docs` tool

# v2.0.1/v3.0.0/v4.0.0 - 2020-11-19

Updated
  * AZ-273: Module now compatible terraform `v0.13+`

# v2.0.0 - 2020-01-31

Added
  * AZ-122: First release
