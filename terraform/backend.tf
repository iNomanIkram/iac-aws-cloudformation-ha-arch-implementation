terraform {
  backend "s3" {
    bucket = "nomanikram-terraform-assignment"
    key =  "terraform.tfstate"  #var.env_config["statefile"]
    region = "us-east-1"
  }

}