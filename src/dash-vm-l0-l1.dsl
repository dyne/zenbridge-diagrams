workspace "Zenbridge" {

    model {
        enterprise Zenbridge {
            l1 = softwareSystem "Ledger 1" 

            consensus = softwareSystem "Consensus Operator" {
                    container "Zenroom" {
                        tags "zen"
                    }
                    container "Tarantool" {
                        tags "tt"
                    }
                    container "Tendermint" {
                        tags "tm"
                    }
            }

            cache = softwareSystem "Cache operator" {
               container "Tarantool" {
                        tags "tt"
                    } 
            }

            smoperator = softwareSystem "Smart Contract Operator" {
                    container "Zenroom" {
                        tags "zen"
                    }
                     container "Tarantool" {
                        tags "tt"
                    }
                     container "BigchainDB" {
                        tags "bdb"
                         component "Tendermint" {
                             tags "tm"
                         }
                    }
            }

                operator = person "Operator"
                customer = person "Customer"
                manifacturer = person "Manifacturer" {
                    tags "Manifacturer"
                }
                devices = person "Devices" {
                    tags "Devices"
                }
            group EBSI {

                l0 = softwareSystem "Ledger 0" "Stores only the latest block hash (head) of the blockchains"
                vm = softwareSystem "VM-Lets" "Programmable and scalable execution unit" {
                    zenroom = container "Zenroom" {
                        tags "zen"
                    }
                    tarantool = container "Tarantool" {
                        tags "tt"
                    }
                    bigchaindb = container "BigchainDB" {
                        tags "bdb"
                        tendermint = component "Tendermint" {
                            tags "tm"
                        }
                    }
                }
                
                api = softwareSystem "Dashboard" {
                    webapp = container "Web Application"
                    database = container "Database"
                }
            }

            manifacturer -> vm
            devices -> vm
            vm -> l1
            vm -> l0 "Stores/Retrieve only the latest block hash (head) of the blockchains at a given timestamp"
            l1 -> vm
            api -> vm "Schedule"
            api -> vm "Execute"
        }

        development = deploymentEnvironment "Phase 2A" {
            deploymentNode "EPIC" {
                c1 = deploymentNode "L1" {
                    softwareSystemInstance l1
                }
                
                    vmnodes = deploymentNode "VM-Lets" "" "" "" 5 {
                        containerInstance zenroom
                        containerInstance tarantool
                        containerInstance bigchaindb
                    }

                    c0 = deploymentNode "L0" {
                        softwareSystemInstance l0
                    }
                
            }

            vmnodes -> c1
            vmnodes -> c0
        }

        phase2b = deploymentEnvironment "Phase 2B" {
            deploymentNode "EPIC" "Experimental Platform for Internet Contingencies" {
                lc1 = deploymentNode "L1" {
                    softwareSystemInstance l1
                }

                lvmnodes = deploymentNode "VM-Lets" "" "Two nodes per EU country" "" 50 {
                    containerInstance zenroom
                    containerInstance tarantool
                    containerInstance bigchaindb
                }

                lsdn = deploymentNode "Service Delivery Network" {


                    caching = deploymentNode "Caching operators" "" "" "" 50 {
                        containerInstance tarantool
                    } 
                }

                lc0 = deploymentNode "L0" {
                    softwareSystemInstance l0
                }
            }

            lvmnodes -> caching
            lsdn -> lc0
            lsdn -> lc1
        }
    }

    views {
        branding {
            logo "https://zenroom.org/wp-content/uploads/2019/12/zenbridge-1536x307.png"
        }
        systemLandscape "landscape" {
            include *
            autolayout lr
        }
        systemContext vm "ContextVertical" {
            include *
            autolayout tb
        }

        systemContext vm "ContextHorizontal" {
            include *
            autolayout lr
        }        

        container smoperator "SmartContractOperator" {
            include *
            autolayout tb
        }

        container cache "CacheOperator" {
            include *
            autolayout tb    
        }

        container consensus "ConsensusOperator" {
            include *
            autolayout tb      
        }

        container vm "ContainerVertical" {
            include *
            autolayout tb
        }

        container vm "ContainerHorizontal" {
            include *
            autolayout lr
        }

        dynamic l1 {
            autolayout lr
            title "Use case Steel Material Passport: Retrieve"
            customer -> vm "Requests the information about a material at a given timestamp"
            vm -> l0 "Asks for the latest transaction at the given timestamp"
        }

        dynamic l1 {
            autolayout lr
            title "Use case Steel Material Passport: Store"
            manifacturer -> vm "Requests to store the information about a material on the ledger"
            vm -> l0 "Notarize with a transaction"
        }

        deployment vm "Development" "DevelopmentDeployment" {
            include *
            autoLayout
        }

        deployment vm phase2b {
            title "Phase 2B Topology"
            include *
            autoLayout       
        }

        styles {
            element "zen" {
                icon "https://zenroom.org/wp-content/uploads/2019/11/zenroom.png"
            }

            element "tt" {
                icon "https://hb.bizmrg.com/tarantool-io/website-static/tarantool/images/logo-full.svg"
            }

            element "bdb" {
                icon "https://www.solvewithvia.com/wp-content/uploads/2018/09/BigchainDB-no-bleed-full-colour-logo-5-1.png"
            }

            element "tm" {
                icon "https://v1.cosmos.network/images/logos/tendermint-logo-black.png"
            }

            element "Dashboard" {
                shape "WebBrowser" 
            }

            element "Manifacturer" {
                shape "Robot"
            }

            element "Devices" {
                shape "MobileDevicePortrait"
            }

            relationship "Relationship" {
                dashed false
            }
        }

        theme default
    }
}
