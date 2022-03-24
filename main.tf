

module "Network" {
  source = "./modules/Network"
  # Sending the private IP of appservers for defining the rules at DB network security group
  privateipaddrres1 = module.VirtualMachines.networkinterfaceprivateipadrress1
  privateipaddrres2 = module.VirtualMachines.networkinterfaceprivateipadrress2
  privateipaddrres3 = module.VirtualMachines.networkinterfaceprivateipadrress3
}

module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  # Creating virtual machines with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["ApplicationServer-1", "ApplicationServer-2","ApplicationServer-3","ConfigurationMachine"]

  AppSubnetID = module.Network.AppSubnet
  NetworkSecurityGroupID = module.Network.SecurityGroupID
}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
  LoadbalancersubnetID = module.Network.AppSubnet
  VirtualNetworkID = module.Network.NetworkID
  privateipaddrres1 = module.VirtualMachines.networkinterfaceprivateipadrress1
  privateipaddrres2 = module.VirtualMachines.networkinterfaceprivateipadrress2
  privateipaddrres3 = module.VirtualMachines.networkinterfaceprivateipadrress3
}

module "ManagedDB" {
  source = "./modules/ManagedDB"
  VirtualNetworkID = module.Network.NetworkID
  DBSubnet = module.Network.DBSubnet
}




