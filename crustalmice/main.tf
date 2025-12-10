terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "1.0.1"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "{{.OutputImage}}"
  name  = "{{.OutputImage}}"

  config = {
    "boot.autostart" = false
  }
}
