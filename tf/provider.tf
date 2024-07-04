# Provider

terraform {
  required_providers {
    yandex = {
      source  = "yandex-cloud/yandex"
      version = "0.123.0"
    }
  }
}

provider "yandex" {
  token     = "y0_AgAAAABTQ96pAATuwQAAAAEJKDY0AACEYbhmHUFDuaoaYiTkF_aAHHrkDA"
  cloud_id  = "b1gfgck1dqap664jlvns"
  folder_id = "b1g0trqf8k43la7c5tqd"
}