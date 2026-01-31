#!/bin/bash
# ============================================================
# ML-Cloud-Training - Azure Infrastructure Setup
# Run this BEFORE the workshop to prepare environments
# ============================================================

set -e  # Exit on error

# ============================================================
# VARIABLES
# ============================================================
LOCATION="eastus"
LOCATION_SHORT="eus"
APP_NAME="mlct"

# Resource Groups
RG_DEMO="rg-${APP_NAME}-demo-${LOCATION_SHORT}"
RG_STUDENT="workshop-students-rg"

# Student Group (Entra ID / Azure AD group)
STUDENT_GROUP_ID="d14c1aa5-1d28-4058-9594-091fb9f2df52"

# Tags
TAGS="project=ml-cloud-training environment=training owner=instructor"

echo "=========================================="
echo "ML-Cloud-Training - Azure Setup"
echo "=========================================="

# ============================================================
# VERIFY SUBSCRIPTION
# ============================================================
echo ""
echo ">>> Current subscription:"
az account show --query "{Name:name, ID:id, State:state}" -o table
echo ""
read -p "Is this the correct subscription? (y/n): " confirm
if [[ $confirm != "y" && $confirm != "Y" ]]; then
  echo "Please run: az account set --subscription <your-subscription-name>"
  exit 1
fi

# ============================================================
# REGISTER RESOURCE PROVIDERS (Required for new subscriptions)
# ============================================================
echo ""
echo "============================================"
echo "Registering Resource Providers..."
echo "============================================"

echo ">>> Registering Microsoft.Storage..."
az provider register --namespace Microsoft.Storage

echo ">>> Registering Microsoft.Network..."
az provider register --namespace Microsoft.Network

echo ">>> Registering Microsoft.Compute..."
az provider register --namespace Microsoft.Compute

echo ">>> Registering Microsoft.Web..."
az provider register --namespace Microsoft.Web

echo ">>> Registering Microsoft.KeyVault..."
az provider register --namespace Microsoft.KeyVault

# Wait for providers to register
echo ""
echo ">>> Waiting for providers to register (this may take 1-2 minutes)..."
sleep 30

# Check registration status
echo ">>> Checking registration status..."
for provider in Microsoft.Storage Microsoft.Network Microsoft.Compute Microsoft.Web Microsoft.KeyVault; do
  status=$(az provider show --namespace $provider --query "registrationState" -o tsv)
  echo "    $provider: $status"
  
  # Wait if still registering
  while [[ "$status" == "Registering" ]]; do
    echo "    Waiting for $provider..."
    sleep 10
    status=$(az provider show --namespace $provider --query "registrationState" -o tsv)
  done
done

echo ">>> All providers registered!"

# ============================================================
# PART 1: DEMO RESOURCE GROUP
# ============================================================

echo ""
echo "============================================"
echo "PART 1: Demo Resource Group"
echo "============================================"

echo ">>> Creating Demo Resource Group: $RG_DEMO"
az group create --name $RG_DEMO --location $LOCATION --tags $TAGS

# --- Storage Account ---
RANDOM_SUFFIX=$(head /dev/urandom | tr -dc 'a-z0-9' | head -c 4)
STORAGE_NAME="st${APP_NAME}demo${LOCATION_SHORT}${RANDOM_SUFFIX}"
echo ">>> Creating Storage Account: $STORAGE_NAME"
az storage account create \
  --name $STORAGE_NAME \
  --resource-group $RG_DEMO \
  --location $LOCATION \
  --sku Standard_LRS \
  --kind StorageV2 \
  --tags $TAGS

# --- Virtual Network ---
VNET_DEMO="vnet-${APP_NAME}-demo-${LOCATION_SHORT}"
SNET_DEMO="snet-${APP_NAME}-demo-${LOCATION_SHORT}"
echo ">>> Creating Demo VNet: $VNET_DEMO"
az network vnet create \
  --name $VNET_DEMO \
  --resource-group $RG_DEMO \
  --location $LOCATION \
  --address-prefix 10.0.0.0/16 \
  --subnet-name $SNET_DEMO \
  --subnet-prefix 10.0.1.0/24 \
  --tags $TAGS

# --- Network Security Group ---
NSG_DEMO="nsg-${APP_NAME}-demo-${LOCATION_SHORT}"
echo ">>> Creating Demo NSG: $NSG_DEMO"
az network nsg create \
  --name $NSG_DEMO \
  --resource-group $RG_DEMO \
  --location $LOCATION \
  --tags $TAGS

# Add NSG rules
az network nsg rule create --nsg-name $NSG_DEMO --resource-group $RG_DEMO \
  --name AllowSSH --priority 1000 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 22

az network nsg rule create --nsg-name $NSG_DEMO --resource-group $RG_DEMO \
  --name AllowHTTP --priority 1001 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 80

az network nsg rule create --nsg-name $NSG_DEMO --resource-group $RG_DEMO \
  --name AllowHTTPS --priority 1002 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 443

# Associate NSG with subnet
az network vnet subnet update \
  --vnet-name $VNET_DEMO --name $SNET_DEMO --resource-group $RG_DEMO \
  --network-security-group $NSG_DEMO

# --- Key Vault ---
KV_NAME="kv-${APP_NAME}-demo-${LOCATION_SHORT}"
echo ">>> Creating Key Vault: $KV_NAME"
az keyvault create \
  --name $KV_NAME \
  --resource-group $RG_DEMO \
  --location $LOCATION \
  --sku standard \
  --tags $TAGS

az keyvault secret set --vault-name $KV_NAME \
  --name "demo-secret" --value "Demo-Secret-Value-123"

echo ">>> Demo RG complete!"


# ============================================================
# PART 2: STUDENT RESOURCE GROUP
# ============================================================

echo ""
echo "============================================"
echo "PART 2: Student Resource Group"
echo "============================================"

echo ">>> Creating Student Resource Group: $RG_STUDENT"
az group create --name $RG_STUDENT --location $LOCATION --tags $TAGS

# --- Assign Contributor role to Workshop-Students group ---
echo ">>> Assigning Contributor role to Workshop-Students group..."
az role assignment create \
  --assignee $STUDENT_GROUP_ID \
  --role "Contributor" \
  --resource-group $RG_STUDENT

echo ">>> Permissions assigned!"

# --- Virtual Network ---
VNET_STUDENT="vnet-${APP_NAME}-student-${LOCATION_SHORT}"
echo ">>> Creating Student VNet: $VNET_STUDENT"
az network vnet create \
  --name $VNET_STUDENT \
  --resource-group $RG_STUDENT \
  --location $LOCATION \
  --address-prefix 10.1.0.0/16 \
  --tags $TAGS

# --- Subnet for VMs ---
SNET_VM="snet-vm-student-${LOCATION_SHORT}"
echo ">>> Creating VM Subnet: $SNET_VM"
az network vnet subnet create \
  --name $SNET_VM \
  --resource-group $RG_STUDENT \
  --vnet-name $VNET_STUDENT \
  --address-prefix 10.1.1.0/24

# --- Subnet for App Services ---
SNET_APP="snet-app-student-${LOCATION_SHORT}"
echo ">>> Creating App Service Subnet: $SNET_APP"
az network vnet subnet create \
  --name $SNET_APP \
  --resource-group $RG_STUDENT \
  --vnet-name $VNET_STUDENT \
  --address-prefix 10.1.2.0/24 \
  --delegations Microsoft.Web/serverFarms

# --- Network Security Group ---
NSG_STUDENT="nsg-vm-student-${LOCATION_SHORT}"
echo ">>> Creating Student NSG: $NSG_STUDENT"
az network nsg create \
  --name $NSG_STUDENT \
  --resource-group $RG_STUDENT \
  --location $LOCATION \
  --tags $TAGS

# Add NSG rules
az network nsg rule create --nsg-name $NSG_STUDENT --resource-group $RG_STUDENT \
  --name AllowSSH --priority 1000 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 22

az network nsg rule create --nsg-name $NSG_STUDENT --resource-group $RG_STUDENT \
  --name AllowHTTP --priority 1001 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 80

az network nsg rule create --nsg-name $NSG_STUDENT --resource-group $RG_STUDENT \
  --name AllowHTTPS --priority 1002 --access Allow --direction Inbound \
  --protocol Tcp --destination-port-range 443

# Associate NSG with VM subnet
az network vnet subnet update \
  --vnet-name $VNET_STUDENT --name $SNET_VM --resource-group $RG_STUDENT \
  --network-security-group $NSG_STUDENT

# --- App Service Plan ---
PLAN_STUDENT="plan-${APP_NAME}-student-${LOCATION_SHORT}"
echo ">>> Creating App Service Plan: $PLAN_STUDENT"
az appservice plan create \
  --name $PLAN_STUDENT \
  --resource-group $RG_STUDENT \
  --location $LOCATION \
  --sku F1 \
  --is-linux \
  --tags $TAGS

echo ">>> Student RG complete!"


# ============================================================
# SUMMARY
# ============================================================

echo ""
echo "=========================================="
echo "✅ SETUP COMPLETE!"
echo "=========================================="
echo ""
echo "📁 Demo ($RG_DEMO):"
echo "   st:   $STORAGE_NAME"
echo "   vnet: $VNET_DEMO"
echo "   nsg:  $NSG_DEMO"
echo "   kv:   $KV_NAME"
echo ""
echo "📁 Student ($RG_STUDENT):"
echo "   vnet: $VNET_STUDENT"
echo "   snet: $SNET_VM (VMs)"
echo "   snet: $SNET_APP (Apps)"
echo "   nsg:  $NSG_STUDENT"
echo "   plan: $PLAN_STUDENT"
echo ""
echo "🔐 Workshop-Students group = Contributor on $RG_STUDENT"
echo "=========================================="