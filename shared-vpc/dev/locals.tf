locals {
  env = "dev"
  subnets = {
    "${local.env}-${local.service_project_id_suffix}" : {
      primary_cidr = "192.168.0.0/24",
      region       = "asia-northeast1",
    }
  }
  vpc_serverless_access_connector = {
    region = "asia-northeast1"
    cidr   = "192.168.192.0/28"
  }
}
