workspace "Zenbridge" {

    model {
        enterprise Zenbridge {
            group EBSI {
            l0 = softwareSystem "Ledger 0"
            vm = softwareSystem "VM-Lets"
            api = softwareSystem "Dashboard"
            }
            l1 = softwareSystem "Ledger 1"

            vm -> l1
            vm -> l0 "Knows the last transaction at a given timestamp"
            l1 -> vm
            api -> vm "Schedule"
            api -> vm "Execute"
        }
    }

    views {
        systemContext vm {
            include *
            autolayout lr
        }

        theme default
    }
}
