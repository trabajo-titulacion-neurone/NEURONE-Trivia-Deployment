# NEURONE Trivia Deployment

This repository contains files and instructions for the automated deployment of the NEURONE Trivia system.

## Terraform Files

The "terraform-files" folder includes Terraform files and scripts for the automated creation of a DigitalOcean droplet. These files facilitate the necessary infrastructure for deploying NEURONE Trivia.

If you need to create a virtual private server to deploy the system. Access this folder with the following command and follow the instructions inside.

```bash
cd terraform-files
```
If you have a server to deploy the system or want to deploy it in a local environment, you can discard this step. 


## Ansible Files

The "ansible-files" folder contains Ansible files and scripts for deploying NEURONE Trivia on a local machine or on a remote server.

To deploy Trivia, access this folder with the following command and follow the instructions inside.

```bash
cd ansible-files
```


This folder facilitates the automated deployment of the NEURONE Trivia system. Below, you'll find an overview of the roles executed in the "ansible-files" folder.

### Ansible Roles Overview

1. **update-upgrade-packages:**
   - Ensures the underlying server's operating system is up-to-date with the latest security patches and improvements.

2. **docker-installation:**
   - Facilitates the installation of Docker on the server along with necessary dependencies for NEURONE's core execution.

3. **reboot and wait:**
   - Manages a controlled server reboot and waits for it to come back online.

4. **add-swap-space:**
   - Manages the creation and configuration of swap space on the server.

5. **node-with-nvm:**
   - Installs and activates a specific version of Node.js using Node Version Manager (NVM).
   - Installs global Node packages, such as Angular and PM2.

6. **mongodb:**
   - Installs and configures MongoDB on the server.

7. **mongodb_users:**
   - Configures users for the MongoDB database, ensuring the presence of necessary users for Trivia and NEURONE-GM.

8. **NEURONE-Core:**
   - Installs the NEURONE core on the server.

9. **neurone-gm:**
   - Deploys NEURONE-GM on the server using PM2.
   - Retrieves the list of running processes with PM2 in case of system restart.

10. **GAME-production/GAME-localhost:**
    - Deploys Trivia Server using PM2.
    - Builds the compiled version of the frontend if necessary.
    - Depending on the playbook executed, Trivia can be deployed locally or to production (requires a registered domain).

11. **nginx:**
    - Implements and configures Nginx, including various server setups and reverse proxies.

12. **firewall-with-ufw:**
    - Installs and configures the firewall using Uncomplicated Firewall (UFW) on the server.
