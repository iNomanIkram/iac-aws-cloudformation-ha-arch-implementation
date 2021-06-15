terraform {
  backend "s3" {
    bucket         = "nomanikram-terraform-assignment"
    key            = "terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "nomanikram-terraform-assignment"
  }

}