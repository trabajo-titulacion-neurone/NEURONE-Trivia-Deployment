variable "token_digitalocean" {
  description = "Token to connect to DigitalOcean account"
  type    = string
  default = ""
}

variable "ssh_key_name_digitalocean" {
  description = "Name of the SSH key associated with the DigitalOcean account"
  type    = string
  default = "local_public_key"
}

variable "ssh_public_key_path" {
  description = "Path to the public SSH key file of the local host"
  type    = string
  default = "~/.ssh/id_rsa.pub"
}

variable "droplet_image" {
  description = "Image of the droplet to be created."
  type    = string
  default = "ubuntu-22-04-x64"
}

variable "droplet_name" {
  description = "Name of the droplet to be created."
  type    = string
  default = "trivia-neurone-server"
}

variable "droplet_region" {
  description = "Region of the droplet to be created."
  type    = string
  default = "nyc1"
}


variable "droplet_size" {
  description = "Region of the droplet to be created."
  type    = string
  default = "s-1vcpu-2gb"
}
