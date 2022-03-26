
# Creates the network
module "Network" {
  source = "./modules/Network"
}

# Terraform module that reuse the code that creates virtual machines without scaleset
module "VirtualMachines" {
  source = "./modules/ApplicationServer"
  # Creating virtual machines with the names and numbers as we pass in the list, the last machine is configuration machine with public IP
  vm_names = ["ApplicationServer-1", "ConfigurationMachine"]
  # Passing the app subnetID, creating the machines in the right subnet
  AppSubnetID = module.Network.AppSubnet
}

# Creates Load Balancer
module "LoadBalancer" {
  source = "./modules/LoadBalancer"
  # Passing the Application subnet
  LoadbalancersubnetID = module.Network.AppSubnet
  # Passing the virtual networkID
  VirtualNetworkID = module.Network.NetworkID


}

# Create ManagedDB
module "ManagedDB" {
  source = "./modules/ManagedDB"
  # Passing the networkID for the managed dbserver
  VirtualNetworkID = module.Network.NetworkID
  # Passing the subnet (private) for the managed dbserver
  DBSubnet = module.Network.DBSubnet
}

#  creates VMSS
module "ScaleSet" {
  source = "./modules/ScaleSet"
  # Passing the App subnet id
  AppSubnetID = module.Network.AppSubnet
  # Passing the load balancer backend address pool id
  lb_backend_address_pool_id = module.LoadBalancer.lb_backend_address_pool_id
}






