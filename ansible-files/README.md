# NEURONE Trivia deployment using Ansible
This folder contains configuration files to run an Ansible playbook and configure one or multiple servers so that Trivia deployment. The following steps outline the necessary process to execute this playbook.

## Prerequisites
* [Ansible: Ensure that Ansible is installed on your local machine.](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

* Public SSH Key of Local Host: Ensure that the public SSH key of your local machine is authorized on the server you wish to connect to.

## Resume
This directory contains 3 playbooks to deploy the NEURONE Trivia system depending on the requirements. These deployment types are:

1. **[Local machine deployment](#local-machine-deployment):**
   - In this case, a deployment is carried out in a local environment, specifically in the environment where the playbook is executed.
  
2. **[Deployment on a remote server](#deployment-on-a-remote-server):**
   - En este caso se realiza un despliegue en un servidor remoto with a user authorized to perform actions with superuser privileges on the server. Depending on the type of deployment, these can be divided into 2 types.
     
   - **Deployment on a development server:**
        - In this case, deployment occurs on a remote server with a user authorized to perform actions in superuser mode on the server. As it is a development server, an                nginx server is set up to only listen to HTTP requests.
   - **Deployment on a development server:**
        - Here, the deployment occurs on a remote server with a user authorized to execute superuser actions. As it's a production server, an nginx server is set up to       handle HTTPS requests and obtain SSL certificates for the website. Hence, a registered and configured domain pointing to the production server is necessary for this setup.


## Local machine deployment
To deploy the system in a local environment, you must do it with a user that has superuser privileges. Then, run the playbook using the following command with the "-K" flag to input the sudo (Become) password via the terminal when prompted:

```bash
ansible-playbook localhost-deploy.yaml -K --extra-vars "ansible_user=USERNAME"
```
Where you should replace USERNAME with the name of the operating system user that will execute the playbook. You can check your username using the following command if you are on Ubuntu.

```bash
whoami
```

## Deployment on a remote server
To deploy the system in a remote server, es necesario contar con los siguientes requisitos:
1. **[Have a user with superuser privileges](#create-user-on-server-with-superuser-privileges):** Create User on Server with superuser privileges.

2. **[Enable password authentication on the server](#enable-password-authentication):**

3. **[Have an SSH key pair authorized by the server](#add-local-SSH-Key-to-authorized-keys-on-server):**

### Configurar archivo de inventario
Antes de ejecutar el playbook debe configurar el archivo de inventario con los datos necesarios para conectarse al servidor.

Open the inventory.yaml file in a text editor:
```bash
nano inventory.yaml
```

- Adjust the value of the ansible_host property into the webservers group with the IP address of the server you wish to connect to.
- Adjust the value of the ansible_user property into the webservers group with the authorized username for the server you wish to connect to.
```yaml
webservers:
  hosts:
    neurone-trivia-dev:
      ansible_host: <SERVER_IP_ADDRESS>
      ansible_user: <SERVER_USERNAME>

  vars:
    ansible_python_interpreter: /usr/bin/python3
```
## Deployment on a development server

Ejecute el playbook para desplegar NEURONE Trivia en un servidor de desarrollo using the following command with the "-K" flag to input the sudo (Become) password via the terminal when prompted:

```bash
ansible-playbook deploy-dev-server.yaml -i inventory.yaml -K
```
The playbook will execute and configure the server according to the specifications provided in the configuration files.

## Deployment on a production server
En este caso se realiza un despliegue en un servidor de producción. Al ser de este tipo, se monta un servidor de nginx el cual escucha solicitudes del tipo HTTPS y obtiene certificados SSL para el sitio web. Por lo tanto para esto es necesario contar con un dominio registrado y configurado para que apunte hacia el servidor de producción. 
Una vez hecho esto es necesario modificar el playbook para introducir los datos del dominio, en este caso se deben modificar las variables del rol nginx de esta manera.

```yaml

 # Installation of Nginx
 - {role: nginx,
     http_connection: false,
     https_connection: true,
     domain_name: "DOMAIN_NAME",
     email: "EMAIL_DOMAIN"
 }
```
Donde debe reemplazar DOMAIN_NAME y EMAIL_DOMAIN por el dominio con el cual se cuenta, y el email asociado a este mismo.

Finalmente, ejecute el playbook para desplegar NEURONE Trivia en un servidor de producción using the following command with the "-K" flag to input the sudo (Become) password via the terminal when prompted:

```bash
ansible-playbook deploy-prod-server.yaml -i inventory.yaml -K
```

## Additional Instrucctions

### Create User on Server with superuser privileges.
#### If you already have a username with superuser privileges you can skip these steps. 

You must log in to the server as root and execute the following command. 

Then enter the password for this user and optionally add other details such as full name, phone number, etc.
```bash
adduser <NEW_USERNAME>
```

Next, enable superuser permissions with sudo using the following command.
```bash
usermod -aG sudo <NEW_USERNAME>
```


### Enable Password Authentication
#### If you already have password enabled to connect to the desired server, you can skip these steps.
Open the SSH configuration file with a text editor.
```bash
nano /etc/ssh/sshd_config
```

Make sure the following lines are in the file, then save it and close it:
```hcl
PasswordAuthentication yes


KbdInteractiveAuthentication yes

```
Next, restart ssh service.
```bash
systemctl restart ssh
```

### Add local SSH Key to authorized keys on server
#### If your local machine's SSH key is already authorized by the server, you can skip these steps.  
If you don't have an SSH key pair, you can create one with the following command:
```bash
ssh keygen
```
Next, add your SSH key to the list of keys authorized by the server using ssh-copy-id, along with your username.

```bash
ssh-copy-id <SERVER_USERNAME>@<SERVER_IP_ADDRESS>
```
Then, enter the password associated with the user when prompted.

## Additional Notes

* Ensure that the user specified in the inventory.yaml file has appropriate permissions to perform the tasks specified in the playbook.
* You can customize the playbook to fit your needs by editing the playbook.yaml file. For more information, refer to the [official Ansible documentation](https://docs.ansible.com/).
