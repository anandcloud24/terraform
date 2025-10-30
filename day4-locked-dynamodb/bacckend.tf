terraform {
  backend "s3" {
    bucket = "cloudanand.in"
    key="terraform.tfstate"
    region = "us-east-1"
    
  }
}
