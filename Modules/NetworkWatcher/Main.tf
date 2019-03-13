##############################################################
#This module allows the creation of a NEtwork Watcher
##############################################################



# NW Creation

resource "azurerm_network_watcher" "Terra_NW" {

    name                    = "${var.NWName}"
    location                = "${var.NWLocation}"
    resource_group_name     = "${var.RGName}"
    
    tags {
        environment = "${var.EnvironmentTag}"
        usage       = "${var.EnvironmentUsageTag}"
  }
}


