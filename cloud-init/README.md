
# Cloud-init intialization

Setup open-vm-tools though NoCloud configuration when using vSphere.

User data is passed in using a NoCloud ISO image.

The ISO image was generated using genisoimage:

genisoimage  -output cloud-init.iso -volid cidata -joliet -rock user-data
