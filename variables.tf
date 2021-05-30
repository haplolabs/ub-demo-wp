################################################################################
# Required Variables. These variables have no default and you will be requried #
# to provide them.                                                             #
################################################################################

# Our DigitalOcean API token.
variable do_token {}

# Name of your SSH Key as it appears in the DigitalOcean dashboard
variable ssh_key {
    type = string
}

# The first part of my URL. Ex: the www in www.digitalocean.com
variable "subdomain" {
    type = string
}

# Domain you have registered and DigitalOcean manages
variable domain_name {
    type = string
}

################################################################################
# Optional Variables. These have defaults set don't need to be modified for    #
# this to run. Modify them to your liking if you desire.terraform              #
################################################################################

# Name of your project. Will be prepended to most resources
variable "name" {
    type = string
    default = "hl-test"
}

# The region to deploy our infrastructure to.
variable "region" {
    type    = string
    default = "sfo3"
}

# The number of droplets to create.
variable "droplet_count" {
    type = number
    default = 1
}

# The size we want our droplets to be. 
# Can view slugs (valid options) https://slugs.do-api.dev/
variable "droplet_size" {
    type = string
    default = "s-1vcpu-1gb"
}

# The operating system image we want to use. 
# Can view slugs (valid options) https://slugs.do-api.dev/
variable "image" {
    type = string
    default = "ubuntu-20-04-x64"
}

# The size of the volume to create
variable "volume_size" {
    type = number
    default = 25
}

variable "pvt_key" {
}

variable "vpc_ip_range" {
  description = "ipv4 address cidr for vpc"
  default     = "192.168.160.0/24"
}
