This is a guide to use Ansible to build an Hyperledger Fabric environments

#Steps to use:
1. Install Ansible[Ansible Installtion](http://docs.ansible.com/ansible/latest/intro_installation.html)
2. Create hosts file in /etc/ansible/hosts, and put server informatino in here:
```
[fabric]
47.93.9.187 ansible_ssh_user=root
```
3. Then configure the SSH commands:

```
 ssh username@hostname
 ssh-agent bash
 ssh-add ~/.ssh/id_rsa
 ssh-copy-id -i ~/.ssh/id_rsa.pub user@hostname
```
4. After configure the SSH releated accounts and setting,  Ansbile can be run as below:
  ```
  ansible-play ./sites.yml
  ```
  It will go and configure the target server with Hyperledger Fabric basic settings.
