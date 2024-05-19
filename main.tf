resource "null_resource" "authentik_bootstrap_brand" {
  provisioner "local-exec" {
    command = "${path.module}/authentik-bootstrap-brand.sh"
    environment = {
      AUTHENTIK_URL                   = var.authentik_url
      AUTHENTIK_TOKEN                 = var.authentik_token
      AUTHENTIK_DEFAULT_BRAND_DOMAIN  = var.authentik_brand_domain
      AUTHENTIK_DEFAULT_BRAND_DEFAULT = var.authentik_brand_default
    }
  }
  triggers = {
    authentik_module_brand_dummy = ""
    authentik_url                = var.authentik_url
    authentik_token              = var.authentik_token
    authentik_brand_domain       = var.authentik_brand_domain
    authentik_brand_default      = var.authentik_brand_default
  }
}