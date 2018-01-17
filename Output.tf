######################################################
# This file defines which value are sent to output
######################################################

######################################################
# Resource group info Output

output "ResourceGroupName" {

    value = "${module.ResourceGroup.Name}"
}

output "ResourceGroupId" {

    value = "${module.ResourceGroup.Id}"
}


######################################################
# Resource group Netork Watcher info Output

output "ResourceGroupNameNW" {

    value = "${module.ResourceGroupNW.Name}"
}

output "ResourceGroupIdNW" {

    value = "${module.ResourceGroupNW.Id}"
}

######################################################
# vNet info Output

output "vNetName" {

    value = "${module.SampleArchi_vNet.Name}"
}

output "vNetId" {

    value = "${module.SampleArchi_vNet.Id}"
}

output "vNetAddressSpace" {

    value = "${module.SampleArchi_vNet.AddressSpace}"
}

######################################################
# Log&Diag Storage account Info

output "DiagStorageAccountName" {

    value = "${module.DiagStorageAccount.Name}"
}

output "DiagStorageAccountID" {

    value = "${module.DiagStorageAccount.Id}"
}

output "DiagStorageAccountPrimaryBlobEP" {

    value = "${module.DiagStorageAccount.PrimaryBlobEP}"
}

output "DiagStorageAccountPrimaryQueueEP" {

    value = "${module.DiagStorageAccount.PrimaryQueueEP}"
}

output "DiagStorageAccountPrimaryTableEP" {

    value = "${module.DiagStorageAccount.PrimaryTableEP}"
}

output "DiagStorageAccountPrimaryFileEP" {

    value = "${module.DiagStorageAccount.PrimaryFileEP}"
}

output "DiagStorageAccountPrimaryAccessKey" {

    value = "${module.DiagStorageAccount.PrimaryAccessKey}"
}

output "DiagStorageAccountSecondaryAccessKey" {

    value = "${module.DiagStorageAccount.SecondaryAccessKey}"
}

######################################################
# Files Storage account Info

output "FilesExchangeStorageAccountName" {

    value = "${module.FilesExchangeStorageAccount.Name}"
}

output "FilesExchangeStorageAccountID" {

    value = "${module.FilesExchangeStorageAccount.Id}"
}

output "FilesExchangeStorageAccountPrimaryBlobEP" {

    value = "${module.FilesExchangeStorageAccount.PrimaryBlobEP}"
}

output "FilesExchangeStorageAccountPrimaryQueueEP" {

    value = "${module.FilesExchangeStorageAccount.PrimaryQueueEP}"
}

output "FilesExchangeStorageAccountPrimaryTableEP" {

    value = "${module.FilesExchangeStorageAccount.PrimaryTableEP}"
}

output "FilesExchangeStorageAccountPrimaryFileEP" {

    value = "${module.FilesExchangeStorageAccount.PrimaryFileEP}"
}

output "FilesExchangeStorageAccountPrimaryAccessKey" {

    value = "${module.FilesExchangeStorageAccount.PrimaryAccessKey}"
}

output "FilesExchangeStorageAccountSecondaryAccessKey" {

    value = "${module.FilesExchangeStorageAccount.SecondaryAccessKey}"
}



######################################################
# Subnet info Output
######################################################

######################################################
#Subnet1

output "Subnet1Name" {

    value = "${module.Subnet1.Name}"
}

output "Subnet1Id" {

    value = "${module.Subnet1.Id}"
}

output "Subnet1AddressPrefix" {

    value = "${module.Subnet1.AddressPrefix}"
}


######################################################
#Subnet2

output "Subnet2Name" {

    value = "${module.Subnet2.Name}"
}

output "Subnet2Id" {

    value = "${module.Subnet2.Id}"
}

output "Subnet2AddressPrefix" {

    value = "${module.Subnet2.AddressPrefix}"
}
######################################################
#Subnet3

output "Subnet3Name" {

    value = "${module.Subnet3.Name}"
}

output "Subnet3Id" {

    value = "${module.Subnet3.Id}"
}

output "Subnet3AddressPrefix" {

    value = "${module.Subnet3.AddressPrefix}"
}

######################################################
#Linux VMs Output

output "LXGR1VMsfqdn" {

    value = ["${module.LXGR1PIP.fqdns}"]
}

output "LXGR1VMsPIPAddress" {

    value = ["${module.LXGR1PIP.IPAddresses}"]
}

######################################################
#Win VMs Output

output "WINGR1VMsfqdn" {

    value = ["${module.WINGR1PIP.fqdns}"]
}

output "WINGR1VMspublicIPAddress" {

    value = ["${module.WINGR1PIP.IPAddresses}"]
}