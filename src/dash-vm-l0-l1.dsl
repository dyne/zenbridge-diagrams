workspace "Zenbridge" {

    model {
        l0 = softwareSystem "Ledger 0"
        vm = softwareSystem "VM-Lets"
        l1 = softwareSystem "Ledger 1"
        api = softwareSystem "Dashboard"

        vm -> l1
        vm -> l0
        l1 -> vm
        api -> vm "Schedule"
        api -> vm "Execute"

    }

    views {
        systemContext vm {
            include *
            autolayout lr
        }

        theme default
    }
}
