# import AzureRM module
Import-Module AzureRM -EA 0

Login-AzureRmAccount

# parameters
$resourceGroupName = 'gab2017PowerShell'
$resourceGroupLocation = 'eastus2'
$vmName = 'powershellVM'
$vmSize = 'Standard_D1_v2'

New-AzureRmResourceGroup -Name $resourceGroupName -Location $resourceGroupLocation

# Create a subnet configuration
$subnetConfig = New-AzureRmVirtualNetworkSubnetConfig -Name 'default' -AddressPrefix 10.1.0.0/24

# Create a virtual network
$vnet = New-AzureRmVirtualNetwork -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation `
-Name gab2017-vnet -AddressPrefix 10.1.0.0/24 -Subnet $subnetConfig

# Create a public IP address and specify a DNS name
$pip = New-AzureRmPublicIpAddress -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation `
-AllocationMethod Dynamic -Name "portalvmip-$(Get-Random)"

# Create a virtual network card and associate with public IP address and NSG
$nic = New-AzureRmNetworkInterface -Name "$($vmName)$(Get-Random -Maximum 1000)" -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation `
-SubnetId $vnet.Subnets[0].Id -PublicIpAddressId $pip.Id

# Define a credential object
$cred = Get-Credential

# Create a virtual machine configuration
$vmConfig = New-AzureRmVMConfig -VMName $vmName -VMSize $vmSize | `
Set-AzureRmVMOperatingSystem -Windows -ComputerName $vmName -Credential $cred | `
Set-AzureRmVMSourceImage -PublisherName MicrosoftWindowsServer -Offer WindowsServer -Skus 2016-Datacenter -Version latest | `
Add-AzureRmVMNetworkInterface -Id $nic.Id

New-AzureRmVM -ResourceGroupName $resourceGroupName -Location $resourceGroupLocation -VM $vmConfig