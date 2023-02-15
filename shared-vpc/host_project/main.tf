resource "google_project_service" "host" {
  for_each = toset([
    "compute.googleapis.com"
  ])
  project = "${var.project_id}"
  service = each.value
}