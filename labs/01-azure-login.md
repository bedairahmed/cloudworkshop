# Lab 1: Azure Portal Login

## Objective

Learn how to access the Azure Portal and set up your account security.

---

## Prerequisites

- Your assigned username (e.g., `student01@ml.cloud-people.net`)
- Password provided by your instructor

---

## Steps

### Step 1: Access Azure Portal

1. Open your web browser
2. Navigate to **https://portal.azure.com**

### Step 2: Sign In

1. Enter your assigned username
2. Click **Next**
3. Enter the password provided by your instructor
4. Click **Sign in**

### Step 3: Set Up Account Security

When you see the **"Let's keep your account secure"** screen:

1. Click **Next**
2. Click **"I want to set up a different method"**
3. Select **Email** from the dropdown menu
4. Enter your **personal email address** (Gmail, Outlook, Yahoo, etc.)
5. Click **Next**
6. Check your personal email inbox for a verification code from Microsoft
7. Enter the verification code
8. Click **Verify**
9. Click **Done**

### Step 4: Explore the Portal

Once logged in, you will see the Azure Portal dashboard.

Take a moment to explore:

- **Home** - Your dashboard with quick access to resources
- **All services** - Browse all Azure services
- **Resource groups** - View your assigned resource group

---

## Your Access Permissions

| Scope | Role | What You Can Do |
|-------|------|-----------------|
| Subscription | Reader | View all resources (read-only) |
| `workshop-students-rg` | Contributor | Create, modify, delete resources |

---

## Important Guidelines

- **Resource Group:** Always create resources in `workshop-students-rg`
- **Region:** Always select `East US`
- **VM Sizes:** Only small sizes allowed (B-series)

---

## Verification

You have successfully completed this lab when you can:

- [ ] Log in to Azure Portal
- [ ] See the Azure dashboard
- [ ] Navigate to `workshop-students-rg` resource group

---

## Next Lab

[Lab 2: Create a Virtual Machine](02-create-vm.md)