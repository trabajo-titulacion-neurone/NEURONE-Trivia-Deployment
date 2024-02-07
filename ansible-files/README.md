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
   - In this case, deployment is carried out on a remote server with a user authorized to execute actions with superuser privileges on the server. Depending on the type of deployment, these can be divided into 2 types.
     
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
Before executing the playbook, you must configure the inventory file with the necessary data to connect to the server.

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

Run the playbook to deploy NEURONE Trivia on a development server using the following command with the "-K" flag to input the sudo (Become) password via terminal when prompted:

```bash
ansible-playbook deploy-dev-server.yaml -i inventory.yaml -K
```
The playbook will execute and configure the server according to the specifications provided in the configuration files.

## Deployment on a production server
In this case, deployment takes place on a production server. Being of this type, an nginx server is set up to listen to HTTPS requests and obtain SSL certificates for the website. Therefore, it is necessary to have a registered and configured domain pointing to the production server for this purpose.
Once this is done, it is necessary to modify the playbook to enter the domain data. In this case, the variables of the nginx role must be modified in this way.

```yaml

 # Installation of Nginx
 - {role: nginx,
     http_connection: false,
     https_connection: true,
     domain_name: "DOMAIN_NAME",
     email: "EMAIL_DOMAIN"
 }
```
Where you should replace DOMAIN_NAME and EMAIL_DOMAIN with the domain you have and the email associated with it, respectively.

After this, it is necessary to modify the files located within the GAME-production role. Therefore, you should access this directory. First, open the config.js file with a text editor.

```bash
nano roles/GAME-production/files/config.js
```
Modify the file as follows.
```javascript

//ROOT
process.env.ROOT = 'https://DOMAIN_NAME';

//PORT
process.env.PORT = process.env.PORT || 3001;

//PUBLIC PORT
process.env.PUBLIC_PORT = 3001;

//token secret
process.env.TOKEN_SECRET = 'ady7asdy78'

//DB
process.env.DB_USER = 'neuroneAdmin';

process.env.DB_PWD = 'DK,V-Dk6-*Pd-PM'
process.env.URI = "mongodb://localhost:27017";
process.env.USERURI = `mongodb://localhost:27017/neuronegameuser`;

//NEURONE GM
process.env.NEURONEGM = 'https://DOMAIN_NAME:3007';

//NEURONE GAME CLIENT
process.env.GAME_CLIENT = 'https://DOMAIN_NAME';

//NEURONE URL
process.env.NEURONE_URL = 'http://localhost:3000/';


// NEURONE DOCS path
process.env.NEURONE_DOCS = '/home/neurone/neuroneAssets'

//TIMEZONE
process.env.TZ = 'America/Santiago';
```
Where you should replace the value of DOMAIN_NAME with the domain name you have registered and want to associate with Trivia.

Next, open the environment.ts file with a text editor.
```bash
nano roles/GAME-production/files/environment.ts
```

Modify the file as follows.
```javascript

// This file can be replaced during build by using the `fileReplacements` array.
// `ng build --prod` replaces `environment.ts` with `environment.prod.ts`.
// The list of file replacements can be found in `angular.json`.

export const environment = {
  production: false,
  serverRoot: 'https://DOMAIN_NAME/',
  apiURL: 'https://DOMAIN_NAME/api/',
  frontURL: 'https://DOMAIN_NAME/',
  neuroneURL: 'http://localhost:3000/',
  locale: 'es-CL'
};

/*
 * For easier debugging in development mode, you can import the following file
 * to ignore zone related error stack frames such as `zone.run`, `zoneDelegate.invokeTask`.
 *
 * This import should be commented out in production mode because it will have a negative impact
 * on performance if an error is thrown.
 */
// import 'zone.js/dist/zone-error';  // Included with Angular CLI.
```
Where you should replace the value of DOMAIN_NAME with the registered domain name.

Next, open the environment.prod.ts file with a text editor.
```bash
nano roles/GAME-production/files/environment.prod.ts
```
```javascript
export const environment = {
  production: true,
  serverRoot: 'https://DOMAIN_NAME/',
  apiURL: 'https://DOMAIN_NAME/api/',
  frontURL: 'https://DOMAIN_NAME/',
  neuroneURL: 'http://localhost:3000/',
  locale: 'es-CL'
};
```
Where you should replace the value of DOMAIN_NAME with the registered domain name.

After this, it is necessary to edit the nginx configuration file to successfully deploy in production. To do this, navigate to the directory where this file is stored within the nginx role and open it with a text editor.
```bash
nano roles/nginx/templates/game_https.conf
```

And modify the file as follows.
```nginx
# HTTP Server (redirect to HTTPS)
server {
  listen         80;
  server_tokens  off;
  server_name    DOMAIN_NAME;  # Customize the target subdomains
  return         301 https://DOMAIN_NAME$request_uri;
}

# NEURONE-Trivia
server {
  listen         443 ssl default_server;
  server_tokens  off;
  server_name    DOMAIN_NAME;  # Customize the target subdomains
  error_log      /var/log/nginx/trivia.error.log warn;  # Customize the error log location

  client_max_body_size 50M;

  location / {
    proxy_pass http://localhost:3001;  # Customize the app's local port
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_buffers 4 256k;
    proxy_buffer_size 128k;
    proxy_busy_buffers_size 256k;
  }

  ssl_certificate /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem;  # Customize certificate location
  ssl_certificate_key /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem;  # Customize certificate location
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
  ssl_session_timeout 5m;
}

# NEURONE-Core
server {
  listen         3005 ssl;
  server_tokens  off;
  server_name    DOMAIN_NAME;  # Customize the target subdomains
  error_log      /var/log/nginx/core.error.log warn;  # Customize the error log location

  client_max_body_size 50M;

  location / {
    proxy_pass http://localhost:3000;  # Customize the app's local port
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_buffers 4 256k;
    proxy_buffer_size 128k;
    proxy_busy_buffers_size 256k;
  }

  ssl_certificate /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem;  # Customize certificate location
  ssl_certificate_key /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem;  # Customize certificate location
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
  ssl_session_timeout 5m;
}

# NEURONE-GM
server {
  listen         3007 ssl;
  server_tokens  off;
  server_name    DOMAIN_NAME;  # Customize the target subdomains
  error_log      /var/log/nginx/gm.error.log warn;  # Customize the error log location

  client_max_body_size 50M;

  location / {
    proxy_pass http://localhost:3002;  # Customize the app's local port
    proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
    proxy_set_header Host $http_host;
    proxy_set_header X-Forwarded-Proto $scheme;
    proxy_buffers 4 256k;
    proxy_buffer_size 128k;
    proxy_busy_buffers_size 256k;
  }

  ssl_certificate /etc/letsencrypt/live/DOMAIN_NAME/fullchain.pem;  # Customize certificate location
  ssl_certificate_key /etc/letsencrypt/live/DOMAIN_NAME/privkey.pem;  # Customize certificate location
  ssl_protocols TLSv1 TLSv1.1 TLSv1.2;
  ssl_prefer_server_ciphers on;
  ssl_ciphers 'EECDH+AESGCM:EDH+AESGCM:AES256+EECDH:AES256+EDH';
  ssl_session_timeout 5m;
}
```
Where you should replace the value of DOMAIN_NAME with the registered domain name.

Finally, run the playbook to deploy NEURONE Trivia on a production server using the following command with the "-K" flag to input the sudo (Become) password via terminal when prompted:

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
