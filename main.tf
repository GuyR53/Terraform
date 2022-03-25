

module "Network" {
  source = "./modules/Network"
  # Passing the private IP of appservers for defining the rules at DB network security group
  privateipaddrres1 = module.VirtualMachines.networkinterfaceprivateipadrress1
  privateipaddrres2 = module.VirtualMachines.networkinterfaceprivateipadrress2
  privateipaddrres3 = module.VirtualMachines.networkinterfaceprivateipadrress3
}

module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  # Creating virtual machines with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["ApplicationServer-1", "ApplicationServer-2","ApplicationServer-3","ConfigurationMachine"]
  # Passing the app subnetID, creating the machines in the right subnet
  AppSubnetID = module.Network.AppSubnet
}

module "LoadBalancer" {
  source = "./modules/LoadBalancer"
  # Passing the Application subnet
  LoadbalancersubnetID = module.Network.AppSubnet
  # Passing the virtual networkID
  VirtualNetworkID = module.Network.NetworkID
  # Passing the private IP of appservers to define them in the backendpoll
  privateipaddrres1 = module.VirtualMachines.networkinterfaceprivateipadrress1
  privateipaddrres2 = module.VirtualMachines.networkinterfaceprivateipadrress2
  privateipaddrres3 = module.VirtualMachines.networkinterfaceprivateipadrress3
}

module "ManagedDB" {
  source = "./modules/ManagedDB"
  # Passing the networkID for the managed dbserver
  VirtualNetworkID = module.Network.NetworkID
  # Passing the subnet (private) for the managed dbserver
  DBSubnet = module.Network.DBSubnet
}




