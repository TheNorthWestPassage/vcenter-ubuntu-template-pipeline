packer {
  required_plugins {
    vsphere = {
      version = ">= 1.2.0"
      source  = "github.com/hashicorp/vsphere"
    }
  }
}

variable "vcenter_server" {
  type    = string
  default = "vcenter.example.com"
}

variable "vcenter_user" {
  type      = string
  sensitive = true
}

variable "vcenter_password" {
  type      = string
  sensitive = true
}

variable "datacenter" {
  type    = string
  default = "Datacenter"
}

variable "datastore" {
  type    = string
  default = "datastore1"
}

variable "cluster" {
  type    = string
  default = "Cluster"
}

variable "network" {
  type    = string
  default = "VM Network"
}

variable "ssh_public_key" {
  type    = string
  default = "ssh-rsa AAAA..."
}

source "vsphere-iso" "ubuntu" {
  vcenter_server      = var.vcenter_server
  username            = var.vcenter_user
  password            = var.vcenter_password
  insecure_connection = true

  vm_name              = "ubuntu-golden-{{timestamp}}"
  guest_os_type        = "ubuntu64Guest"
  notes                = "Golden image for Ubuntu 24.04/26.04 LTS (Minimal)"
  
  cluster              = var.cluster
  datacenter           = var.datacenter
  datastore            = var.datastore
  
  CPUs                 = 2
  RAM                  = 2048
  RAM_reserve_all      = true
  
  disk_controller_type = ["pvscsi"]
  storage {
    disk_size             = 20480
    disk_thin_provisioned = true
  }
  
  network_adapters {
    network      = var.network
    network_card = "vmxnet3"
  }
  
  iso_paths = [
    "[datastore1] iso/ubuntu-24.04-live-server-amd64.iso"
  ]

  boot_command = [
    "<wait>e<wait>",
    "<down><down><down><end>",
    " autoinstall ds=nocloud-net;s=http://{{ .HTTPIP }}:{{ .HTTPPort }}/",
    "<f10>"
  ]

  http_content = {
    "/user-data" = templatefile("user-data.pkrtpl.hcl", {
      ssh_public_key = var.ssh_public_key
    })
    "/meta-data" = ""
  }

  ssh_username = "ansible"
  ssh_timeout  = "30m"

  convert_to_template = true
}

build {
  sources = ["source.vsphere-iso.ubuntu"]

  provisioner "ansible" {
    playbook_file = "../ansible/packer_provision.yml"
    user          = "ansible"
    use_proxy     = false
  }
}
