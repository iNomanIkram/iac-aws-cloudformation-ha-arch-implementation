#!/usr/bin/env bash
terraform apply -auto-approve -var-file="./configurations/dev/dev.tfvars" #-state="./dev.tfstate"