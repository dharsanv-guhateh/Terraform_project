include "root" { path = find_in_parent_folders() }
terraform { source = "../../Modules/compute_network" }

inputs = {
  aws_region    = "us-east-1" # Virginia
  env           = "prod"
  vpc_cidr      = "10.1.0.0/16"
  subnet_cidr   = "10.1.1.0/24"
  instance_type = "t3.micro"
}
