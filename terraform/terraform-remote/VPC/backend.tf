terraform {
  backend "s3" {
    bucket         = "nomanikram-terraform-remote-assignment"
    key            = "vpc/terraform.tfstate"  #var.env_config["statefile"]
    region         = "us-east-1"
    dynamodb_table = "nomanikram-terraform-remote-assignment"
  }

}