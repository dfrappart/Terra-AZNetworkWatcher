##############################################################
#This file creates a group of Windows VMs, 
#accessible from Internet Throught RDP
##############################################################

#NSG rules for Server in Subnet 2

module "AllowRDPromInternetSubnet2In" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"

    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet2.Name}"
    NSGRuleName = "AllowRDPromInternetSubnet2In"
    NSGRulePriority = 101
    NSGRuleDirection = "Inbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "Tcp"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = 3389
    NSGRuleSourceAddressPrefix = "Internet"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
}

module "AllowAllFromSubnet1toSubnet2In" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet2.Name}"
    NSGRuleName = "AllowAllFromSubnet1toSubnet2In"
    NSGRulePriority = 102
    NSGRuleDirection = "Inbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
}

module "AllowAllFromSubnet2toSubnet1Out" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet2.Name}"
    NSGRuleName = "AllowAllFromSubnet2toSubnet1Out"
    NSGRulePriority = 103
    NSGRuleDirection = "Outbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
}

module "AllowAllSubnet2toInternetOut" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet2.Name}"
    NSGRuleName = "AllowAllSubnet2toInternetOut"
    NSGRulePriority = 104
    NSGRuleDirection = "Outbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
    NSGRuleDestinationAddressPrefix = "Internet"
}

#Subnet2 VM PIP

module "WINGR1PIP" {

    #Module source
    #source = "./Modules/10 PublicIP"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//10 PublicIP"


    #Module variables
    PublicIPCount           = "1"
    PublicIPName            = "wingr1pip"
    PublicIPLocation        = "${var.AzureRegion}"
    RGName                  = "${module.ResourceGroup.Name}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}


#Availability set creation


module "AS_WINGR1VMs" {

    #Module source

    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//13 AvailabilitySet"


    #Module variables
    ASName                  = "AS_WINGR1VMs"
    RGName                  = "${module.ResourceGroup.Name}"
    ASLocation              = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"

}


#NIC Creation

module "NICs_WINGR1VMs" {


    #module source

    #source = "./Modules/12 NICwithPIPWithCount"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//12 NICwithPIPWithCount"

    #Module variables

    NICCount            = "1"
    NICName             = "NIC_WINGR1VM"
    NICLocation         = "${var.AzureRegion}"
    RGName              = "${module.ResourceGroup.Name}"
    SubnetId            = "${module.Subnet2.Id}"
    PublicIPId          = ["${module.WINGR1PIP.Ids}"]
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"


}

#Datadisk creation

module "DataDisks_WINGR1VMs" {

    #Module source

    #source = "./Modules/06 ManagedDiskswithcount"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 ManagedDiskswithcount"


    #Module variables

    Manageddiskcount    = "1"
    ManageddiskName     = "DataDisk_WINVM"
    RGName              = "${module.ResourceGroup.Name}"
    ManagedDiskLocation = "${var.AzureRegion}"
    StorageAccountType  = "${lookup(var.Manageddiskstoragetier, 0)}"
    CreateOption        = "Empty"
    DiskSizeInGB        = "63"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"


}

#VM creation

module "WINGR1VMs" {

    #module source

    #source = "./Modules/WinVMWithCount"
    source = "github.com/dfrappart/Terra-AZBasicWinWithModules//Modules//WinVMWithCount"


    #Module variables

    VMCount                     = "1"
    VMName                      = "WINGR1VM"
    VMLocation                  = "${var.AzureRegion}"
    VMRG                        = "${module.ResourceGroup.Name}"
    VMNICid                     = ["${module.NICs_WINGR1VMs.Ids}"]
    VMSize                      = "${lookup(var.VMSize, 0)}"
    ASID                        = "${module.AS_WINGR1VMs.Id}"
    VMStorageTier               = "${lookup(var.Manageddiskstoragetier, 0)}"
    VMAdminName                 = "${var.VMAdminName}"
    VMAdminPassword             = "${var.VMAdminPassword}"
    DataDiskId                  = ["${module.DataDisks_WINGR1VMs.Ids}"]
    DataDiskName                = ["${module.DataDisks_WINGR1VMs.Names}"]
    DataDiskSize                = ["${module.DataDisks_WINGR1VMs.Sizes}"]
    VMPublisherName             = "${lookup(var.PublisherName, 0)}"
    VMOffer                     = "${lookup(var.Offer, 0)}"
    VMsku                       = "${lookup(var.sku, 0)}"
    DiagnosticDiskURI           = "${module.DiagStorageAccount.PrimaryBlobEP}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"

}

#VM Agent

#Network Watcher Agent

module "NetworkWatcherAgentForWINGR1VMs" {

    #Module Location
    #source = "./Modules/NetworkWatcherAgentWin"
    source = "github.com/dfrappart/Terra-AZBasicWinWithModules//Modules//NetworkWatcherAgentWin"


    #Module variables
    AgentCount              = "1"
    AgentName               = "NetworkWatcherAgentForFEWeb"
    AgentLocation           = "${var.AzureRegion}"
    AgentRG                 = "${module.ResourceGroup.Name}"
    VMName                  = ["${module.WINGR1VMs.Name}"]
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
}

