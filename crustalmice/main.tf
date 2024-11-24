terraform {
  required_providers {
    incus = {
      source = "lxc/incus"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "crustalmice"
  name  = "crustalmice"

  config = {
    "boot.autostart" = false
  }


}
