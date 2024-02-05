# NEURONE Trivia deployment using Ansible
This folder contains configuration files to run an Ansible playbook and configure one or multiple servers so that Trivia deployment. The following steps outline the necessary process to execute this playbook.

## Prerequisites
* [Ansible: Ensure that Ansible is installed on your local machine.](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

* Public SSH Key of Local Host: Ensure that the public SSH key of your local machine is authorized on the server you wish to connect to.

## Resumen
Este directorio contiene 3 playbooks para desplegar el sistema NEURONE Trivia dependiendo de la necesidad. Estos tipos de despliegues son:
1. **[Local machine deployment](#local-machine-deployment):**
   - En este caso se realiza un despliegue en un entorno local, especificamente en el entorno donde se ejecuta el playbook.
     
2. **Despliegue en servidor de desarrollo:**
   - En este caso se realiza un despliegue en un servidor remoto con un usuario el cual tiene autorización para ejecutar acciones en modo de superusuario en el servidor. Al ser un servidor de desarrollo se monta un servidor de nginx el cual escucha solo solicitudes del tipo HTTP.
     
3. **Despliegue en servidor de producción:**
   - En este caso se realiza un despliegue en un servidor remoto con un usuario el cual tiene autorización para ejecutar acciones en modo de superusuario en el servidor. Al ser un servidor de producción, se monta un servidor de nginx el cual escucha solicitudes del tipo HTTPS y obtiene certificados SSL para el sitio web. Por lo tanto para esto es necesario contar con un dominio registrado y configurado para que apunte hacia el servidor de producción. 


## Local machine deployment
To deploy the system in a local environment, you must do it with a user that has superuser privileges. Then, run the playbook using the following command with the "-K" flag to input the sudo (Become) password via the terminal when prompted:

```bash
ansible-playbook localhost-deploy.yaml -K --extra-vars "ansible_user=<USERNAME>"
```
Where you should replace <USERNAME> with the name of the operating system user that will execute the playbook. You can check your username using the following command if you are on Ubuntu.

```bash
whoami
```

## Despliegue en maquina loc











## Create User on Server and Enabled Password Authentication
#### If you already have a username and password enabled to connect to the desired server, you can skip these steps.

You must log in to the server as root and execute the following command. 

Then enter the password for this user and optionally add other details such as full name, phone number, etc.
```bash
adduser <NEW_USERNAME>
```

Next, enable superuser permissions with sudo using the following command.
```bash
usermod -aG sudo <NEW_USERNAME>
```

Next, open the SSH configuration file with a text editor.
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

## Add local SSH Key to authorized keys on server
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


## Running the Ansible Playbook
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
Run the playbook using the following command with the "-K" flag to input the sudo (Become) password via the terminal when prompted:
```bash
ansible-playbook -i inventory.yaml playbook.yaml -K
```
The playbook will execute and configure the server according to the specifications provided in the configuration files.

## Additional Notes

* Ensure that the user specified in the inventory.yaml file has appropriate permissions to perform the tasks specified in the playbook.
* You can customize the playbook to fit your needs by editing the playbook.yaml file. For more information, refer to the [official Ansible documentation](https://docs.ansible.com/).
