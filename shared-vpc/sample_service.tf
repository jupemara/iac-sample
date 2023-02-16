locals {
  service_project_id_suffix = "sample-service-001"
  users = [
    "group:developers@example.com"
  ]
}
resource "google_project" "sample_service_project_001" {
  name            = "${local.env}-${local.service_project_id_suffix}"
  project_id      = "${local.env}-${local.service_project_id_suffix}"
  folder_id       = var.folder_id
  billing_account = var.billing_account
}

resource "google_project_service" "sample_service_project_001" {
  for_each = toset([
    "compute.googleapis.com",
  ])
  project = "${local.env}-${local.service_project_id_suffix}"
  service = each.value
}

resource "google_compute_shared_vpc_service_project" "sample_service_project_001" {
  host_project    = var.host_project_id
  service_project = google_project.sample_service_project_001.name
}

resource "google_compute_subnetwork" "subnets" {
  for_each                 = local.subnets
  name                     = "${each.key}-${each.value.region}"
  region                   = each.value.region
  network       = "${local.env}-${var.shared_vpc_name}"
  ip_cidr_range            = each.value.primary_cidr
  private_ip_google_access = true
}

resource "google_compute_subnetwork_iam_member" "subnet_iam_assign" {
  for_each = { for v in setproduct(
    keys(google_compute_subnetwork.subnets),
    local.users,
  ) : join(":", v) => v }
  project    = var.host_project_id
  region     = google_compute_subnetwork.subnets[each.value[0]].region
  subnetwork = google_compute_subnetwork.subnets[each.value[0]].name
  role       = "roles/compute.networkUser"
  member     = each.value[1]
}

resource "google_vpc_access_connector" "vpc_serverless_access_connector" {
  name          = "vpc-serverless-connector"
  region        = local.vpc_serverless_access_connector.region
  ip_cidr_range = local.vpc_serverless_access_connector.cidr
  network       = "${local.env}-${var.shared_vpc_name}"
}
