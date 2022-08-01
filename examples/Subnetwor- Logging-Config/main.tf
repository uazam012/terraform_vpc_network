module "subnet-vpc-module" {
  source       = "./modules/subnets"
  //version = "~> 2.0.0"
  project_id   = "practice-354222"
  network_name = "test-network"       
  subnets = {
    "subnet1" = {
      subnet_name              = "public-b"
      subnet_ip                = "10.175.0.0/19"
      private_ip_google_access = false
      subnet_region            = "asia-south1"
      
    },

    "subnet2" = {
      subnet_name              = "public-c"
      subnet_ip                = "10.175.32.0/19"
      private_ip_google_access = false
      subnet_region            = "asia-south1"
      
    },

    "subnet3" = {
      subnet_name              = "private-b"
      subnet_ip                = "10.175.64.0/19"
      private_ip_google_access = true
      subnet_region            = "asia-south1"
      
    },

    "subnet4" = {
      subnet_name              = "private-c"
      subnet_ip                = "10.175.96.0/19"
      private_ip_google_access = true
      subnet_region            = "asia-south1"
    }
  }
  secondary_ranges = {
        public-b = [
            {
                range_name    = "public-b-secondary-01"
                ip_cidr_range = "192.168.64.0/24"
            },
        ]
        public-c = []
    }
}