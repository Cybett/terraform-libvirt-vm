terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = "0.7.1"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}

resource "libvirt_volume" "vm_disk" {
  count          = var.instance_count
  name           = "${var.instance_name_prefix}-${count.index}.qcow2"
  pool           = var.storage_pool
  size           = var.disk_size[count.index % length(var.disk_size)] * 1024 * 1024 * 1024
  format         = "qcow2"
}

resource "libvirt_cloudinit_disk" "cloudinit" {
  count = var.instance_count
  name  = "${var.instance_name_prefix}-${count.index}-cloudinit.iso"
  pool  = var.storage_pool
  user_data = <<-EOF
    #cloud-config
    hostname: ${var.instance_name_prefix}-${count.index}
    users:
      - name: ubuntu
        ssh-authorized-keys:
          - ${file("~/.ssh/id_rsa.pub")}
        sudo: ALL=(ALL) NOPASSWD:ALL
    packages:
      - qemu-guest-agent
    runcmd:
      - systemctl enable qemu-guest-agent
      - systemctl start qemu-guest-agent
    EOF
}

resource "libvirt_domain" "vm_instance" {
  count  = var.instance_count
  name   = "${var.instance_name_prefix}-${count.index}"
  memory = "1024"
  vcpu   = 1

  cloudinit = libvirt_cloudinit_disk.cloudinit[count.index].id

  dynamic "disk" {
    for_each = [libvirt_volume.vm_disk[count.index].id]
    content {
      volume_id = disk.value
    }
  }

  dynamic "network_interface" {
    for_each = var.network_interfaces
    content {
      network_name = network_interface.value["network_name"]
    }
  }
}
