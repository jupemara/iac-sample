variable "org_id" {
  type = string
}

variable "host_project_id_suffix" {
  type = string
}

resource "google_project" "host_project" {
  name = "${local.env}-${var.host_project_id_suffix}"
  project_id = "${local.env}-${var.host_project_id_suffix}"
  org_id = "${var.org_id}"
}

resource "google_project_service" "host_project_services" {
  for_each = toset([
    "compute.googleapis.com"
  ])
  project = "${local.env}-${var.host_project_id_suffix}"
  service = each.value
}

resource "google_compute_network" "shared_vpc" {
  name = "shared-vpc"
  auto_create_subnetworks = false
  routing_mode = "GLOBAL"
  depends_on = [
    google_project.host_project,
    google_project_service.host_project_services
  ]
}