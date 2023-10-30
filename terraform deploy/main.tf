terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = "dop_v1_d1c40f236bfa30db462480632582c1fc38bde6b682f4080ce60a30b688f4d5d9"
}

resource "digitalocean_droplet" "mi_droplet" {
  image  = "ubuntu-22-04-x64"
  name   = "mi-droplet"
  region = "nyc1"
  size   = "s-1vcpu-1gb"
  ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
}


# resource "digitalocean_droplet" "mi_droplet_2" {
#   image  = "ubuntu-22-04-x64"
#   name   = "mi-droplet"
#   region = "nyc1"
#   size   = "s-1vcpu-1gb"
#   ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
# }

# resource "digitalocean_droplet" "mi_droplet_3" {
#   image  = "ubuntu-22-04-x64"
#   name   = "mi-droplet"
#   region = "nyc1"
#   size   = "s-1vcpu-1gb"
#   ssh_keys = ["dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"]
# }

