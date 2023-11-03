terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = ""
}

resource "digitalocean_droplet" "mi_droplet" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-2gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}


# resource "digitalocean_droplet" "mi_droplet_3" {
#   image  = "ubuntu-22-04-x64"
#   name   = "mi-droplet"
#   region = "nyc1"
#   size   = "s-1vcpu-1gb"
#   ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
# }

