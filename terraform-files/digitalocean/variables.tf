variable "token_digitalocean" {
  description = "Token to connect to your DigitalOcean account"
  type    = string
  default = "dop_v1_5563409e7afdc5757de6234f96882d4983b9ec9b62365ac05fb1f8fa664ad57a"
}

variable "fingerprint_ssh_key_digitalocean" {
  description = "Fingerprint of the saved SSH key associated with your DigitalOcean account"
  type    = string
  default = "dd:ca:b2:21:ed:6e:47:dd:12:22:58:c2:58:5d:77:e6"
}

# variable "ssh_key_name_digitalocean" {
#   description = "Name of the SSH key associated with the DigitalOcean account"
#   type    = string
#   default = "local_public_key"
# }

# variable "ssh_public_key_path" {
#   description = "Path to the public SSH key file of the local host"
#   type    = string
#   default = "~/.ssh/id_rsa.pub"
# }

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
