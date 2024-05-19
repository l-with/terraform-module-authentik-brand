# terraform-module-authentik-brand

Terraform module which configures the default [authentik](https://goauthentik.io/docs/brands) brand.

Authentik comes with predefined resources. 
The anchor is the default brand, which is marked as 
to be used for each domain that doesn't have a dedicated brand.

As a consequence the 
[terraform-provider authentik](https://registry.terraform.io/providers/goauthentik/authentik) 
can not create a new brand
to be used for each domain that doesn't have a dedicated brand,
since there could only be one brand with this characteristic.

This module changes the default brand by a direct API call by 
[local-exec](https://www.terraform.io/language/resources/provisioners/local-exec) 
in a [null_resource](https://registry.terraform.io/providers/hashicorp/null).

The following code changes the default brand to 
not be used for each domain that doesn't have a dedicated brand.

```

module "brand" {
  source                   = "l-with/authentik-brand/module"
  version                  = ">= 0.0.3"
  authentik_url            = var.authentik_url
  authentik_token          = var.authentik_bootstrap_token
  authentik_brand_default  = false
}
 ```

The brand is selected by the input variable `authentik_brand_domain` which default value is `"authentik-default"`.

The module provides an output value `authentik_module_brand_dummy` 
that depends on the null_resource with the local-exec.
The value is `""`.
You can use it to create an implicit dependency in every resource with a string value, 
for example a new 
[resource authentik_brand](https://registry.terraform.io/providers/goauthentik/authentik/latest/docs/resources/brand):

```
resource "authentik_brand" "default" {
  domain           =  "${module.brand.authentik_module_brand_dummy}."
  default          = true
  branding_logo    = "/static/dist/assets/icons/icon_left_brand.svg"
  branding_favicon = "/static/dist/assets/icons/icon.png"
}
```