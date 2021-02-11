<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| terraform | >= 0.13.0 |
| vsphere | 1.24.3 |

## Providers

| Name | Version |
|------|---------|
| vsphere | 1.24.3 |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_email | Cluster admin user email. Use this to login to instance web page.  Default is obtained from AION user information. | `string` | `""` | no |
| admin\_first\_name | Cluster admin user first name. Default is obtained from AION user information. | `string` | `""` | no |
| admin\_last\_name | Cluster admin user last name.  Default is obtained from AION user information. | `string` | `""` | no |
| admin\_password | Cluster admin user password. Use this to login to to the instance web page. | `string` | n/a | yes |
| aion\_password | AION user password for aion\_url | `string` | n/a | yes |
| aion\_url | AION URL. An example URL would be https://example.spirentaion.com. | `string` | n/a | yes |
| aion\_user | AION user registered on aion\_url | `string` | n/a | yes |
| cluster\_names | Instance cluster names.  List length must equal instance\_count. | `list(string)` | `[]` | no |
| datacenter\_id | vSphere datacenter ID. | `string` | `""` | no |
| datastore\_id | vSphere datastore ID. | `string` | `""` | no |
| dest\_dir | Destination directory on the instance where provisining files will be copied | `string` | `"~"` | no |
| enable\_provisioner | Enable provisioning.  When enabled instances will be initialized with the specified variables. | `bool` | `true` | no |
| http\_enabled | Allow HTTP access as well as HTTPS.  Normally this is not recommended. | `bool` | `false` | no |
| instance\_count | Number of STCv instances to create. | `number` | `1` | no |
| instance\_name | Name assigned to the instance.  An instance number will be appended to the name. | `string` | `"AION"` | no |
| local\_admin\_password | Cluster local admin password for instance SSH access.  Will use admin\_password if not specified. | `string` | `""` | no |
| memory | The size of the virtual machine's memory, in MB. | `number` | `"2048"` | no |
| metrics\_opt\_out | Opt-out of Spirent metrics data collection | `bool` | `false` | no |
| mgmt\_plane\_network\_id | Management network ID. | `string` | `""` | no |
| node\_names | Instance cluster node names.  List length must equal instance\_count. | `list(string)` | `[]` | no |
| node\_storage\_provider | Cluster node storage provider | `string` | `"local"` | no |
| node\_storage\_remote\_uri | Cluster node storage URI.  Leave blank for default when provider is local | `string` | `""` | no |
| num\_cpus | The total number of virtual processor cores to assign to STCv virtual machine | `number` | `"2"` | no |
| resource\_pool\_id | vSphere resource pool ID. | `string` | `""` | no |
| template\_name | Name of the template created from the OVA | `string` | `""` | no |
| vsphere\_compute\_cluster | The vSphere Cluster into which resources will be created. | `string` | `"Testing"` | no |
| vsphere\_datacenter | The name of the vSphere Datacenter into which resources will be created. | `string` | `"Benchmarking"` | no |
| vsphere\_datastore | The name of the vSphere Datastore into which resources will be created. | `string` | `"VirtTest-05.local"` | no |
| vsphere\_host | Host name on the vSphere server. | `string` | `"virttest-05.calenglab.spirentcom.com"` | no |
| vsphere\_password | The password for the current vSphere user. | `string` | `"Sp!rent01"` | no |
| vsphere\_server | The vSphere server. | `string` | `"virttest-vc.calenglab.spirentcom.com"` | no |
| vsphere\_user | The user to access vSphere. | `string` | `"administrator@vsphere.local"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_default\_ips | List of default IP addresses assigned to the instances, if applicable. |
| instance\_guest\_ips | List of guest IP addresses assigned to the instances, if applicable. |
| instance\_uuids | List of UUIDs assigned to the instances. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
