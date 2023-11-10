# Infrastructure Deployment on DigitalOcean with Terraform

This folder contains Terraform configurations to deploy and manage the application infrastructure.

## Prerequisites

Before you begin, make sure you have the following requirements installed or created:

- [Terraform](https://www.terraform.io/downloads.html)
- [Account on DigitalOcean](https://www.digitalocean.com/)
- [DigitalOcean API Token](https://www.digitalocean.com/docs/apis-clis/api/create-personal-access-token/)

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
  default     = "your-digitalocean-api-token-here"
}

```

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
* Within the variables.tf file, you can change the value of the default property of the variables as you see fit to configure your infrastructure, such as the droplet name, size, region, etc. For more information, refer to the DigitalOcean documentation.
