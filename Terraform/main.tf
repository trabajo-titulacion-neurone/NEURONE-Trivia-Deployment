terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = "dop_v1_385b86f39ebd05776216e288504e23879827100a6fb3aa6f9fdfa14b5ca19d95"
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

