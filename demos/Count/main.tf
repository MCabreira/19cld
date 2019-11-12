# Specify the provider and access details
terraform {
  backend "s3" {
    bucket = "19cld-mba-prod"
    key    = "Count/terraform.state"
    region = "us-east-1"
  }
}


module "compute" {
  source = "./modules"
  filename = "cabreira" 
  instance-count = 2
}
