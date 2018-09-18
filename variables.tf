######################################################
# Variables for Template
######################################################

# Variable to define the Azure Region

variable "AzureRegion" {

    type    = "string"
    default = "westeurope"
}


# Variable to define the Resource Group Name containing the Network Watcher for the region

variable "RGNameNW" {

    type    = "string"
    default = "RG-NetWorkWatcher"
}

# Variable to define the Resource Group Name for the testing resource

variable "RGName" {

    type    = "string"
    default = "RG-NetWorkWatcherTest"
}




# Variables OS to use : Publisher, Offer, SKU, version
#Get info with following az command: 
#az vm image list-publishers -l westeurope
# az vm image list-offers --output table --publisher RedHat --location "west europe"
# az vm image list-skus --output table --offer RHEL --publisher REDHAT --location "west europe"
#Get info with azurerm PS command:
#Get-AzureRmVMImagePublisher -Location westeurope | ? {$_.publishername -like "*Microsoft*"}
#Get-AzureRmVMImageOffer -Location westeurope -PublisherName MicrosoftWindowsServer
#Get-AzureRmVMImageSku -Location westeurope -PublisherName MicrosoftWindowsServer -Offer WindowsServer

# variable defining VM image 

# variable defining VM image 

variable "PublisherName" {

    
    default = {
      "0" = "microsoftwindowsserver"
      "1" = "MicrosoftVisualStudio"
      "2" = "canonical"
      "3" = "credativ"
      "4" = "Openlogic"
      "5" = "MicrosoftSQLServer"

    }
}

variable "Offer" {

    
    default = {
      "0" = "WindowsServer"
      "1" = "Windows"
      "2" = "ubuntuserver"
      "3" = "debian"
      "4" = "CentOS"
      "5" = "SQL2016SP1-WS2016"

    }
}

variable "sku" {

    
    default = {
      "0" = "2016-Datacenter"
      "1" = "Windows-10-N-x64"
      "2" = "16.04.0-LTS"
      "3" = "9"
      "4" = "7.0"
      "5" = "Enterprise"
    

    }
}

variable "OSversion" {
  type    = "string"
  default = "latest"
}

variable "VMSize" {
    
  type = "map"
  default = {
      "0" = "Standard_F1S"
      "1" = "Standard_F2s"
      "2" = "Standard_F4S"
      "3" = "Standard_F8S"

  }
}


variable "vNetIPRange" {

    type = "list"
    default = ["10.0.0.0/20"]
}

variable "SubnetAddressRange" {
#Note: Subnet must be in range included in the vNET Range
    
    default = {
      "0" = "10.0.0.0/24"
      "1" = "10.0.1.0/24"
      "2" = "10.0.2.0/24"
     
    }
}


variable "SubnetName" {
    
    default = {
      "0" = "Subnet1"
      "1" = "Subnet2"
      "2" = "Subnet3"

    }
}


# Variable to define the Tag

variable "EnvironmentTag" {

    type    = "string"
    default = "NetworkWatcherTest"
}

variable "EnvironmentUsageTag" {

    type    = "string"
    default = "PoC"
}

# variable defining storage account tier

variable "storageaccounttier" {

    
    default = {
      "0" = "standard"
      "1" = "premium"

     }
}

# variable defining storage replication type

variable "storagereplicationtype" {

    
    default = {
      "0" = "LRS"
      "1" = "GRS"
      "2" = "RAGRS"
      "3" = "ZRS"
     }
}

# variable defining storage account tier for managed disk

variable "Manageddiskstoragetier" {

    
    default = {
      "0" = "standard_lrs"
      "1" = "premium_lrs"

    }
}
