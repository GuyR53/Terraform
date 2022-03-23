

module "Network" {
  source = "./modules/Network"
}

module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  vm_names = ["ApplicationServer-1", "ApplicationServer-2","ApplicationServer-3"]
  AppSubnetID = module.Network.AppSubnet
  NetworkSecurityGroupID = module.Network.SecurityGroupID
}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
}




