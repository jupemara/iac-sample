locals {
  env = "stg"
  subnets = {
    "${local.env}-${var.service_project_id_suffix}" : {
      primary_cidr = "192.168.1.0/24",
    region = "asia-northeast1", }
  }
  vpc_serverless_access_connector {
    cidr   = "192.168.193.0/28"
    region = "asia-northeast1"
  }
}
