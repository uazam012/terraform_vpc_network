variable "project_id" {
    type = string
    description = "Project id of gcp"
}

variable "network_name" {
    type = string
    description = "Network_Name in Gcp"
}

variable "network_description" {
    type = string
    description = "Network description in gcp"
}

variable "net_mtu" {
    type = number
    description = "mtu number which is used in vpc_network and by default is 1460"
}

variable "subnets" {
  description = "Custom Subnet Name "
  type        = map(any)
}

//variables

# variable "secondary_range_name" {
#     type = string
#     description = "Secondary Range Ip in gcp"
# }

# variable "secondary_ip_cidr_range " {
#     type = string
#     description = "Secondary ip cidr range in gcp"
# }

# variable "firewall_name" {
#     type = string
#     description = "firewall rule name in gcp"
# }


////// Router and Nat Gateway Variables.

variable "router_name" {
    type = string
    description = "Router name in gcp"
}

variable "router_region" {
    type = string
    description = "router region in gcp"
}

variable "my-router-nat-name" {
    type = string
    description = "Router nat name"
}

variable "nat_ip_allocate_option" {
    type = string
    description = "nat ip allocation in gcp"
}

variable "source_subnetwork_ip_ranges_to_nat" {
    type = string
    description = "subets are all here whichj is added or not"
}
