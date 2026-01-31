# Lab 02: Create a Virtual Machine

## Objective
Create a Linux Virtual Machine in Azure Portal.

## Time
15 minutes

---

## Steps

### Step 1: Go to Virtual Machines

1. Open [portal.azure.com](https://portal.azure.com)
2. Click **Virtual machines** in the left menu (or search for it)
3. Click **+ Create** → **Azure virtual machine**

---

### Step 2: Configure Basics

Fill in these settings:

| Setting | Value |
|---------|-------|
| **Subscription** | (your subscription) |
| **Resource group** | `workshop-students-rg` |
| **Virtual machine name** | `studentXX-vm` (replace XX with your number) |
| **Region** | `East US` |
| **Image** | `Ubuntu Server 24.04 LTS` |
| **Size** | Click "See all sizes" → Select `B1s` |

**Administrator account:**
| Setting | Value |
|---------|-------|
| **Authentication type** | `Password` |
| **Username** | `azureuser` |
| **Password** | (create a strong password - save it!) |

---

### Step 3: Configure Networking

Click the **Networking** tab:

| Setting | Value |
|---------|-------|
| **Virtual network** | `vnet-mlct-student-eus` |
| **Subnet** | `snet-vm-student-eus (10.1.1.0/24)` |
| **Public IP** | `(new)` - keep default |
| **NIC network security group** | `None` (we use subnet NSG) |

---

### Step 4: Review and Create

1. Click **Review + create**
2. Review your settings
3. Click **Create**
4. Wait for deployment (2-3 minutes)

---

### Step 5: Connect to Your VM

Once deployed:

1. Go to your VM resource
2. Copy the **Public IP address**

**Option A: Connect via SSH (Linux/Mac/Windows Terminal)**

```bash
ssh azureuser@<your-public-ip>
```
Enter your password when prompted.

**Option B: Connect via RDP (Windows Remote Desktop)**

1. In Azure Portal, go to your VM
2. Click **Connect** → **RDP**
3. Click **Download RDP File**
4. Open the downloaded `.rdp` file
5. Enter credentials:
   - Username: `azureuser`
   - Password: (your password)
6. Click **Connect**

> 💡 **Note:** RDP uses port 3389 which is allowed by the NSG.

**You're now inside your VM!** 🎉

Try these commands (in SSH or terminal):
```bash
# Check hostname
hostname

# Check OS
cat /etc/os-release

# Check resources
free -h
df -h
```

---

### Step 6: Clean Up (Important!)

When done, **delete your VM** to avoid charges:

1. Go to your VM in the portal
2. Click **Delete**
3. Check the boxes to delete:
   - ✅ OS disk
   - ✅ Network interfaces  
   - ✅ Public IP address
4. Type `delete` to confirm
5. Click **Delete**

---

## ✅ Success Checklist

- [ ] Created VM in `workshop-students-rg`
- [ ] Used `vnet-mlct-student-eus` and `snet-vm-student-eus`
- [ ] Connected via SSH or RDP
- [ ] Deleted the VM when done

---

## Troubleshooting

**Can't find B1s size?**
- Click "See all sizes" and search for "B1s"
- Make sure region is East US

**SSH connection refused?**
- Wait 1-2 minutes after VM creation
- Verify you're using the correct public IP
- Check your password

**Permission denied?**
- Username is `azureuser` (not your email)
- Password is case-sensitive

---

## What You Learned

- How to create a VM using the Azure Portal
- How VMs connect to Virtual Networks
- How to connect via SSH (Linux) or RDP (Windows)
- Why cleanup is important (cost management)