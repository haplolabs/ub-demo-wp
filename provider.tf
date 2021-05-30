terraform {
    required_version = ">= 0.15"
    required_providers {
      digitalocean = {
        source = "digitalocean/digitalocean"
        version = ">=2.8.0"
      }
    }
    backend "remote" {
      organization  = "haplolabs"

      workspaces {
        name = "do_test_1"
      }
    }
}


provider "digitalocean" {
    token = var.do_token
}
