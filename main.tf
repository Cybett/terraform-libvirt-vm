# terraform-project/main.tf
module "libvirt_vm" {
  source = "./modules/libvirt-vm"

  instance_count       = 2
  instance_name_prefix = "myvm"
  disk_size            = [20, 30]
  network_interfaces   = [
    {
      network_name = "default"
    },
    {
      network_name = "default"
    }
  ]
  storage_pool         = "mypool"
}
