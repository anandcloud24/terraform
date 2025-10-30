terraform {
  backend "s3" {
    bucket              = "cloudanand.in"
    key                 = "terraform.tfstate"
    region              = "us-east-1"
    s3_use_lockfile     = true
    encrypt             = true
  }
}

