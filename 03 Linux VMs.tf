##############################################################
#This file creates a group of linux VMs, 
#accessible from Internet Throught SSH
##############################################################

#NSG rules for Server in Subnet 1

module "AllowSSHFromInternetSubnet1In" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"

    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet1.Name}"
    NSGRuleName = "AllowSSHFromInternetSubnet1In"
    NSGRulePriority = 101
    NSGRuleDirection = "Inbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "Tcp"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = 22
    NSGRuleSourceAddressPrefix = "Internet"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
}

module "AllowAllFromSubnet2toSubnet1In" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet1.Name}"
    NSGRuleName = "AllowAllFromSubnet2toSubnet1In"
    NSGRulePriority = 102
    NSGRuleDirection = "Inbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
}

module "AllowAllFromSubnet1toSubnet2Out" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet1.Name}"
    NSGRuleName = "AllowAllFromSubnet1toSubnet2Out"
    NSGRulePriority = 103
    NSGRuleDirection = "Outbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
    NSGRuleDestinationAddressPrefix = "${lookup(var.SubnetAddressRange, 1)}"
}

module "AllowAllSubnet1toInternetOut" {

    #Module source
    #source = "./Modules/08 NSGRule"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//08 NSGRule"


    #Module variable
    RGName = "${module.ResourceGroup.Name}"
    NSGReference = "${module.NSG_Subnet1.Name}"
    NSGRuleName = "AllowAllSubnet1toInternetOut"
    NSGRulePriority = 104
    NSGRuleDirection = "Outbound"
    NSGRuleAccess = "Allow"
    NSGRuleProtocol = "*"
    NSGRuleSourcePortRange = "*"
    NSGRuleDestinationPortRange = "*"
    NSGRuleSourceAddressPrefix = "${lookup(var.SubnetAddressRange, 0)}"
    NSGRuleDestinationAddressPrefix = "Internet"
}

#Public IP Creation for the Linux VMs group

module "LXGR1PIP" {

    #Module source
    #source = "./Modules/10 PublicIP"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//10 PublicIP"


    #Module variables
    PublicIPCount           = "1"
    PublicIPName            = "lxgr1pip"
    PublicIPLocation        = "${var.AzureRegion}"
    RGName                  = "${module.ResourceGroup.Name}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"


}


#Availability set creation


module "AS_LXGR1VMs" {

    #Module source

    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//13 AvailabilitySet"


    #Module variables
    ASName                  = "AS_LXGR1VMs"
    RGName                  = "${module.ResourceGroup.Name}"
    ASLocation              = "${var.AzureRegion}"
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"

}


#NIC Creation

module "NICs_LXGR1VMs" {


    #module source

    #source = "./Modules/12 NICwithPIPWithCount"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//12 NICwithPIPWithCount"

    #Module variables

    NICCount            = "1"
    NICName             = "NIC_LXGR1VM"
    NICLocation         = "${var.AzureRegion}"
    RGName              = "${module.ResourceGroup.Name}"
    SubnetId            = "${module.Subnet1.Id}"
    PublicIPId          = ["${module.LXGR1PIP.Ids}"]
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"


}

#Datadisk creation

module "DataDisks_LXGR1VMs" {

    #Module source

    #source = "./Modules/06 ManagedDiskswithcount"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//06 ManagedDiskswithcount"


    #Module variables

    Manageddiskcount    = "1"
    ManageddiskName     = "DataDisk_LXVM"
    RGName              = "${module.ResourceGroup.Name}"
    ManagedDiskLocation = "${var.AzureRegion}"
    StorageAccountType  = "${lookup(var.Manageddiskstoragetier, 0)}"
    CreateOption        = "Empty"
    DiskSizeInGB        = "63"
    EnvironmentTag      = "${var.EnvironmentTag}"
    EnvironmentUsageTag = "${var.EnvironmentUsageTag}"


}

#VM creation

module "LXGR1VMs" {

    #module source

    #source = "./Modules/14 LinuxVMWithCount"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//14 LinuxVMWithCount"


    #Module variables

    VMCount                     = "1"
    VMName                      = "LXGR1VM"
    VMLocation                  = "${var.AzureRegion}"
    VMRG                        = "${module.ResourceGroup.Name}"
    VMNICid                     = ["${module.NICs_LXGR1VMs.Ids}"]
    VMSize                      = "${lookup(var.VMSize, 0)}"
    ASID                        = "${module.AS_LXGR1VMs.Id}"
    VMStorageTier               = "${lookup(var.Manageddiskstoragetier, 0)}"
    VMAdminName                 = "${var.VMAdminName}"
    VMAdminPassword             = "${var.VMAdminPassword}"
    DataDiskId                  = ["${module.DataDisks_LXGR1VMs.Ids}"]
    DataDiskName                = ["${module.DataDisks_LXGR1VMs.Names}"]
    DataDiskSize                = ["${module.DataDisks_LXGR1VMs.Sizes}"]
    VMPublisherName             = "${lookup(var.PublisherName, 4)}"
    VMOffer                     = "${lookup(var.Offer, 4)}"
    VMsku                       = "${lookup(var.sku, 4)}"
    DiagnosticDiskURI           = "${module.DiagStorageAccount.PrimaryBlobEP}"
    BootConfigScriptFileName    = "deployansible.sh"
    PublicSSHKey                = "${var.AzurePublicSSHKey}"
    EnvironmentTag              = "${var.EnvironmentTag}"
    EnvironmentUsageTag         = "${var.EnvironmentUsageTag}"

}


module "CustomScriptForLXGR1VMs" {

    #Module Location
    #source = "./Modules/19 CustomLinuxExtension-Ansible"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//19 CustomLinuxExtension-Ansible"


    #Module variables
    AgentCount              = "1"
    AgentName               = "LXGR1VMsCustomScript"
    AgentLocation           = "${var.AzureRegion}"
    AgentRG                 = "${module.ResourceGroup.Name}"
    VMName                  = ["${module.LXGR1VMs.Name}"]
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
}

module "NetworkWatcherAgentForLXGR1VMs" {

    #Module Location
    #source = "./Modules/20 LinuxNetworkWatcherAgent"
    source = "github.com/dfrappart/Terra-AZBasiclinuxWithModules//Modules//20 LinuxNetworkWatcherAgent"


    #Module variables
    AgentCount              = "1"
    AgentName               = "NetworkWatcherAgentForLXGR1VMs"
    AgentLocation           = "${var.AzureRegion}"
    AgentRG                 = "${module.ResourceGroup.Name}"
    VMName                  = ["${module.LXGR1VMs.Name}"]
    EnvironmentTag          = "${var.EnvironmentTag}"
    EnvironmentUsageTag     = "${var.EnvironmentUsageTag}"
}