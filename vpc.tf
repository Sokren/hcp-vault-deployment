// If you have not already, create a VPC within your AWS account that will
// contain the workloads you want to connect to your HCP Consul cluster.
// Make sure the CIDR block of the peer VPC does not overlap with the CIDR
// of the HVN.
resource "aws_vpc" "vpc" {
  cidr_block = var.aws_cidr_block
  enable_dns_hostnames = true
  enable_dns_support = true
  tags = {
    name = "vpc-demo-hvn"
    environment = "demo"
  }
}

# Create the EC2 VM
resource "aws_subnet" "my_subnet" {
  vpc_id            = aws_vpc.vpc.id
  cidr_block        = var.aws_subnet
  availability_zone = var.aws_az
  map_public_ip_on_launch = true
  tags = {
    Name = "vpc-demo-hvn"
  }
}

resource "aws_network_interface" "my_network_interface" {
  subnet_id   = aws_subnet.my_subnet.id
  tags = {
    Name = "primary_network_interface"
  }
}

resource "aws_internet_gateway" "my_vpc_igw" {
  vpc_id = aws_vpc.vpc.id

  tags = {
    Name = "My VPC - Internet Gateway"
  }
}

resource "aws_route_table" "route_table" {
    vpc_id = aws_vpc.vpc.id

    route {
      cidr_block = "0.0.0.0/0"
      gateway_id = aws_internet_gateway.my_vpc_igw.id
    }
    route {
      cidr_block = var.hvn_cidr_block
      vpc_peering_connection_id = module.hvn_deployment.hcp_aws_network_peering_id
    }
    tags = {
        Name = "Public and Peering Subnet Route Table."
    }
}

resource "aws_route_table_association" "route_table" {
    subnet_id = aws_subnet.my_subnet.id
    route_table_id = aws_route_table.route_table.id
}