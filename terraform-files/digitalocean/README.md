# Infrastructure Deployment on DigitalOcean with Terraform

This folder contains Terraform configurations to deploy and manage the application infrastructure.

## Prerequisites

Before you begin, make sure you have the following requirements installed or created:

- [Terraform](https://www.terraform.io/downloads.html)
- [Account on DigitalOcean](https://www.digitalocean.com/)
- [DigitalOcean API Token](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)
- [SSH Key on DigitalOcean Account](https://docs.digitalocean.com/products/droplets/how-to/add-ssh-keys/to-team/)

## Configuration
Open the variables.tf file in a text editor:
```bash
nano variables.tf
```
Locate the digitalocean_token variable and replace the default value with your API token and save the file:
```hcl
variable "digitalocean_token" {
  description = "DigitalOcean API Token"
  type        = string
  default     = "<DIGITALOCEAN_API_TOKEN>"
}
```
Then, locate the fingerprint_ssh_key_digitalocean variable and replace the default value with your Fingerprint or ID of your ssh key stored on your digitalocean account and save the file.
```hcl
variable "fingerprint_ssh_key_digitalocean" {
  description = "Fingerprint of the saved SSH key associated with your DigitalOcean account"
  type    = string
  default = "<FINGERPRINT_SSH_KEY_DIGITALOCEAN>"
}

```
Remember that this public key must be from the local machine from which you want to connect to the server created later.

## Usage
* Initialize Terraform
```bash
terraform init
```

* Visualize planned changes:
```bash
terraform plan
```

* Apply the changes:
```bash
terraform apply
```
Confirm with yes when prompted.

## Clean Up
To destroy the created infrastructure:
```bash
terraform destroy
```
Confirm with yes when prompted.

## Additional Notes
* Be cautious with sensitive information like tokens and keys, and avoid accidentally sharing confidential data in the repository.
* Within the variables.tf file, you can change the value of the default property of the variables as you see fit to configure your infrastructure, such as the droplet name, size, region, etc. For more information, you can see the list of options on [DigitalOcean API Slugs](https://slugs.do-api.dev/) or you can check the [DigitalOcean API documentation](https://docs.digitalocean.com/reference/api/api-reference/).
