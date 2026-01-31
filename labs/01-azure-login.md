# Lab 1: Azure Portal Login

## Objective

Learn how to access the Azure Portal and set up your account security with Microsoft Authenticator.

---

## Prerequisites

- Your assigned username (e.g., `student01@ml.cloud-people.net`)
- Password provided by your instructor
- A smartphone with access to your app store

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

### Step 3: Set Up Microsoft Authenticator

When you see the **"More information required"** or **"Keep your account secure"** screen:

#### On Your Phone:

1. Open the **App Store** (iPhone) or **Google Play Store** (Android)
2. Search for **"Microsoft Authenticator"**
3. Download and install the app
4. Open the Microsoft Authenticator app

#### On Your Computer:

1. Click **Next** on the setup screen
2. You will see a **QR code** displayed

#### Back on Your Phone:

1. In the Authenticator app, tap **+** (Add account)
2. Select **Work or school account**
3. Choose **Scan QR code**
4. Point your phone camera at the QR code on your computer screen
5. The account will be added automatically

#### Complete the Setup:

1. On your computer, click **Next**
2. Microsoft will send a test notification to your phone
3. On your phone, tap **Approve** on the notification
4. On your computer, click **Next**
5. Click **Done**

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

## Troubleshooting

**QR code not scanning?**
- Ensure good lighting
- Hold your phone steady
- Try clicking "Can't scan image?" for manual entry

**Didn't receive the notification?**
- Check that notifications are enabled for the Authenticator app
- Ensure your phone has internet connection
- Try clicking "Resend notification"

**Don't have a smartphone?**
- Ask your instructor for alternative authentication options

---

## Verification

You have successfully completed this lab when you can:

- [ ] Log in to Azure Portal
- [ ] Set up Microsoft Authenticator
- [ ] See the Azure dashboard
- [ ] Navigate to `workshop-students-rg` resource group

---

## Next Lab

[Lab 2: Create a Virtual Machine](02-create-vm.md)