#Variables
variable "yandex_cloud_id" {
  default = "b1g9ilrcqm2noqtvd2om"
}

# Заменить на Folder своего облака
# https://console.cloud.yandex.ru/cloud?section=overview
variable "yandex_folder_id" {
  default = "b1gdit6jmusqo5af5j40"
}

# Заменить на ID своего образа
# ID можно узнать с помощью команды yc compute image list
variable "centos-7-base" {
  default = "fd88d14a6790do254kj7"
}



#Make provider
terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version =  ">= 0.13"
}

provider yandex {
  token     = "Here is shoud be a token"
  cloud_id  = "${var.yandex_cloud_id}"
  folder_id = "${var.yandex_folder_id}"
}




#Make network
resource "yandex_vpc_network" "default" {
  name = "net"
}

resource "yandex_vpc_subnet" "default" {
  name = "subnet"
  zone           = "ru-central1-a"
  network_id     = "${yandex_vpc_network.default.id}"
  v4_cidr_blocks = ["192.168.101.0/24"]
}


#Make compute_instances by count

#Define the number of VMs in each workspace
locals {
  instance = {
  stage = 1
  prod = 2
  }
}

resource "yandex_compute_instance" "node_by_count" {
  name                      = "node-${count.index+1}-${terraform.workspace}"
  zone                      = "ru-central1-a"
  hostname                  = "node-${count.index+1}.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7-base}"
      name        = "root-node-${count.index+1}"
      type        = "network-ssd"
      size        = "50"
    }
  }

 network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {
    ssh-keys = "centos:${file("~/.ssh/id_rsa.pub")}"
  }

count = local.instance[terraform.workspace]
}


/*

#Make compute_instances by for_each

#Define the numbers of VM's in each workspace
locals {
  vm_ids = toset([
    "1",
    "2",
  ])
}

resource "yandex_compute_instance" "node_by_foreach" {
  for_each = local.vm_ids
  name                      = "node-${each.key}-${terraform.workspace}"
  zone                      = "ru-central1-a"
  hostname                  = "node-${each.key}.netology.cloud"
  allow_stopping_for_update = true

  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      image_id    = "${var.centos-7-base}"
      name        = "root-node-${each.key}"
      type        = "network-ssd"
      size        = "50"
    }
  }

 network_interface {
    subnet_id = "${yandex_vpc_subnet.default.id}"
    nat       = true
  }

  metadata = {

  }

}
*/
