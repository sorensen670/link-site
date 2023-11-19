terraform {
  backend "s3" {
    bucket = "msorensen-tfstate-remote"
    key    = "projects/website/terraform.tfstate"
    region = "us-east-2"
  }
}