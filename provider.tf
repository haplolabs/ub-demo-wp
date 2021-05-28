terraform {
    required_version = ">= 0.15"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = "2.8.0"
      }
    }
    backend "remote" {
      organization  = "haplolabs"

      workspaces {
        name = "do_test_1"
      }
    }
}

variable "instance_count" {
  default = 1
}

variable "region" {
  default = "sfo3"
}

variable "do_token" {
}

variable "pvt_key" {
}

provider "digitalocean" {
    token = var.do_token
}

# data "digitalocean_ssh_key" "terraform" {
#   name = "cloudtraining"
# }
