resource "google_project" "host_project" {
  name            = var.host_project_id
  project_id      = var.host_project_id
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "host_project_services" {
  for_each = toset([
    "compute.googleapis.com",
    "vpcaccess.googleapis.com",
  ])
  project = google_project.host_project.project_id
  service = each.value
}

resource "google_compute_network" "shared_vpc" {
  project                 = google_project.host_project.project_id
  name                    = var.shared_vpc_name
  auto_create_subnetworks = false
  routing_mode            = "GLOBAL"
}

resource "google_compute_shared_vpc_host_project" "host_project" {
  project = google_project.host_project.name
}