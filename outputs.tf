output "authentik_module_brand_dummy" {
  description = "dummy output value (\"\") for creating dependencies from this module"
  value       = null_resource.authentik_bootstrap_brand.triggers.authentik_module_brand_dummy
}
