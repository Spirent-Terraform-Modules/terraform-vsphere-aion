## Run Spirent AION Platform LabServer

Run Spirent AION Platform, deploy STC LabServer product and use hosted Spirent TestCenter license entitlements.

## Usage

To run this example you need to execute:

    $ terraform init
    $ terraform plan
    $ terraform apply

This example will create resources that will incur a cost. Run `terraform destroy` when you don't need these resources.

**Note:** [Prerequisites](../../README.md#Prerequisites) are also required.

<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| vsphere | n/a |

## Modules

| Name | Source | Version |
|------|--------|---------|
| aion | ../.. |  |

## Resources

| Name |
|------|
| [vsphere_compute_cluster](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/compute_cluster) |
| [vsphere_datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/datacenter) |
| [vsphere_network](https://registry.terraform.io/providers/hashicorp/vsphere/latest/docs/data-sources/network) |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| admin\_password | New cluster admin password. Specify using command line or env variables. | `any` | n/a | yes |
| aion\_password | AION password. Specify using command line or env variables. | `any` | n/a | yes |
| aion\_url | AION URL | `string` | `"https://spirent.spirentaion.com"` | no |
| aion\_user | AION user. Specify using command line or env variables. | `any` | n/a | yes |
| compute\_cluster | vSphere Cluster name into which resources will be created | `string` | `"cluster1"` | no |
| datacenter | vSphere datacenter name | `string` | `"dc"` | no |
| datastore | vSphere datastore name | `string` | `"ds"` | no |
| dest\_datastore\_folder | Destination datastore folder for cloud-init ISO images | `string` | `"iso"` | no |
| instance\_count | Number of AION instances to create | `number` | `1` | no |
| ip\_gateway | IPv4 gateway address | `string` | `"10.0.0.1"` | no |
| ip\_netmask | IPv4 netmask | `string` | `"255.255.255.0"` | no |
| ips | Static IPv4 address list | `list(string)` | <pre>[<br>  "10.0.0.11"<br>]</pre> | no |
| macs | MAC address list.  Automatically set if not specified. | `list(string)` | <pre>[<br>  "00:00:00:11:22:33"<br>]</pre> | no |
| memory | Size of the virtual machine's memory, in MB | `string` | `"32768"` | no |
| mgmt\_plane\_network | Management network name | `string` | `"Host Network"` | no |
| num\_cpus | Number of virtual processor cores assigned to an instance | `string` | `"4"` | no |
| os\_disk\_size\_gb | Size of the OS disk in GB. When null size will be determined from the template image. | `number` | `500` | no |
| private\_key\_file | SSH private key file | `string` | `"~/.ssh/id_rsa"` | no |
| public\_key\_file | SSH public key file | `string` | `"~/.ssh/id_rsa.pub"` | no |
| template\_name | Name of the template created from the OVA | `string` | `"aion_template"` | no |
| vsphere\_password | vSphere user password | `string` | `"VspherePassword"` | no |
| vsphere\_server | vSphere server | `string` | `"vsphere.spirentcom.com"` | no |
| vsphere\_user | vSphere user name | `string` | `"administrator@vsphere.local"` | no |

## Outputs

| Name | Description |
|------|-------------|
| instance\_uuids | List of UUIDs assigned to the instances |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
