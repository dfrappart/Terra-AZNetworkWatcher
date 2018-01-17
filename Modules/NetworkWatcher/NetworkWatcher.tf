##############################################################
#This module allow the creation of a NEtwork Watcher
##############################################################

#Variable declaration for Module

#The NW name
variable "NWName" {
  type    = "string"

}

#The RG in which the AS is attached to
variable "RGName" {
  type    = "string"

}

#The location in which the AS is attached to
variable "NWLocation" {
  type    = "string"

}




#Tag value to help identify the resource. 
#Required tag are EnvironmentTAg defining the type of 
#environment and
#environment Tag usage specifying the use case of the environment

variable "EnvironmentTag" {
  type    = "string"
  default = "Poc"
}

variable "EnvironmentUsageTag" {
  type    = "string"
  default = "Poc usage only"
}



# Availability Set Creation

resource "azurerm_network_watcher" "Terra_NW" {

    name                    = "${var.NWName}"
    location                = "${var.NWLocation}"
    resource_group_name     = "${var.RGName}"
    
    tags {
        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
  }
}

#Output


output "Name" {

  value = "${azurerm_network_watcher.Terra_NW.name}"
}

output "Id" {

  value = "${azurerm_network_watcher.Terra_NW.id}"
}


