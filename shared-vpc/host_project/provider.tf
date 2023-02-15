terraform {
  required_version = "1.3.8"
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "4.51.0"
    }
  }
}

variable "project_id" {
  type = string
}

provider "google" {
  credentials = file("service-account.json")
  project = "${var.project_id}"
  region  = "us-central1"
  zone    = "us-central1-c"
}