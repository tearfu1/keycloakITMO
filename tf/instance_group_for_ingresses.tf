# Compute instance group for ingresses

resource "yandex_compute_instance_group" "k8s-ingresses" {
  name               = "k8s-ingresses"
  service_account_id = yandex_iam_service_account.admin.id
  depends_on = [
    yandex_iam_service_account.admin,
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_vpc_network.k8s-network,
    yandex_vpc_subnet.k8s-subnet-1,
    yandex_vpc_subnet.k8s-subnet-2,
    yandex_vpc_subnet.k8s-subnet-3,
  ]

  load_balancer {
    target_group_name = "k8s-ingresses"
  }

  instance_template {

    name = "ingress-{instance.index}"

    resources {
      cores  = 2
      memory = 2
      core_fraction = 20
    }

    boot_disk {
      initialize_params {
        image_id = "fd8vmcue7aajpmeo39kk" # Ubuntu 20.04 LTS
        size     = 10
        type     = "network-hdd"
      }
    }

    network_interface {
      network_id = yandex_vpc_network.k8s-network.id
      subnet_ids = [
        yandex_vpc_subnet.k8s-subnet-1.id,
        yandex_vpc_subnet.k8s-subnet-2.id,
        yandex_vpc_subnet.k8s-subnet-3.id,
      ]
      # Флаг nat true указывает что виртуалкам будет предоставлен публичный IP адрес.
      nat = true
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_rsa.pub")}"
    }
    network_settings {
      type = "STANDARD"
    }
  }

  scale_policy {
    fixed_scale {
      size = 2
    }
  }

  allocation_policy {
    zones = [
      "ru-central1-a",
      "ru-central1-b",
      "ru-central1-d",
    ]
  }

  deploy_policy {
    max_unavailable = 2
    max_creating    = 2
    max_expansion   = 2
    max_deleting    = 2
  }
}