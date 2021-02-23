<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
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
| ip\_gateway | IPv4 gateway address. | `string` | `"10.0.0.1"` | no |
| ip\_netmask | IPv4 netmask. | `string` | `"255.255.255.0"` | no |
| ips | Static IPv4 address list. | `list(string)` | <pre>[<br>  "10.0.0.11"<br>]</pre> | no |
| iso\_dest | ISO destination directory | `string` | `"aion_iso"` | no |
| macs | MAC address list.  Automatically set if not specified. | `list(string)` | <pre>[<br>  "00:00:00:11:22:33"<br>]</pre> | no |
| memory | The size of the virtual machine's memory, in MB. | `string` | `"2048"` | no |
| mgmt\_plane\_network | Management network name. | `string` | `"Host Network"` | no |
| num\_cpus | The total number of virtual processor cores to assign to STCv virtual machine | `string` | `"2"` | no |
| private\_key\_file | SSH private key file | `string` | `"~/.ssh/id_rsa"` | no |
| public\_key\_file | SSH public key file | `string` | `"~/.ssh/id_rsa.pub"` | no |
| template\_name | Name of the template created from the OVF or OVA | `string` | `"aion_template"` | no |
| vsphere\_compute\_cluster | The vSphere Cluster into which resources will be created. | `string` | `"cluster1"` | no |
| vsphere\_datacenter | The name of the vSphere Datacenter into which resources will be created. | `string` | `"dc"` | no |
| vsphere\_datastore | The name of the vSphere Datastore into which resources will be created. | `string` | `"ds"` | no |
| vsphere\_host | Host name on the vSphere server. | `string` | `"vsphere-01.spirentcom.com"` | no |
| vsphere\_password | The password for the current vSphere user. | `string` | `"VspherePassword"` | no |
| vsphere\_server | The vSphere server. | `string` | `"vsphere.spirentcom.com"` | no |
| vsphere\_user | The user to access vSphere. | `string` | `"administrator@vsphere.local"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_uuids | List of UUIDs assigned to the instances, if applicable. |

<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
