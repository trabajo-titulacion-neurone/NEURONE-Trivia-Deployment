# Trivia deployment using Ansible
This folder contains configuration files to run an Ansible playbook and configure one or multiple servers so that Trivia deployment. The following steps outline the necessary process to execute this playbook.

## Prerequisites
* [Ansible: Ensure that Ansible is installed on your local machine.](https://docs.ansible.com/ansible/latest/installation_guide/index.html)

* Public SSH Key of Local Host: Ensure that the public SSH key of your local machine is authorized on the server you wish to connect to.

## Running the Ansible Playbook
Open the inventory.yaml file in a text editor:
```bash
nano inventory.yaml
```

* Adjust the value of the ansible_host property into the webservers group with the IP address of the server you wish to connect to.
* Adjust the value of the ansible_user property into the webservers group with the authorized username for the server you wish to connect to.
```yaml
webservers:
  hosts:
    neurone-trivia-dev:
      ansible_host: <SERVER_IP_ADDRESS>
      ansible_user: <SERVER_USERNAME>

  vars:
    ansible_python_interpreter: /usr/bin/python3
```
Run the playbook using the following command:
```bash
ansible-playbook -i inventory.yaml playbook.yaml
```
The playbook will execute and configure the server according to the specifications provided in the configuration files.

## Additional Notes

* Ensure that the user specified in the inventory.yaml file has appropriate permissions to perform the tasks specified in the playbook.
* You can customize the playbook to fit your needs by editing the playbook.yaml file. For more information, refer to the [official Ansible documentation](https://docs.ansible.com/).
