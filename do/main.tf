terraform {
  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "~> 2.0"
    }
  }
}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_ssh_key" "ssh_key" {
  name = var.do_ssh_key
}

resource "digitalocean_volume" "chromedp_vol" {
  region                  = "sgp1"
  name                    = "chromedp-vol"
  size                    = 200
  initial_filesystem_type = "ext4"
  description             = "contains chromedp source tree"
}

#resource "digitalocean_droplet" "chromedp_build" {
#  image     = "debian-12-x64"
#  name      = "chromedp-build"
#  region    = "sgp1"
#  #size      = "c-16"
#  size      = "s-4vcpu-8gb"
#  ssh_keys  = [data.digitalocean_ssh_key.ssh_key.id]
#}
#
#resource "digitalocean_volume_attachment" "chromedp_attach" {
#  droplet_id  = digitalocean_droplet.chromedp_build.id
#  volume_id = digitalocean_volume.chromedp_vol.id
#}
#
#output "chromedp_build" {
#    value =  digitalocean_droplet.chromedp_build.ipv4_address
#}
