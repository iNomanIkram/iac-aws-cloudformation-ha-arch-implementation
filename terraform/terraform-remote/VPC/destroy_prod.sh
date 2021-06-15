#!/usr/bin/env bash
terraform destroy -auto-approve -var-file="./configurations/prod/prod.tfvars" #-state="./dev.tfstate"