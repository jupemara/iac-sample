variable "service_project_id_suffix" {
  type = string
  default = "sample-service-001"
}

resource "google_project" "sample_service_project_001" {
  name = "${local.env}-${var.service_project_id_suffix}"
  project_id = "${local.env}-${var.service_project_id_suffix}"
  org_id = "${var.org_id}"
}

resource "google_project_service" "service_project" {
  for_each = toset([
    "compute.googleapis.com"
  ])
  project = "${local.env}-${var.service_project_id_suffix}"
  service = each.value
}