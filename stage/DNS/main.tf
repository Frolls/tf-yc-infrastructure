
resource "cloudflare_record" "infrastructure" {
  for_each = toset(var.server_names)
  
  zone_id  = var.zone_id
  name     = format("%s.%s", each.value, file("domain"))
  value    = file("ip")
  type     = "A"
}
