// Vpc and subnets

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.network_name
  mtu                     = var.net_mtu
  description             = var.network_description
  auto_create_subnetworks = false
  routing_mode            = "REGIONAL" //regional; ya gloabl
  enable_ula_internal_ipv6 =  "" //(Optional) Enable ULA internal ipv6 on this network. Enabling this feature will assign a /48 from google defined ULA prefix fd20::/20.
  internal_ipv6_range     = "" 
  delete_default_routes_on_create  = ""  //(Optional) If set to true, default routes (0.0.0.0/0) will be deleted immediately after network creation. Defaults to false.
}

resource "google_compute_subnetwork" "subnets" {
  for_each                 = var.subnets
  name                     = each.value.subnet_name
  description              = lookup(each.value, "subnet_description", "")
  project                  = each.value.subnet_project
  ip_cidr_range            = each.value.subnet_ip_range
  private_ip_google_access = lookup(each.value, "subnet_private_ip_google_access", "false")
  region                   = each.value.subnet_region
  network                  = google_compute_network.vpc_network.name
  purpose = "" //A subnetwork with purpose set to INTERNAL_HTTPS_LOAD_BALANCER is a user-created subnetwork that is reserved for Internal HTTP(S) Load Balancing.
  role = "" //ACTIVE and BACKUP //(Optional) The role of subnetwork. Currently, this field is only used when purpose = INTERNAL_HTTPS_LOAD_BALANCER. The value can be set to ACTIVE or BACKUP.
  stack_type       = "IPV4_IPV6"
  ipv6_access_type = "EXTERNAL"
  secondary_ip_range {
    range_name    = "tf-test-secondary-range-update1"
    ip_cidr_range = "192.168.10.0/24"
  }

  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.5
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

// Nat Gateway and Cloud Router

resource "google_compute_router" "router" {
  project = google_compute_network.vpc_network.project
  name    = var.router_name
  network = var.network_name
  region  = var.router_region
}

resource "google_compute_router_nat" "nat" {
  name                               = var.my-router-nat-name
  project                            = google_compute_router.router.project
  router                             = google_compute_router.router.name
  region                             = google_compute_router.router.region
  nat_ip_allocate_option             = var.nat_ip_allocate_option 
  source_subnetwork_ip_ranges_to_nat = var.source_subnetwork_ip_ranges_to_nat
}


// Firewall Rules apply

# resource "google_compute_firewall" "rules" {
#   project     = var.project_id
#   name        = var.firewall_name
#   network     = var.network_name
#   description = "Creates firewall rule targeting tagged instances"

#   allow {
#     protocol = "ssh"
#     ports    = ["22"]
#   }
#   target_tags = [ "ssh" ]
# }

