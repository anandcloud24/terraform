terraform {
  backend "s3" {
    bucket = "anandcloudtech"
    key="terraform.tfstate"
    region = "us-east-1"
    
    
  }
}