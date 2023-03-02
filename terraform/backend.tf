terraform {
  backend "s3" {
    key    = "terraform"
    region = "ca-central-1"
  }
}
