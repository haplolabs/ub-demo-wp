# The urn of the loadbalancer
output "digitalocean_instance_urn" {
  value = digitalocean_droplet.web.*.urn
}

# The fully qualified domain name of the load balancer
output "web_loadbalancer_fqdn" {
    value = digitalocean_record.public.fqdn
}

# The Private IPv4 Addresses of the droplets
output "web_servers_private" {
    value = digitalocean_droplet.web.*.ipv4_address_private
}

# The Public IPv4 Addresses of the droplets
output "web_servers_public" {
    value = digitalocean_droplet.web.*.ipv4_address
}

