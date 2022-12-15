  terraform {
  required_providers {
    hcloud = {
      source = "hetznercloud/hcloud"
    }
    hetznerdns = {
      source = "timohirt/hetznerdns"
      version = "2.1.0"
    }
  }
  required_version = ">= 0.13"
}

provider "hcloud" {
  
}

provider "hetznerdns" {
}
