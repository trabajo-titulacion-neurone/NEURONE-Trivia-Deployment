terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = "dop_v1_76d94347f12d7aaad9265faed1df732ecb5228c842bd86f17871541a588d43fa"
}

resource "digitalocean_droplet" "mi_droplet" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}


resource "digitalocean_droplet" "mi_droplet_2" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}

resource "digitalocean_droplet" "mi_droplet_3" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}

