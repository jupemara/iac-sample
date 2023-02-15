locals {
  env = "prd"
  subnets = {
    "${local.env}-${var.service_project_id_suffix}" : {
      primary_cidr = "10.0.0.0/20"
    region = "asia-northeast1" }
  }
  vpc_serverless_access_connector {
    _cidr  = "10.255.10.0/28"
    region = "asia-northeast1"
  }
}
