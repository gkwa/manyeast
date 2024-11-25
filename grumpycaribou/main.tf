terraform {
  required_providers {
    incus = {
      source  = "lxc/incus"
      version = ">= 0.2.0"
    }
  }
}

resource "incus_instance" "instance1" {
  image = "{{ .OutputImage2 }}"
  name  = "{{ .Container2Name }}"

  config = {
    "boot.autostart" = false
  }
}
