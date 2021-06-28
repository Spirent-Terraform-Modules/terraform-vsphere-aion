# vSphere Spirent AION Platform Terraform

![Image of Spirent AION](./images/aion.jpg)

## Description
[Spirent AION](https://www.spirent.com/products/aion) is a cloud platform for Spirent products and license management.
This Terraform module deploys the Spirent AION Image on vSphere using your spirentaion.com account.

After `terraform apply` finishes you will be able to point your browser at the `instance_public_ips` addresses to use the platform or perform additional configuration.

Set `enable_provisioner=false` to run the configuration wizard manually in a web browser.  Otherwise, when `enable_provisioner=true` login to https://<your_public_ip> using the values of `admin_email` and `admin_password`.

See [product configuration](#product-configuration) for automated and manual configuration details.

## Prerequisites

Prior to running Terraform the following must be completed:
1.  [Install govc](#install-govc)
2.  [Install genisoimage](#install-genisoimage)
3.  [Download AION image](#download-aion-image)
4.  [Create AION image vSphere Template](#create-aion-image-vsphere-template)
5.  Create public and private key files

### Install govc
[govc](https://github.com/vmware/govmomi/tree/master/govc) is a vSphere command line interface (CLI). Follow installation instructions [here](https://github.com/vmware/govmomi/tree/master/govc#Installation).

Set govc environmental variables specific to your vSphere: `GOVC_URL`, `GOVC_INSECURE`, `GOVC_USERNAME`, `GOVC_PASSWORD`

Verify vSphere list inventory works:
```
govc ls -l "*"
```

### Install genisoimage
genisoimage is a tool to create ISO images.  This terraform module uses genisomage to pass NoCloud cloud-init configuration to the instances.  Install genisoimage using your package manager.

Ubuntu/Debian:
```
apt-get install genisoimage
```

Red Hat/CentOS:
```
yum install genisoimage
```

### Download AION image
The AION platform OVA image can be downloaded from spirentaion.com in the _AION Downloads_ of http::<your_organization>/spirentaion.com.

### Create AION image vSphere Template
Create vSphere AION template using the following commands:
```
./import-spec.sh <vsphere_network> > aion-spec.json
govc import.ova -ds=<datastore> -options=aion-spec.json -name=aion_template <aion-platform-image-xxxx.ova>
```


## Terraform examples
Terraform examples are located in the [examples](./examples) folder.

### Basic usage
```
module "aion" {
  source = "git::https://github.com/Spirent-Terraform-Modules/terraform-vsphere-aion"

  datacenter            = "dc"
  datastore             = "ds"
  resource_pool_id      = "resgroup-123"
  mgmt_plane_network_id = "dvportgroup-123"
  template_name         = "aion_template"
  ips                   = ["10.0.0.11"]
  ip_netmask            = "255.255.255.0"
  ip_gateway            = "10.0.0.1"
  macs                  = ["00:00:00:11:22:33"]
  dest_datastore_folder = "iso"

  public_key_file  = "./bootstrap_public_key_file"
  private_key_file = "./bootstrap_private_key_file"

  aion_url       = "https://spirent.spirentaion.com"
  aion_user      = "user1@spirent.com"
  aion_password  = "aion-password"
  admin_password = "admin-password"
}
```


<!-- BEGINNING OF PRE-COMMIT-TERRAFORM DOCS HOOK -->
## Requirements

| Name | Version |
|------|---------|
| vsphere | 1.24.3 |

## Providers

| Name | Version |
|------|---------|
| local | n/a |
| null | n/a |
| random | n/a |
| template | n/a |
| vsphere | 1.24.3 |

## Modules

No Modules.

## Resources

| Name |
|------|
| [local_file](https://registry.terraform.io/providers/hashicorp/local/latest/docs/resources/file) |
| [null_resource](https://registry.terraform.io/providers/hashicorp/null/latest/docs/resources/resource) |
| [random_id](https://registry.terraform.io/providers/hashicorp/random/latest/docs/resources/id) |
| [template_file](https://registry.terraform.io/providers/hashicorp/template/latest/docs/data-sources/file) |
| [vsphere_datacenter](https://registry.terraform.io/providers/hashicorp/vsphere/1.24.3/docs/data-sources/datacenter) |
| [vsphere_datastore](https://registry.terraform.io/providers/hashicorp/vsphere/1.24.3/docs/data-sources/datastore) |
| [vsphere_file](https://registry.terraform.io/providers/hashicorp/vsphere/1.24.3/docs/resources/file) |
| [vsphere_virtual_machine](https://registry.terraform.io/providers/hashicorp/vsphere/1.24.3/docs/data-sources/virtual_machine) |
| [vsphere_virtual_machine](https://registry.terraform.io/providers/hashicorp/vsphere/1.24.3/docs/resources/virtual_machine) |

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
| datacenter | vSphere datacenter name | `string` | n/a | yes |
| datastore | vSphere datastore name | `string` | n/a | yes |
| deploy\_location | Location name for deployed product instances. | `string` | `"location1"` | no |
| deploy\_products | List of products to deploy. See Product List below for details. | `list(map(string))` | `[]` | no |
| dest\_datastore\_folder | Destination datastore folder for cloud-init ISO images | `string` | n/a | yes |
| dest\_dir | Destination directory on the instance where provisioning files will be copied | `string` | `"~"` | no |
| enable\_provisioner | Enable provisioning.  When enabled instances will be initialized with the specified variables. | `bool` | `true` | no |
| entitlements | Install hosted entitlements from organization's AION platform. See Entitlement List below for details. | `list(map(string))` | `[]` | no |
| http\_enabled | Allow HTTP access as well as HTTPS.  Normally this is not recommended. | `bool` | `false` | no |
| instance\_count | Number of AION instances to create | `number` | `1` | no |
| instance\_name | Name assigned to the instance.  An instance number will be appended to the name. | `string` | `"AION"` | no |
| ip\_gateway | IPv4 gateway | `string` | n/a | yes |
| ip\_netmask | IPv4 netmask | `string` | n/a | yes |
| ips | Static IPv4 address list | `list(string)` | n/a | yes |
| local\_admin\_password | Cluster local admin password for instance SSH access.  Will use admin\_password if not specified. | `string` | `""` | no |
| macs | MAC address list.  Automatically set if not specified. | `list(string)` | `[]` | no |
| memory | Size of the virtual machine's memory, in MB | `number` | `"2048"` | no |
| metrics\_opt\_out | Opt-out of Spirent metrics data collection | `bool` | `false` | no |
| mgmt\_plane\_network\_id | Management network ID | `string` | n/a | yes |
| node\_names | Instance cluster node names.  List length must equal instance\_count. | `list(string)` | `[]` | no |
| node\_storage\_provider | Cluster node storage provider | `string` | `"local"` | no |
| node\_storage\_remote\_uri | Cluster node storage URI.  Leave blank for default when provider is local | `string` | `""` | no |
| num\_cpus | Number of virtual processor cores assigned to an instance | `number` | `"2"` | no |
| os\_disk\_size\_gb | Size of the OS disk in GB. When null size will be determined from the template image. | `number` | `null` | no |
| private\_key\_file | SSH private key file | `string` | n/a | yes |
| public\_key\_file | SSH public key file | `string` | n/a | yes |
| resource\_pool\_id | vSphere resource pool ID | `string` | n/a | yes |
| template\_name | Name of the template created from the OVA | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| instance\_uuids | List of UUIDs assigned to the instances. |
<!-- END OF PRE-COMMIT-TERRAFORM DOCS HOOK -->

## Product Configuration
Product configuration specifies product deployment and license entitlements for the platform.

### Automated
Use Terraform variables for automated configuration.

#### Entitlement List
The entitlement list specifies which license entitlements are hosted to the new AION platform.  An empty list will not add entitlements.  Use the following options to define each entitlement:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| product | Product name | `string` | n/a | yes |
| license | License name | `string` | n/a | yes |
| number  | Entitlement number.  When specified number must match otherwise any will match.| `number` | n/a | no |

#### Product List
The product list specifies which products will be deployed.  An empty list will not deploy any products.  Use the following options to define each product deployment:

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| name | Product name | `string` | n/a | yes |
| version | Product version | `string` | n/a | yes |


### Manual
Use the web browser to perform additional manual configuration after the intance is deployed.

#### Add License Entitlements
1. From _Settings_ <img src="./images/aion_settings.jpg" width="22" height="22"/> navigate to _License Manager_, _Entitlements_
2. Click _Install Entitlements_
3. Use one of the following methods to add entitlements (#1 is prefered)
   1. Login to <your_org>.spirentaion.com and select entitlements to host in the new instance\
      **Note:** Hosted entitlements should be released before destroying the instance.  As a convenience `terraform destroy` will unhost remaining entitlements.  However, if instance state is manually manipulated you may need to contact Spirent support to release entitlements for you.
   2. Install a license entitlement file obtained from Spirent support

#### Add Products
1. From _Settings_ <img src="./images/aion_settings.jpg" width="22" height="22"/> navigate to _Settings_, _Add New Products_
2. Click _Install New Products_
3. Select products and versions and click _Install_
