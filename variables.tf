variable "aws_region" {
  type = string
  description = "Location of the Region to deploy"
  default = "eu-west-1"
}
variable "aws_cidr_block" {
  type = string
  description = "CIDR for the AWS VPC"
  default = "10.220.0.0/16"
}
variable "aws_subnet" {
  type = string
  description = "CIDR for the AWS VPC"
  default = "10.220.0.0/24"
}
variable "listClusterName" {
  type = list(string)
  default = [ "Cluster-Vault-1", "Cluster-Vault-2" ]
}
variable "listEC2" {
  type = list(string)
  default = [ "Instance-1", "Instance-2" ]
}
variable "aws_az" {
  type = string
  description = "Location of the availability zone to deploy"
  default = "eu-west-1a"
}
variable "hvn_id" {
  type = string
  description = "Name of the hvn"
  default = "demo-hvn"
}
variable "hvn_cidr_block" {
  type = string
  description = "CIDR for the HVN"
  default = "172.25.16.0/20"
}
variable "hcpv_pub_endpoint" {
  type = string
  description = "Set public IP on HCP"
  default = "false"
}
variable "peer_id" {
  type = string
  description = "Name of the peer"
  default = "peering2"
}
variable "hvn_route_id" {
  type = string
  description = "Name of the hvn route"
  default = "peer-route-id2"
}