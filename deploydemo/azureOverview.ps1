# Get the version
Get-Module AzureRM -list | Select-Object Name,Version,Path

# Update the Module
Update-Module -Name AzureRM –Force

# Install a specific version
Install-Module -Name AzureRM -RequiredVersion 3.7.0
Install-Module -Name AzureRM -RequiredVersion 1.2.9

# Use a specific version
Import-Module AzureRM -RequiredVersion 1.2.9

# Use the latest 
Import-Module AzureRM

# Connect to account
Login-AzureRmAccount

# Get subscriptions
Get-AzureRmSubscription

# Select subscription
Select-AzureRmSubscription -SubscriptionName "MSDNOld"

# Get Resource Groups
Get-AzureRmResourceGroup

# Find resources
Find-AzureRmResource -ResourceGroupName atlspug0417


