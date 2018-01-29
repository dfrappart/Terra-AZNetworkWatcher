######################################################
# This file allows the creation of a Custom RBAC role
# for Azure
######################################################

resource "azurerm_role_definition" "Terra-NetworkWatcher_CustomRBACRoleDefinition" {

    role_definition_id      = ""
    name                    = "Terra-NetworkWatcher_CustomRBACRoleDefinition"
    scope                   = "/subscriptions/f1f020d0-0fa6-4d01-b816-5ec60497e851"
    description             = "Custom Role for Network Watcher created through Terraform"

    permissions {

        actions = [
                    "Microsoft.Storage/*/read",
                    "Microsoft.Authorization/*/read",
                    "Microsoft.Resources/subscriptions/resourceGroups/*/read",
                    "Microsoft.Storage/storageAccounts/listServiceSas/*/Action",
                    "Microsoft.Storage/storageAccounts/listAccountSas/*/Action",
                    "Microsoft.Storage/storageAccounts/listKeys/*/Action",
                    "Microsoft.Compute/virtualMachines/*/read",
                    "Microsoft.Compute/virtualMachines/*/write",
                    "Microsoft.Compute/virtualMachineScaleSets/*/read",
                    "Microsoft.Compute/virtualMachineScaleSets/*/write",
                    "Microsoft.Network/networkWatchers/packetCaptures/*/read",
                    "Microsoft.Network/networkWatchers/packetCaptures/*/write",
                    "Microsoft.Network/networkWatchers/packetCaptures/*/delete",
                    "Microsoft.Network/networkWatchers/*/write",
                    "Microsoft.Network/networkWatchers/*/read",
                    "Microsoft.Insights/alertRules/*",
                    "Microsoft.Support/*",
                    "Microsoft.Network/networkWatchers/*",
                    "Microsoft.Network/networkWatchers/*/Action"
            ]
        not_actions = []

    }

    assignable_scopes       = [
                            "/subscriptions/",
        
                            ]
}

resource "azurerm_role_assignment" "Terra-NetworkWatcherCustomRBACRoleAssignment" {

    name                = "Terra-NetworkWatcherCustomRBACRoleAssignment"
    scope               = "/subscriptions/"
    role_definition_id     = "${azurerm_role_definition.Terra-NetworkWatcher_CustomRBACRoleDefinition.id}"
    principal_id        = ""

}