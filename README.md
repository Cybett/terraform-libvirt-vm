```markdown
# Terraform Libvirt VM Module

This Terraform module creates virtual machines (VMs) using the `libvirt` provider. It supports creating multiple VMs, attaching disks, and configuring network interfaces.

## Features

- Create one or multiple VM instances.
- Attach single or multiple disks to each VM.
- Configure one or multiple network interfaces for each VM.
- Manage storage pools for disk storage.

## Prerequisites

- **Terraform**: Install Terraform from [here](https://www.terraform.io/downloads.html).
- **Libvirt**: Ensure libvirt is installed and running on your system.
- **KVM**: Verify that KVM is enabled on your system.

## Usage

### Basic Usage

To use this module, add the following to your Terraform configuration:

```hcl
module "libvirt_vm" {
  source = "github.com/your-username/terraform-libvirt-vm"

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
  storage_pool         = "default"
}
```

## Input Variables

| Variable Name         | Description                                | Type           | Default Value |
|----------------------|--------------------------------|--------------|--------------|
| `instance_count`    | Number of VM instances to create | `number`      | `1`          |
| `instance_name_prefix` | Prefix for the VM instance names | `string`      | `"vm"`       |
| `disk_size`         | Size of the disk in GB          | `list(number)` | `[10]`       |
| `network_interfaces` | List of network interfaces to attach | `list(map)`   | `[{network_name = "default"}]` |
| `storage_pool`      | Name of the storage pool to use | `string`      | `"default"`  |

## Outputs

| Output Name    | Description                        |
|---------------|--------------------------------|
| `instance_names` | Names of the created VM instances |
| `instance_ips`   | IP addresses of the created VM instances |

## Advanced Usage

### Custom Disk Sizes

You can specify custom disk sizes for each VM:

```hcl
module "libvirt_vm" {
  source = "github.com/your-username/terraform-libvirt-vm"

  instance_count       = 3
  instance_name_prefix = "custom-vm"
  disk_size            = [20, 30, 40]  # Different disk sizes for each VM
  network_interfaces   = [
    {
      network_name = "default"
    }
  ]
  storage_pool         = "default"
}
```

### Multiple Network Interfaces

You can attach multiple network interfaces to each VM:

```hcl
module "libvirt_vm" {
  source = "github.com/your-username/terraform-libvirt-vm"

  instance_count       = 2
  instance_name_prefix = "multi-nic-vm"
  disk_size            = [20, 30]
  network_interfaces   = [
    {
      network_name = "default"
    },
    {
      network_name = "default"
    }
  ]
  storage_pool         = "default"
}
```

## Examples

### Example 1: Single VM with Default Configuration

```hcl
module "libvirt_vm" {
  source = "github.com/your-username/terraform-libvirt-vm"

  instance_count       = 1
  instance_name_prefix = "single-vm"
  disk_size            = [20]
  network_interfaces   = [
    {
      network_name = "default"
    }
  ]
  storage_pool         = "default"
}
```

### Example 2: Multiple VMs with Custom Disks and Networks

```hcl
module "libvirt_vm" {
  source = "github.com/your-username/terraform-libvirt-vm"

  instance_count       = 3
  instance_name_prefix = "multi-vm"
  disk_size            = [20, 30, 40]
  network_interfaces   = [
    {
      network_name = "default"
    },
    {
      network_name = "default"
    }
  ]
  storage_pool         = "default"
}
```

## Contributing

Contributions are welcome! Please open an issue or submit a pull request.

## License

This project is licensed under the **MIT License**.

You are free to use, modify, and distribute this software, as long as the original copyright and license notice are included.
```

