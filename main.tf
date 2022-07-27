module "test-vpc-module" {
  source       = "./modules/terraform-task-network"
  project_id   = "practice-354222"
  network_name = "test-network"
  net_mtu          = 1460
  network_description = "Netwrok Vpc with public and private subnets and apply firewall rules on it."

  subnets = {
    "subnet1" = {
      subnet_name              = "public-b"
      subnet_description       = "this is public subnet in vpc"
      subnet_ip_range          = "10.175.0.0/19"
      private_ip_google_access = false
      subnet_region            = "asia-south1"
      subnet_project           = "practice-354222"
    },

    "subnet2" = {
      subnet_name              = "public-c"
      subnet_description       = "this is public subnet in vpc"
      subnet_ip_range          = "10.175.32.0/19"
      private_ip_google_access = false
      subnet_region            = "asia-south1"
      subnet_project           = "practice-354222"
    },

    "subnet3" = {
      subnet_name              = "private-b"
      subnet_description       = "this is private subnet in vpc"
      subnet_ip_range          = "10.175.64.0/19"
      private_ip_google_access = true
      subnet_region            = "asia-south1"
      subnet_project           = "practice-354222"
    },

    "subnet4" = {
      subnet_name              = "private-c"
      subnet_description       = "this is private subnet in vpc"
      subnet_ip_range          = "10.175.96.0/19"
      private_ip_google_access = true
      subnet_region            = "asia-south1"
      subnet_project           = "practice-354222"
    }
  }

    router_name       = "router-terraform"
    router_region     = "us-west1"

    my-router-nat-name                 = "nat-terraform"
    nat_ip_allocate_option             = "AUTO_ONLY"
    source_subnetwork_ip_ranges_to_nat = "ALL_SUBNETWORKS_ALL_IP_RANGES"

}