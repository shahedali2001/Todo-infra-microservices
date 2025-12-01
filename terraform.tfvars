rg_name = {
  rg1 = {
    name       = "shahed-rg-01"
    location   = "australiacentral"
    managed_by = "shahed"
    tags = {
      cost = "marketing"

    }

  },
}
    
aks_cluster = {
  cluster1 = {
    name                = "shahed-dev-aks-cluster"
    location            = "australiacentral"
    resource_group_name = "shahed-rg-01"
    dns_prefix          = "aks-cluster1"


    # Default node pool
    node_pool_name = "shahedpool"
    node_count     = 1
    vm_size        = "Standard_B2s"

    # Identity
    type = "SystemAssigned"

    # Optional AKS settings
    aad_admin_group_object_ids   = []
    enable_azure_rbac            = true
    enable_oidc_issuer           = false
    enable_workload_identity     = false
    assign_identity              = ""
    control_plane_count          = 1
    control_plane_vm_size        = "Standard_B2s"
    enable_cluster_autoscaler    = false
    enable_ahub                  = false
    enable_ai_toolchain_operator = false
    enable_kaito                 = false
    disable_nfs_driver           = false
    disable_smb_driver           = false
    generate_ssh_keys            = true
    ssh_key_value                = ""
    vnet_ids       = []
    vnet_subnet_id = ""
    # pod_cidr            = "10.244.0.0/16"
    service_cidr        = "10.0.0.0/16"
    ns_service_ip       = "10.0.0.10"
    load_balancer_count = 1

    # Preview features
    ca_profile = ""
    gateway_id = ""

    # Operation settings
    no_wait = false

    # Resource tags
    tags = {
      Environment = "development"
      cost        = "marketing"
    }
  }
}
acr_registries = {
  shahed_acr = {
    name                = "shaheddevacr"
    resource_group_name = "shahed-rg-01"
    location            = "australiacentral"
    sku                 = "Standard"
    admin_enabled       = true
    tags = {
      environment = "dev"
      owner       = "shahed"
    }
  }

  prod_acr = {
    name                = "shahedacr1980"
    resource_group_name = "shahed-rg-01"
    location            = "australiacentral"
    sku                 = "Premium"
    admin_enabled       = false
    tags = {
      environment = "dev"
      owner       = "shahed"
    }
  }
}

pips = {
  bastion_pip = {
    name                = "bastion-pip"
    resource_group_name = "shahed-rg-01"
    location            = "centralindia"
    allocation_method   = "Static"
    tags = {
      app = "bastion"
      env = "dev"
    }
  },
   appgw1 = {
    name                = "appgw-pip"
    resource_group_name = "shahed-rg-01"
    location            = "centralindia"
    allocation_method   = "Static"
    sku                 = "Standard"
     tags = {
      app = "appgw"
      env = "dev"
}
  }
}
key_vaults = {
  kv1 = {
    name                        = "shahed-kv1"
    location                    = "centralindia"
    resource_group_name         = "shahed-rg-01"
    enabled_for_disk_encryption = true
    soft_delete_retention_days  = 7
    purge_protection_enabled    = false
    sku_name                    = "standard"

    access_policy = {
      key_permissions     = ["Get", "List"]
      secret_permissions  = ["Get", "Set", "List"]
      storage_permissions = ["Get"]
    }

    tags = {
      environment = "dev"
    }
  }
}
mssql_servers = {
  sqlserver1 = {
    name                         = "shahed-sqlserver-01"
    resource_group_name          = "shahed-rg-01"
    location                     = "centralindia"
    version                      = "12.0"
    administrator_login          = "sqladmin"
    administrator_login_password = "Admin@12345678"
    tags = {
      environment = "dev"
      owner       = "shahed"
    }
  }
}

mssql_databases = {
  db1 = {
    name            = "shaheddb1"
    server_key      = "sqlserver1"
    collation       = "SQL_Latin1_General_CP1_CI_AS"
    license_type    = "LicenseIncluded"
    max_size_gb     = 2
    sku_name        = "S0"
    enclave_type    = "VBS"
    prevent_destroy = true
    tags = {
      app = "backend"
    }
  }
}


bastion_hosts = {
  bastion = {
    name                = "bastion"
    location            = "centralindia"
    resource_group_name = "shahed-rg-01"
    vnet_name           = "bastion-vnet"
    subnet_prefix       = "10.0.1.0/27"
    address_space       = ["10.0.0.0/16"]
    public_ip_key       = "bastion_pip"

    tags = {
      environment = "dev"
      owner       = "dev-team"
    }
  }
}
vnets = {
  vnet1 = {
    vnet_name           = "shahed_vnet"
    location            = "centralindia"
    resource_group_name = "shahed-rg-01"
    address_space       = ["10.0.0.0/16"]
    dns_servers         = []  # optional

    subnets = [
      {
        name             = "shahed-subnet"
        address_prefixes = ["10.0.1.0/24"]
      },
      {
        name             = "appgw-subnet"
        address_prefixes = ["10.0.2.0/24"]
      }
    ]
  }
}
application_gateways = {
  appgw1 = {
    name                = "shahed-appgw"
    resource_group_name = "shahed-rg-01"
    location            = "centralindia"

    virtual_network_name = "shahed_vnet"

    sku = {
      name     = "Standard_v2"
      tier     = "Standard_v2"
      capacity = 1
    }

    gateway_ip_configuration = {
      name        = "appgw-ipconfig"
      subnet_name = "appgw-subnet"
    }

    frontend_ports = [
      {
        name = "frontendPort1"
        port = 80
      }
    ]

    frontend_ip_configurations = [
      {
        name = "frontendIPConfig1"
      }
    ]

    backend_address_pools = [
      {
        name = "backendPool1"
      }
    ]

    backend_http_settings = [
      {
        name                  = "httpSetting1"
        cookie_based_affinity = "Disabled"
        path                  = "/"
        port                  = 80
        protocol              = "Http"
        request_timeout       = 60
      }
    ]

    http_listeners = [
      {
        name                           = "httpListener1"
        frontend_ip_configuration_name = "frontendIPConfig1"
        frontend_port_name             = "frontendPort1"
        protocol                       = "Http"
      }
    ]

    request_routing_rules = [
      {
        name                       = "rule1"
        priority                   = 9
        rule_type                  = "Basic"
        http_listener_name         = "httpListener1"
        backend_address_pool_name  = "backendPool1"
        backend_http_settings_name = "httpSetting1"
      }
    ]

    tags = {
      environment = "dev"
      project     = "todo-infra"
    }
  }
}
