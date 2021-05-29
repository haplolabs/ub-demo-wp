resource "digitalocean_volume" "data" {
  count       = var.instance_count
  region      = var.region
  name        = "${terraform.workspace}-${count.index}-data"
  size        = 100
  description = "an example volume"
}

resource "digitalocean_droplet" "web" {
  count  = var.instance_count
  region = var.region
  image  = "ubuntu-20-04-x64"
  name   = "${terraform.workspace}-${count.index}-web"
  size   = "s-1vcpu-1gb-amd"
  ssh_keys = [
    data.digitalocean_ssh_key.terraform.id
  ]

  volume_ids = [element(digitalocean_volume.data.*.id, count.index)]
}

