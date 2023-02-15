locals {
  env    = "dev"
  region = "asia-northeast1"
  subnets = {
    "${local.env}-${local.service_project_id_suffix}" : {
      primary_cidr = "192.168.0.0/24",
      region       = "asia-northeast1",
    }
  }
  vpc_serverless_access_connector_cidr = "192.168.192.0/28"
}
