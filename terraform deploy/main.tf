terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = "dop_v1_6c54faf2c909033bc63dcce1a4a97fbc519647c884d8ec324b3a2a673659ac52"
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

