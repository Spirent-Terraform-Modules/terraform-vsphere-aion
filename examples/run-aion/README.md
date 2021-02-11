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
| admin\_password | New cluster admin password. Specify using command line or env variables. | `any` | n/a | yes |
| aion\_password | AION password. Specify using command line or env variables. | `any` | n/a | yes |
| aion\_url | AION URL. | `string` | `"https://spirent.spirentaion.com"` | no |
| aion\_user | AION user. Specify using command line or env variables. | `any` | n/a | yes |
| instance\_count | Number of STCv instances to create. | `number` | `1` | no |
| memory | The size of the virtual machine's memory, in MB. | `string` | `"2048"` | no |
| mgmt\_plane\_subnet\_id | Management network ID. | `string` | `""` | no |
| num\_cpus | The total number of virtual processor cores to assign to STCv virtual machine | `string` | `"2"` | no |
| template\_name | Name of the template created from the OVF or OVA | `string` | `"aion_template"` | no |
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
