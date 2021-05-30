resource "digitalocean_volume" "data" {
  # Number of volumes to create (one per droplet created)
  count       = var.droplet_count

  # Region to build the asset in
  region      = var.region

  # My volume name
  name 	      = "web-${var.name}-${var.region}-data-${count.index +1}"

  # Size of volume to create
  size        = var.volume_size

  description = "Data volume for instances"
}

resource "digitalocean_droplet" "web" {
  # How many instances to create
  count  	= var.droplet_count

  # Region to build the asset
  region 	= var.region

  # The image type to use
  image  	= var.image

  # My one true name
  name 	        = "web-${var.name}-${var.region}-count.index +1}"

  # Droplet size
  size   	= var.droplet_size

  # The VPC to put this instance in
  vpc_uuid	= digitalocean_vpc.web-vpc.id

  # SSH keys to place in instance initially
  ssh_keys = [
    data.digitalocean_ssh_key.main.id
  ]

  # Attach data volume to instance. Will attach unique volume per instance
  volume_ids = [element(digitalocean_volume.data.*.id, count.index)]

  # Tags for identifying the droplets and allowing db firewall access
  tags = ["${var.name}-webserver", "Haplolabs Testing Infrastructure"]

  #--------------------------------------------------------------------------#
  # Use user data, also known as cloud-init, to do an initial configuration  #
  # of the servers. This example is just for demonstration. In reality it    #
  # would probably be more advantageous to use a configuration management    #
  # system after server initialization.                                      #
  #--------------------------------------------------------------------------#
  user_data = <<EOF
  #cloud-config
  packages:
      - nginx
      - git
  runcmd:
      - wget -P /var/www/html https://raw.githubusercontent.com/do-community/terraform-sample-digitalocean-architectures/master/01-minimal-web-db-stack/assets/index.html
      - sed -i "s/CHANGE_ME/web-${var.region}-${count.index +1}/" /var/www/html/index.html
  EOF

  #-----------------------------------------------------------------------------------------------#
  # Ensures that we create the new resource before we destroy the old one                         #
  # https://www.terraform.io/docs/configuration/resources.html#lifecycle-lifecycle-customizations #
  #-----------------------------------------------------------------------------------------------#
  lifecycle {
      create_before_destroy = true
  }
}

