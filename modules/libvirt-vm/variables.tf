variable "instance_count" {
  description = "Number of VM instances to create"
  type        = number
  default     = 1
}

variable "instance_name_prefix" {
  description = "Prefix for the VM instance names"
  type        = string
  default     = "vm"
}

variable "disk_size" {
  description = "Size of the disk in GB"
  type        = list(number)
  default     = [10]
}

variable "network_interfaces" {
  description = "List of network interfaces to attach to the VM"
  type        = list(map(string))
  default     = [
    {
      network_name = "default"
    }
  ]
}

variable "storage_pool" {
  description = "Name of the storage pool to use"
  type        = string
  default     = "default"
}
