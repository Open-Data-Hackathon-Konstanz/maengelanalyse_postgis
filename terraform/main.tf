data "hetznerdns_zone" "dns_zone" {
    name = var.zone
}

resource "hcloud_server" "main" {
  name        = var.server_name
  image       = var.os_type
  server_type = var.server_type
  location    = var.location
  public_net {
    ipv4_enabled = true
    ipv6_enabled = false
  }

  user_data = file("cloud-config/user-data")
}

# Handle specific subdomain (books.example.com)
resource "hetznerdns_record" "main" {
  zone_id = data.hetznerdns_zone.dns_zone.id
  name    = "maengel"
  value   = hcloud_server.main.ipv4_address
  type    = "A"
}

resource "local_file" "ansible_inventory" {
  content = templatefile("inventory.tmpl",
    {
      ip   = hcloud_server.main.ipv4_address
      user = "user"
    }
  )
  filename = "../ansible/hosts"
}