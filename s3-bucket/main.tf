# Configure the AWS Provider
provider "aws" {
  region = "us-west-1"
}

resource "aws_s3_bucket" "rachel_dela_rama" {
  bucket = "rachel-dela-rama"
}