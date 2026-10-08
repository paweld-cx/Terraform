locals {
  vms = {
    cp1 = {
      vm_id = 201
      ip    = "192.168.200.101/24"
    }
    cp2 = {
      vm_id = 202
      ip    = "192.168.200.102/24"
    }
    cp3 = {
      vm_id = 203
      ip    = "192.168.200.103/24"
    }
    work1 = {
      vm_id = 204
      ip    = "192.168.200.104/24"
    }
    work2 = {
      vm_id = 205
      ip    = "192.168.200.105/24"
    }
  }
}

resource "proxmox_virtual_environment_vm" "k3s" {
  for_each = local.vms

  vm_id     = each.value.vm_id
  name      = each.key
  node_name = "pve1"

  on_boot = false
  started = true

  clone {
    vm_id = 111
    full  = true
  }

  network_device {
    bridge = "Serwery"
  }

  initialization {
    datastore_id = "ZFS-ssd1"

    user_account {
      username = "ansible"

      keys = [
        trimspace(file("${path.module}/id_rsa.pub"))
      ]
    }

    ip_config {
      ipv4 {
        address = each.value.ip
        gateway = "192.168.200.254"
      }
    }

    dns {
      servers = [
        "192.168.200.181",
        "192.168.200.182"
      ]
    }
  }
}
