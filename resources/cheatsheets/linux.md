# Linux Cheatsheet

## What is Linux?

Linux is a free, open-source operating system kernel that powers servers, cloud infrastructure, containers, and devices worldwide. It's the foundation of most web servers, all Android devices, and nearly all cloud computing. Understanding Linux commands is essential for DevOps, cloud engineering, and system administration.

---

## Why Learn Linux?

- **Servers** - 90%+ of web servers run Linux
- **Cloud** - AWS, Azure, GCP all use Linux
- **Containers** - Docker and Kubernetes run on Linux
- **DevOps** - Essential for automation and CI/CD
- **Free & Open Source** - No licensing costs
- **Stable & Secure** - Preferred for production systems
- **Career** - Required skill for cloud/DevOps roles

---

## Linux Distributions

| Distribution | Use Case |
|--------------|----------|
| **Ubuntu** | Desktop, servers, beginners |
| **Debian** | Servers, stability |
| **CentOS/RHEL** | Enterprise servers |
| **Rocky Linux** | RHEL replacement |
| **Alpine** | Containers (minimal) |
| **Amazon Linux** | AWS optimized |
| **Fedora** | Latest features, developers |

---

## File System Structure

```
/                   # Root directory
├── bin/            # Essential user binaries
├── boot/           # Boot loader files
├── dev/            # Device files
├── etc/            # Configuration files
├── home/           # User home directories
│   └── username/   # Your home directory (~)
├── lib/            # Shared libraries
├── media/          # Removable media mount points
├── mnt/            # Temporary mount points
├── opt/            # Optional software
├── proc/           # Process information (virtual)
├── root/           # Root user's home directory
├── sbin/           # System binaries
├── srv/            # Service data
├── sys/            # System information (virtual)
├── tmp/            # Temporary files
├── usr/            # User programs
│   ├── bin/        # User binaries
│   ├── lib/        # Libraries
│   ├── local/      # Locally installed software
│   └── share/      # Shared data
└── var/            # Variable data
    ├── log/        # Log files
    ├── www/        # Web server files
    └── lib/        # Application data
```

---

## Navigation & File Operations

### Directory Navigation

```bash
# Print current directory
pwd

# Change directory
cd /path/to/directory
cd ~                    # Home directory
cd ..                   # Parent directory
cd -                    # Previous directory
cd /                    # Root directory

# List files
ls                      # List files
ls -l                   # Long format (details)
ls -la                  # Include hidden files
ls -lh                  # Human readable sizes
ls -lt                  # Sort by time (newest first)
ls -lS                  # Sort by size (largest first)
ls -R                   # Recursive listing
```

### File Operations

```bash
# Create files
touch file.txt          # Create empty file
touch file{1..5}.txt    # Create file1.txt to file5.txt

# Create directories
mkdir folder            # Create directory
mkdir -p a/b/c          # Create nested directories

# Copy files
cp file.txt copy.txt    # Copy file
cp -r folder/ backup/   # Copy directory recursively
cp -i file.txt dest/    # Interactive (confirm overwrite)

# Move/Rename files
mv file.txt newname.txt # Rename file
mv file.txt /path/to/   # Move file
mv -i file.txt dest/    # Interactive (confirm overwrite)

# Remove files
rm file.txt             # Remove file
rm -r folder/           # Remove directory recursively
rm -f file.txt          # Force remove (no confirmation)
rm -rf folder/          # Force remove directory ⚠️
rmdir folder/           # Remove empty directory

# Create links
ln -s /path/to/file link    # Create symbolic link
ln file hardlink            # Create hard link
```

### File Viewing

```bash
# View file contents
cat file.txt            # Display entire file
less file.txt           # Paginated view (q to quit)
more file.txt           # Simple paginated view
head file.txt           # First 10 lines
head -n 20 file.txt     # First 20 lines
tail file.txt           # Last 10 lines
tail -n 20 file.txt     # Last 20 lines
tail -f file.txt        # Follow file (live updates)

# View with line numbers
cat -n file.txt
nl file.txt
```

---

## File Permissions

### Understanding Permissions

```
-rwxrwxrwx
│└┬┘└┬┘└┬┘
│ │  │  └── Others (o): everyone else
│ │  └───── Group (g): group members
│ └──────── User (u): file owner
└────────── File type (- = file, d = directory, l = link)

r = read (4)
w = write (2)
x = execute (1)
```

### Changing Permissions

```bash
# Symbolic mode
chmod u+x file.txt      # Add execute for user
chmod g-w file.txt      # Remove write for group
chmod o=r file.txt      # Set others to read only
chmod a+x file.txt      # Add execute for all
chmod u+rwx,g+rx file   # Multiple changes

# Numeric mode
chmod 755 file.txt      # rwxr-xr-x
chmod 644 file.txt      # rw-r--r--
chmod 700 file.txt      # rwx------
chmod 777 file.txt      # rwxrwxrwx ⚠️

# Common permissions
# 755 - Directories, executables
# 644 - Regular files
# 600 - Private files
# 700 - Private directories

# Recursive
chmod -R 755 folder/
```

### Ownership

```bash
# Change owner
chown user file.txt
chown user:group file.txt
chown -R user:group folder/

# Change group
chgrp group file.txt
chgrp -R group folder/
```

---

## Text Processing

### Search with grep

```bash
# Basic search
grep "pattern" file.txt
grep "error" log.txt

# Options
grep -i "pattern" file       # Case insensitive
grep -r "pattern" folder/    # Recursive search
grep -n "pattern" file       # Show line numbers
grep -c "pattern" file       # Count matches
grep -v "pattern" file       # Invert (exclude matches)
grep -l "pattern" *.txt      # List files with matches
grep -w "word" file          # Match whole word
grep -A 3 "pattern" file     # Show 3 lines after
grep -B 3 "pattern" file     # Show 3 lines before
grep -C 3 "pattern" file     # Show 3 lines around

# Regular expressions
grep -E "error|warning" file # Extended regex (OR)
grep "^start" file           # Lines starting with
grep "end$" file             # Lines ending with
grep "^$" file               # Empty lines
```

### Text Manipulation

```bash
# sed - Stream editor
sed 's/old/new/' file        # Replace first occurrence
sed 's/old/new/g' file       # Replace all occurrences
sed -i 's/old/new/g' file    # Edit file in place
sed -n '5,10p' file          # Print lines 5-10
sed '5d' file                # Delete line 5
sed '/pattern/d' file        # Delete matching lines

# awk - Pattern processing
awk '{print $1}' file        # Print first column
awk '{print $1, $3}' file    # Print columns 1 and 3
awk -F: '{print $1}' file    # Use : as delimiter
awk '/pattern/ {print}' file # Print matching lines
awk 'NR==5' file             # Print line 5
awk 'NR>=5 && NR<=10' file   # Print lines 5-10
awk '{sum+=$1} END {print sum}' file  # Sum column

# cut - Extract columns
cut -d: -f1 /etc/passwd      # First field, : delimiter
cut -c1-10 file              # Characters 1-10

# sort
sort file.txt                # Sort alphabetically
sort -n file.txt             # Sort numerically
sort -r file.txt             # Reverse sort
sort -u file.txt             # Sort and remove duplicates
sort -k2 file.txt            # Sort by column 2

# uniq
uniq file.txt                # Remove adjacent duplicates
uniq -c file.txt             # Count occurrences
uniq -d file.txt             # Show only duplicates
sort file.txt | uniq         # Remove all duplicates

# wc - Word count
wc file.txt                  # Lines, words, characters
wc -l file.txt               # Lines only
wc -w file.txt               # Words only
wc -c file.txt               # Characters only

# tr - Translate characters
tr 'a-z' 'A-Z' < file        # Lowercase to uppercase
tr -d '0-9' < file           # Delete digits
tr -s ' ' < file             # Squeeze spaces
```

---

## Pipes & Redirection

### Redirection

```bash
# Output redirection
command > file.txt           # Write output (overwrite)
command >> file.txt          # Append output
command 2> error.txt         # Redirect stderr
command &> all.txt           # Redirect stdout and stderr
command > out.txt 2>&1       # Redirect both to same file

# Input redirection
command < file.txt           # Read from file
command << EOF               # Here document
line 1
line 2
EOF

# Discard output
command > /dev/null          # Discard stdout
command 2> /dev/null         # Discard stderr
command &> /dev/null         # Discard all output
```

### Pipes

```bash
# Connect commands
command1 | command2          # Pipe output

# Examples
cat file.txt | grep "error"
ps aux | grep nginx
cat log.txt | grep "error" | wc -l
ls -la | head -10
history | grep "git"
cat /etc/passwd | cut -d: -f1 | sort
```

---

## Process Management

### Viewing Processes

```bash
# List processes
ps                           # Current user's processes
ps aux                       # All processes
ps -ef                       # Full format listing
ps aux | grep nginx          # Find specific process

# Interactive process viewer
top                          # Real-time process view
htop                         # Better interactive view (if installed)

# Process tree
pstree                       # Show process tree
```

### Managing Processes

```bash
# Run in background
command &                    # Run in background
nohup command &              # Run and ignore hangup

# Job control
jobs                         # List background jobs
fg                           # Bring to foreground
fg %1                        # Bring job 1 to foreground
bg                           # Continue in background
Ctrl+Z                       # Suspend current process
Ctrl+C                       # Terminate current process

# Kill processes
kill PID                     # Send SIGTERM
kill -9 PID                  # Force kill (SIGKILL)
kill -15 PID                 # Graceful terminate
killall process_name         # Kill by name
pkill pattern                # Kill by pattern

# Process info
pidof nginx                  # Get PID of process
pgrep nginx                  # Find PIDs by pattern
```

---

## System Information

### System Details

```bash
# System info
uname -a                     # All system info
uname -r                     # Kernel version
hostname                     # System hostname
hostnamectl                  # Detailed host info

# Hardware info
lscpu                        # CPU information
free -h                      # Memory usage
df -h                        # Disk usage
du -sh folder/               # Directory size
du -sh * | sort -h           # Sort by size
lsblk                        # Block devices

# OS info
cat /etc/os-release          # OS version
cat /etc/issue               # OS info

# Uptime
uptime                       # System uptime and load
```

### Resource Monitoring

```bash
# Memory
free -h                      # Memory usage (human readable)
cat /proc/meminfo            # Detailed memory info

# Disk
df -h                        # Filesystem usage
df -i                        # Inode usage
iostat                       # I/O statistics

# Network
ifconfig                     # Network interfaces (old)
ip addr                      # Network interfaces (new)
ip link                      # Network devices
netstat -tuln                # Listening ports
ss -tuln                     # Listening ports (newer)
```

---

## Networking

### Network Commands

```bash
# IP and interfaces
ip addr                      # Show IP addresses
ip link                      # Show network interfaces
ip route                     # Show routing table
ifconfig                     # Legacy IP command

# Connectivity
ping google.com              # Test connectivity
ping -c 4 google.com         # Send 4 pings
traceroute google.com        # Trace route to host
mtr google.com               # Combined ping/traceroute

# DNS
nslookup google.com          # DNS lookup
dig google.com               # Detailed DNS lookup
host google.com              # Simple DNS lookup
cat /etc/resolv.conf         # DNS configuration

# Ports and connections
netstat -tuln                # Listening ports
netstat -anp                 # All connections with PIDs
ss -tuln                     # Listening ports (modern)
lsof -i :80                  # What's using port 80

# Download files
curl https://example.com     # Fetch URL
curl -O https://example.com/file.zip  # Download file
wget https://example.com/file.zip     # Download file
wget -c URL                  # Resume download
```

### Firewall (ufw - Ubuntu)

```bash
# UFW commands
sudo ufw status              # Check status
sudo ufw enable              # Enable firewall
sudo ufw disable             # Disable firewall
sudo ufw allow 22            # Allow SSH
sudo ufw allow 80/tcp        # Allow HTTP
sudo ufw allow 443/tcp       # Allow HTTPS
sudo ufw deny 23             # Deny port 23
sudo ufw delete allow 80     # Remove rule
```

### Firewall (firewalld - CentOS/RHEL)

```bash
# firewalld commands
sudo firewall-cmd --state
sudo firewall-cmd --list-all
sudo firewall-cmd --add-port=80/tcp --permanent
sudo firewall-cmd --reload
```

---

## User Management

### Users

```bash
# Current user
whoami                       # Current username
id                           # User ID and groups
groups                       # User's groups

# User management
sudo useradd username        # Create user
sudo useradd -m username     # Create with home directory
sudo userdel username        # Delete user
sudo userdel -r username     # Delete user and home
sudo usermod -aG group user  # Add user to group
sudo passwd username         # Set password

# View users
cat /etc/passwd              # All users
cat /etc/shadow              # Password hashes (root)
cat /etc/group               # All groups
```

### Switching Users

```bash
su - username                # Switch to user
sudo command                 # Run as root
sudo -i                      # Root shell
sudo -u user command         # Run as specific user
```

---

## Package Management

### Ubuntu/Debian (apt)

```bash
# Update package list
sudo apt update

# Upgrade packages
sudo apt upgrade
sudo apt full-upgrade

# Install package
sudo apt install package_name

# Remove package
sudo apt remove package_name
sudo apt purge package_name  # Remove with config

# Search package
apt search keyword
apt show package_name

# Clean up
sudo apt autoremove
sudo apt clean
```

### CentOS/RHEL (dnf/yum)

```bash
# Update packages
sudo dnf update
sudo yum update              # Old syntax

# Install package
sudo dnf install package_name

# Remove package
sudo dnf remove package_name

# Search package
dnf search keyword

# List installed
dnf list installed
```

### Alpine (apk)

```bash
# Update
apk update

# Install
apk add package_name

# Remove
apk del package_name

# Search
apk search keyword
```

---

## Service Management (systemd)

```bash
# Service control
sudo systemctl start nginx
sudo systemctl stop nginx
sudo systemctl restart nginx
sudo systemctl reload nginx
sudo systemctl status nginx

# Enable/disable at boot
sudo systemctl enable nginx
sudo systemctl disable nginx

# Check if enabled
systemctl is-enabled nginx
systemctl is-active nginx

# List services
systemctl list-units --type=service
systemctl list-units --type=service --state=running

# View logs
journalctl -u nginx          # Logs for service
journalctl -u nginx -f       # Follow logs
journalctl -xe               # Recent errors
```

---

## Archives & Compression

```bash
# tar (tape archive)
tar -cvf archive.tar folder/     # Create archive
tar -xvf archive.tar             # Extract archive
tar -czvf archive.tar.gz folder/ # Create gzipped
tar -xzvf archive.tar.gz         # Extract gzipped
tar -cjvf archive.tar.bz2 folder/ # Create bzip2
tar -xjvf archive.tar.bz2        # Extract bzip2
tar -tvf archive.tar             # List contents

# gzip
gzip file                    # Compress (replaces original)
gzip -k file                 # Keep original
gunzip file.gz               # Decompress
zcat file.gz                 # View compressed file

# zip
zip archive.zip file1 file2  # Create zip
zip -r archive.zip folder/   # Zip directory
unzip archive.zip            # Extract zip
unzip -l archive.zip         # List contents
```

---

## SSH & Remote Access

```bash
# Connect to remote server
ssh user@hostname
ssh user@192.168.1.100
ssh -p 2222 user@hostname    # Custom port

# SSH key authentication
ssh-keygen -t ed25519        # Generate key pair
ssh-copy-id user@hostname    # Copy key to server

# SCP - Secure copy
scp file.txt user@host:/path/        # Upload file
scp user@host:/path/file.txt ./      # Download file
scp -r folder/ user@host:/path/      # Copy directory

# rsync - Better file sync
rsync -avz source/ dest/
rsync -avz folder/ user@host:/path/
rsync -avz --progress source/ dest/
rsync -avz --delete source/ dest/    # Mirror (delete extra)
```

---

## Disk Management

```bash
# Disk usage
df -h                        # Filesystem usage
du -sh folder/               # Directory size
du -sh *                     # Size of each item
du -sh * | sort -hr          # Sort by size
ncdu                         # Interactive disk usage

# Disk partitions
lsblk                        # List block devices
fdisk -l                     # List partitions
blkid                        # Block device IDs

# Mount/unmount
mount /dev/sdb1 /mnt         # Mount device
umount /mnt                  # Unmount
mount                        # Show mounted filesystems
cat /etc/fstab               # Permanent mounts
```

---

## Environment Variables

```bash
# View variables
env                          # All environment variables
echo $PATH                   # Specific variable
echo $HOME
echo $USER

# Set variables
export VAR="value"           # Set for session
export PATH="$PATH:/new/path" # Add to PATH

# Persistent variables
# Add to ~/.bashrc or ~/.bash_profile
echo 'export VAR="value"' >> ~/.bashrc
source ~/.bashrc             # Reload

# Common variables
$HOME                        # Home directory
$USER                        # Current username
$PATH                        # Executable paths
$PWD                         # Current directory
$SHELL                       # Current shell
$EDITOR                      # Default editor
```

---

## Shell Scripting Basics

### Basic Script

```bash
#!/bin/bash
# This is a comment

# Variables
NAME="World"
echo "Hello, $NAME!"

# User input
read -p "Enter your name: " USERNAME
echo "Hello, $USERNAME"

# Conditionals
if [ "$NAME" == "World" ]; then
    echo "Default name"
elif [ "$NAME" == "Admin" ]; then
    echo "Welcome, Admin"
else
    echo "Hello, $NAME"
fi

# Loops
for i in 1 2 3 4 5; do
    echo "Number: $i"
done

for file in *.txt; do
    echo "Processing $file"
done

# While loop
count=0
while [ $count -lt 5 ]; do
    echo "Count: $count"
    ((count++))
done

# Functions
greet() {
    echo "Hello, $1!"
}
greet "Alice"
```

### Run Script

```bash
# Make executable
chmod +x script.sh

# Run
./script.sh
bash script.sh
```

---

## Quick Reference

| Command | Description |
|---------|-------------|
| `pwd` | Print working directory |
| `ls -la` | List all files with details |
| `cd` | Change directory |
| `cp` | Copy files |
| `mv` | Move/rename files |
| `rm` | Remove files |
| `mkdir` | Create directory |
| `cat` | View file contents |
| `grep` | Search text |
| `chmod` | Change permissions |
| `chown` | Change ownership |
| `ps aux` | List processes |
| `kill` | Terminate process |
| `df -h` | Disk usage |
| `free -h` | Memory usage |
| `top` | Process monitor |
| `ssh` | Remote connection |
| `scp` | Secure copy |
| `tar` | Archive files |
| `apt/dnf` | Package manager |
| `systemctl` | Service manager |

---

## Resources

- [Linux Command Library](https://linuxcommandlibrary.com/)
- [The Linux Documentation Project](https://tldp.org/)
- [Explain Shell](https://explainshell.com/) - Explain any command
- [Linux Journey](https://linuxjourney.com/) - Learn Linux