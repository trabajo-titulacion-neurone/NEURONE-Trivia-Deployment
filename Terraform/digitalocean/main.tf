terraform {
  required_providers {
    digitalocean = {
      source = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}


provider "digitalocean" {
  token = var.token_digitalocean
}

# Create a new SSH key
resource "digitalocean_ssh_key" "local_public_key" {
  name       = var.ssh_key_name_digitalocean
  public_key = file(var.ssh_public_key_path)
}

resource "digitalocean_droplet" "mi_droplet" {
  image  = var.droplet_image
  name   = var.droplet_name
  region = var.droplet_region
  size   = var.droplet_size
  ssh_keys = [digitalocean_ssh_key.local_public_key.fingerprint]

}

