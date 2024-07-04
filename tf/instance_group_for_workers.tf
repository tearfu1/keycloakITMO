# Compute instance group for workers

resource "yandex_compute_instance_group" "k8s-workers" {
  name               = "k8s-workers"
  service_account_id = yandex_iam_service_account.admin.id
  depends_on = [
    yandex_iam_service_account.admin,
    yandex_resourcemanager_folder_iam_binding.editor,
    yandex_vpc_network.k8s-network,
    yandex_vpc_subnet.k8s-subnet-1,
  ]

  instance_template {

    name = "worker-{instance.index}"

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
      ]
      # Флаг nat true указывает что виртуалкам будет предоставлен публичный IP адрес.
      nat = true
    }

    metadata = {
      ssh-keys = "ubuntu:${file("~/.ssh/id_ed25519.pub")}"
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
    ]
  }

  deploy_policy {
    max_unavailable = 3
    max_creating    = 3
    max_expansion   = 3
    max_deleting    = 3
  }
}