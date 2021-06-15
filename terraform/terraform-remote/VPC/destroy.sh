#!/usr/bin/env bash
terraform destroy -auto-approve -var-file="./configurations/dev/dev.tfvars" #-state="./dev.tfstate"