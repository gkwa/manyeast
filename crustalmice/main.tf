terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = "0.3.0"
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
