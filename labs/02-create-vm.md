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
| **Subscription** | `Azure subscription 1` |
| **Resource group** | `workshop-students-rg` |
| **Virtual machine name** | `studentXX-vm` (replace XX with your number) |
| **Region** | `(US) East US` |
| **Availability options** | `No infrastructure redundancy required` |
| **Security type** | `Standard` |
| **Image** | `Ubuntu Server 24.04 LTS - x64 Gen2` |
| **VM architecture** | `x64` |
| **Size** | `Standard_B1s` (1 vcpu, 1 GiB memory) - $7.59/month |

> 💡 **Tip:** Click "See all sizes" and search for "B1s" if not visible.

**Administrator account:**

| Setting | Value |
|---------|-------|
| **Authentication type** | `Password` |
| **Username** | `studentXX` (replace XX with your number) |
| **Password** | Create a strong password (save it!) |
| **Confirm password** | Re-enter password |

**Inbound port rules:**

| Setting | Value |
|---------|-------|
| **Public inbound ports** | `None` (we use subnet NSG) |

---

### Step 3: Configure Disks

Click the **Disks** tab:

| Setting | Value |
|---------|-------|
| **OS disk size** | `Image default (30 GiB)` |
| **OS disk type** | `Premium SSD (locally-redundant storage)` |
| **Delete with VM** | ✅ Checked |

---

### Step 4: Configure Networking

Click the **Networking** tab:

| Setting | Value |
|---------|-------|
| **Virtual network** | `vnet-mlct-student-eus (workshop-students-rg)` |
| **Subnet** | `snet-vm-student-eus (10.1.1.0/24)` |
| **Public IP** | `(new) studentXX-vm-ip` |
| **NIC network security group** | `None` |

> ℹ️ The subnet already has NSG `nsg-vm-student-eus` attached with SSH, RDP, HTTP, HTTPS rules.

---

### Step 5: Review and Create

1. Skip **Management**, **Monitoring**, **Advanced**, **Tags** tabs (use defaults)
2. Click **Review + create**
3. Review your settings
4. Click **Create**
5. Wait for deployment (2-3 minutes)

---

### Step 6: Connect to Your VM

Once deployed:

1. Click **Go to resource**
2. Copy the **Public IP address** from Overview page

**Option A: Connect via SSH (Linux/Mac/Windows Terminal)**

```bash
ssh studentXX@<your-public-ip>
```

Enter your password when prompted.

**Option B: Connect via RDP (Windows Remote Desktop)**

1. In Azure Portal, go to your VM
2. Click **Connect** → **RDP**
3. Click **Download RDP File**
4. Open the downloaded `.rdp` file
5. Enter credentials:
   - Username: `studentXX`
   - Password: (your password)
6. Click **Connect**

> 💡 **Note:** RDP uses port 3389 which is allowed by the NSG.

**You're now inside your VM!** 🎉

Try these commands:

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

### Step 7: Clean Up (Important!)

When done, **delete your VM** to avoid charges:

1. Go to your VM in the portal
2. Click **Delete**
3. Check the boxes to delete:
   - ✅ OS disk
   - ✅ Network interfaces  
   - ✅ Public IP address
4. Type the VM name to confirm
5. Click **Delete**

---

## ✅ Success Checklist

- [ ] Created VM in `workshop-students-rg`
- [ ] Used `vnet-mlct-student-eus` and `snet-vm-student-eus`
- [ ] Selected `Standard_B1s` size
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
- Username is `studentXX` (not your email)
- Password is case-sensitive

**VM creation failed?**
- Check you're in `workshop-students-rg`
- Check region is `East US`
- Try a different VM name

---

## What You Learned

- How to create a VM using the Azure Portal
- How VMs connect to Virtual Networks and Subnets
- How to connect via SSH (Linux) or RDP (Windows)
- Why cleanup is important (cost management)

---

## Cost Information

| Resource | Cost |
|----------|------|
| Standard_B1s VM | ~$0.01/hour ($7.59/month) |
| Premium SSD 30GB | ~$4.80/month |
| Public IP | ~$3.65/month |

> ⚠️ **Always delete your VM after the lab to avoid charges!**