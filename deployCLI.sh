#!/bin/bash

# parameters

resourceGroupName="gab2017CLI"
resourceGroupLocation="eastus2"
vmName="cliVM"
vmSize="Standard_D1_v2"

#login to azure using your credentials
az account show 1> /dev/null

if [ $? != 0 ];
then
	az login
fi

# set account
az account set --subscription "MSDNOld"

# Create a resource group
az group create --name $resourceGroupName --location $resourceGroupLocation

az vm create --resource-group $resourceGroupName --name $vmName --image win2016datacenter --admin-username cliadmin --admin-password 'cliadminDevise!!!'