#!/usr/bin/env bash
terraform apply -auto-approve -var-file="./configurations/prod/prod.tfvars" #-state="./dev.tfstate"