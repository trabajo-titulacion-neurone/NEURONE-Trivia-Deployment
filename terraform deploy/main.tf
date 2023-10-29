terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = "dop_v1_b9f75552f4d4c6681c4a33d694d33b509fb303ed10165a12716960a6882cef4a"
}

resource "digitalocean_droplet" "mi_droplet" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}
