

module "Network" {
  source = "./modules/Network"
}

module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  vm_names = ["ApplicationServer-1"]
  AppSubnetID = module.Network.AppSubnet
  NetworkSecurityGroupID = module.Network.SecurityGroupID
}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
  LoadbalancersubnetID = module.Network.AppSubnet
}

module "ManagedDB" {
  source = "./modules/ManagedDB"
  VirtualNetworkID = module.Network.NetworkID
  DBSubnet = module.Network.DBSubnet
}




