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

resource "digitalocean_droplet" "chromedp_build" {
    image  = "debian-12-x64"
    name   = "chromedp-build"
    region = "sgp1"
    size   = "c-16"
    ssh_keys = [data.digitalocean_ssh_key.ssh_key.id]
}

output "chromedp_build" {
    value = digitalocean_droplet.chromedp_build.ipv4_address
}
