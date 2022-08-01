module "vpc" {
    source  = "./modules/vpc"
    project_id   = "practice-354222"
    network_name = "test-network"
    shared_vpc_host = false
}