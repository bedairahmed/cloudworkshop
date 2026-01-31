# Ansible Cheatsheet

## What is Ansible?

Ansible is an open-source automation tool for configuration management, application deployment, and infrastructure orchestration. It uses simple YAML files called "playbooks" to describe automation tasks and connects to remote machines over SSH without requiring agents.

---

## Why Use Ansible?

- **Agentless** - No software to install on managed nodes
- **Simple** - Uses YAML syntax, easy to learn
- **Idempotent** - Safe to run multiple times
- **Powerful** - Manage thousands of servers
- **Extensible** - Large collection of modules
- **Cross-Platform** - Linux, Windows, cloud, network devices

---

## Key Concepts

| Concept | Description |
|---------|-------------|
| **Control Node** | Machine where Ansible runs |
| **Managed Node** | Servers being managed |
| **Inventory** | List of managed nodes |
| **Playbook** | YAML file with automation tasks |
| **Play** | Maps hosts to tasks |
| **Task** | Single unit of work |
| **Module** | Code that performs a task |
| **Role** | Reusable collection of tasks |
| **Handler** | Task triggered by notifications |
| **Facts** | Information gathered about nodes |

---

## Installation

### pip (Recommended)

```bash
# Install Ansible
pip install ansible

# Or with specific version
pip install ansible==8.0.0
```

### Linux (Ubuntu/Debian)

```bash
sudo apt update
sudo apt install ansible
```

### Mac

```bash
brew install ansible
```

### Verify Installation

```bash
ansible --version
```

---

## Inventory

### Basic Inventory (hosts.ini)

```ini
# Single hosts
webserver1.example.com
webserver2.example.com

# Group of hosts
[webservers]
web1.example.com
web2.example.com
web3.example.com

[databases]
db1.example.com
db2.example.com

# Group of groups
[production:children]
webservers
databases

# Host variables
[webservers]
web1.example.com ansible_port=2222 ansible_user=admin
web2.example.com http_port=8080

# Group variables
[webservers:vars]
ansible_user=deploy
ansible_ssh_private_key_file=~/.ssh/deploy_key
```

### YAML Inventory (hosts.yml)

```yaml
all:
  children:
    webservers:
      hosts:
        web1.example.com:
          ansible_port: 22
          http_port: 80
        web2.example.com:
          http_port: 8080
      vars:
        ansible_user: deploy
        
    databases:
      hosts:
        db1.example.com:
        db2.example.com:
      vars:
        ansible_user: dbadmin
        
    production:
      children:
        webservers:
        databases:
```

### Dynamic Inventory

```bash
# Use script or plugin
ansible-inventory -i aws_ec2.yml --list

# Azure dynamic inventory (azure_rm.yml)
plugin: azure.azcollection.azure_rm
auth_source: auto
include_vm_resource_groups:
  - my-resource-group
```

---

## Ad-Hoc Commands

```bash
# Ping all hosts
ansible all -m ping

# Ping specific group
ansible webservers -m ping

# Run command
ansible all -m command -a "uptime"
ansible all -a "uptime"  # command is default

# Run shell command (supports pipes)
ansible all -m shell -a "cat /etc/passwd | grep root"

# Copy file
ansible all -m copy -a "src=file.txt dest=/tmp/file.txt"

# Install package
ansible webservers -m apt -a "name=nginx state=present" --become

# Start service
ansible webservers -m service -a "name=nginx state=started" --become

# Gather facts
ansible webservers -m setup

# Run with specific inventory
ansible -i hosts.ini all -m ping

# Run with sudo
ansible all -m command -a "whoami" --become

# Limit to specific host
ansible all -m ping --limit web1.example.com

# Check mode (dry run)
ansible all -m command -a "uptime" --check
```

---

## Playbooks

### Basic Playbook

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
        update_cache: yes
    
    - name: Start nginx service
      service:
        name: nginx
        state: started
        enabled: yes
    
    - name: Copy index.html
      copy:
        src: files/index.html
        dest: /var/www/html/index.html
        owner: www-data
        group: www-data
        mode: '0644'
```

### Run Playbook

```bash
# Run playbook
ansible-playbook playbook.yml

# With inventory file
ansible-playbook -i hosts.ini playbook.yml

# Check mode (dry run)
ansible-playbook playbook.yml --check

# Verbose output
ansible-playbook playbook.yml -v
ansible-playbook playbook.yml -vvv

# Limit to hosts
ansible-playbook playbook.yml --limit webservers

# Start at specific task
ansible-playbook playbook.yml --start-at-task "Install nginx"

# List tasks
ansible-playbook playbook.yml --list-tasks

# List hosts
ansible-playbook playbook.yml --list-hosts
```

---

## Variables

### Defining Variables

```yaml
---
- name: Example with variables
  hosts: webservers
  
  # Play-level variables
  vars:
    http_port: 80
    app_name: myapp
    packages:
      - nginx
      - python3
      - git
  
  # Variables from file
  vars_files:
    - vars/common.yml
    - vars/{{ env }}.yml
  
  tasks:
    - name: Print variable
      debug:
        msg: "Port is {{ http_port }}"
    
    - name: Install packages
      apt:
        name: "{{ packages }}"
        state: present
```

### Variable Files (vars/common.yml)

```yaml
---
app_name: myapplication
app_version: "1.2.3"
app_user: appuser

database:
  host: localhost
  port: 5432
  name: mydb
```

### Using Variables

```yaml
tasks:
  - name: Create config file
    template:
      src: app.conf.j2
      dest: "/etc/{{ app_name }}/app.conf"
  
  - name: Connect to database
    debug:
      msg: "Connecting to {{ database.host }}:{{ database.port }}"
```

### Variable Precedence (lowest to highest)

1. Role defaults
2. Inventory vars
3. Playbook vars
4. Role vars
5. Task vars
6. Extra vars (`-e`)

---

## Conditionals

```yaml
tasks:
  - name: Install on Debian
    apt:
      name: nginx
      state: present
    when: ansible_os_family == "Debian"
  
  - name: Install on RedHat
    yum:
      name: nginx
      state: present
    when: ansible_os_family == "RedHat"
  
  - name: Multiple conditions
    command: echo "Production Debian"
    when:
      - ansible_os_family == "Debian"
      - env == "production"
  
  - name: OR condition
    command: echo "Debian or Ubuntu"
    when: ansible_distribution == "Debian" or ansible_distribution == "Ubuntu"
  
  - name: Check variable defined
    debug:
      msg: "Variable is defined"
    when: my_var is defined
  
  - name: Check variable value
    debug:
      msg: "Feature enabled"
    when: feature_enabled | bool
```

---

## Loops

```yaml
tasks:
  # Simple loop
  - name: Install packages
    apt:
      name: "{{ item }}"
      state: present
    loop:
      - nginx
      - python3
      - git
  
  # Loop with dict
  - name: Create users
    user:
      name: "{{ item.name }}"
      groups: "{{ item.groups }}"
      state: present
    loop:
      - { name: 'alice', groups: 'admin' }
      - { name: 'bob', groups: 'developers' }
  
  # Loop with index
  - name: Create files
    copy:
      content: "File {{ index }}"
      dest: "/tmp/file{{ index }}.txt"
    loop: "{{ range(1, 5) | list }}"
    loop_control:
      index_var: index
  
  # Loop over dictionary
  - name: Set environment variables
    lineinfile:
      path: /etc/environment
      line: "{{ item.key }}={{ item.value }}"
    loop: "{{ env_vars | dict2items }}"
```

---

## Handlers

```yaml
---
- name: Configure nginx
  hosts: webservers
  become: yes
  
  tasks:
    - name: Install nginx
      apt:
        name: nginx
        state: present
    
    - name: Copy nginx config
      template:
        src: nginx.conf.j2
        dest: /etc/nginx/nginx.conf
      notify: Restart nginx
    
    - name: Copy site config
      template:
        src: site.conf.j2
        dest: /etc/nginx/sites-available/default
      notify:
        - Validate nginx config
        - Restart nginx
  
  handlers:
    - name: Validate nginx config
      command: nginx -t
    
    - name: Restart nginx
      service:
        name: nginx
        state: restarted
```

---

## Templates (Jinja2)

### Template File (templates/nginx.conf.j2)

```jinja2
# Nginx configuration
# Generated by Ansible - Do not edit manually

worker_processes {{ ansible_processor_cores }};

events {
    worker_connections {{ worker_connections | default(1024) }};
}

http {
    server {
        listen {{ http_port }};
        server_name {{ server_name }};
        
        root {{ document_root }};
        
        {% for location in locations %}
        location {{ location.path }} {
            proxy_pass {{ location.backend }};
        }
        {% endfor %}
        
        {% if ssl_enabled %}
        listen 443 ssl;
        ssl_certificate {{ ssl_cert_path }};
        ssl_certificate_key {{ ssl_key_path }};
        {% endif %}
    }
}
```

### Using Templates

```yaml
tasks:
  - name: Deploy nginx config
    template:
      src: nginx.conf.j2
      dest: /etc/nginx/nginx.conf
      owner: root
      group: root
      mode: '0644'
      validate: nginx -t -c %s
```

---

## Roles

### Role Structure

```
roles/
└── webserver/
    ├── tasks/
    │   └── main.yml
    ├── handlers/
    │   └── main.yml
    ├── templates/
    │   └── nginx.conf.j2
    ├── files/
    │   └── index.html
    ├── vars/
    │   └── main.yml
    ├── defaults/
    │   └── main.yml
    └── meta/
        └── main.yml
```

### Role Tasks (roles/webserver/tasks/main.yml)

```yaml
---
- name: Install nginx
  apt:
    name: nginx
    state: present
    update_cache: yes

- name: Copy config
  template:
    src: nginx.conf.j2
    dest: /etc/nginx/nginx.conf
  notify: Restart nginx

- name: Ensure nginx is running
  service:
    name: nginx
    state: started
    enabled: yes
```

### Using Roles

```yaml
---
- name: Configure web servers
  hosts: webservers
  become: yes
  
  roles:
    - webserver
    - { role: database, when: install_db | bool }
    - role: monitoring
      vars:
        monitor_port: 9090
```

### Install Roles from Galaxy

```bash
# Install role
ansible-galaxy install geerlingguy.nginx

# Install from requirements file
ansible-galaxy install -r requirements.yml

# requirements.yml
---
roles:
  - name: geerlingguy.nginx
    version: "3.1.0"
  - name: geerlingguy.docker
```

---

## Common Modules

### File Management

```yaml
# Copy file
- copy:
    src: file.txt
    dest: /tmp/file.txt
    owner: root
    mode: '0644'

# Template
- template:
    src: config.j2
    dest: /etc/app/config.conf

# Create directory
- file:
    path: /var/app
    state: directory
    mode: '0755'

# Create symlink
- file:
    src: /etc/nginx/sites-available/default
    dest: /etc/nginx/sites-enabled/default
    state: link

# Download file
- get_url:
    url: https://example.com/file.tar.gz
    dest: /tmp/file.tar.gz
    checksum: sha256:abc123...

# Unarchive
- unarchive:
    src: /tmp/file.tar.gz
    dest: /opt/app
    remote_src: yes
```

### Package Management

```yaml
# APT (Debian/Ubuntu)
- apt:
    name: nginx
    state: present
    update_cache: yes

# YUM (RHEL/CentOS)
- yum:
    name: nginx
    state: present

# pip
- pip:
    name: flask
    state: present
    virtualenv: /opt/app/venv
```

### Service Management

```yaml
- service:
    name: nginx
    state: started    # started, stopped, restarted, reloaded
    enabled: yes

- systemd:
    name: nginx
    state: started
    daemon_reload: yes
```

### User Management

```yaml
- user:
    name: deploy
    groups: sudo,docker
    shell: /bin/bash
    create_home: yes
    ssh_key_file: ~/.ssh/id_rsa

- authorized_key:
    user: deploy
    key: "{{ lookup('file', '~/.ssh/id_rsa.pub') }}"
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `ansible all -m ping` | Ping all hosts |
| `ansible-playbook play.yml` | Run playbook |
| `ansible-playbook play.yml -C` | Dry run |
| `ansible-playbook play.yml -v` | Verbose |
| `ansible-playbook play.yml -e var=val` | Extra vars |
| `ansible-inventory --list` | Show inventory |
| `ansible-galaxy install role` | Install role |
| `ansible-vault create file` | Create encrypted file |
| `ansible-vault edit file` | Edit encrypted file |
| `ansible-doc module` | Module documentation |

---

## Resources

- [Ansible Documentation](https://docs.ansible.com/)
- [Ansible Galaxy](https://galaxy.ansible.com/)
- [Ansible Examples](https://github.com/ansible/ansible-examples)