terraform {
  backend "s3" {
    bucket       = "pranjali-web-state-bucket-s3"
    key          = "global/s3/terraform.tfstate"
    region       = "ap-southeast-1"
    encrypt      = true
    use_lockfile = true
  }
}
