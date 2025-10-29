terraform {
  backend "s3" {
    bucket = "anandcloudtech"
    key="day3/terraform.tfstate"
    region = "us-east-1"
    
  }
}
