terraform {
  backend "s3" {
    bucket         = "nomanikram-terraform-remote-assignment"
    key            = "rest/terraform.tfstate"  #var.env_config["statefile"]
    region         = "us-east-1"
    dynamodb_table = "nomanikram-terraform-remote-assignment"
  }

}

data "terraform_remote_state" "vpc" {
  backend = "s3"
  config = {
    bucket = "nomanikram-terraform-remote-assignment"
    key = "vpc/terraform.tfstate"
    region = "us-east-1"
  }
}