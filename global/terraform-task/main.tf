// Vpc and subnets

resource "google_compute_network" "vpc_network" {
  project                 = var.project_id
  name                    = var.network_name
  mtu                     = var.net_mtu
  description             = var.network_description
  auto_create_subnetworks = false
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


# // Firewall Rules apply

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

