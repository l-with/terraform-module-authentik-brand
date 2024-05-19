variable "authentik_url" {
  description = "the url of the authentik instance"
  type        = string
}

variable "authentik_token" {
  description = "the token for the authentik"
  type        = string
  sensitive   = true
}

variable "authentik_brand_domain" {
  description = "the domain for selecting the authentik default brand"
  type        = string
  default     = "authentik-default"
}

variable "authentik_brand_default" {
  description = "if the authentik default brand should become brand"
  type        = bool
  default     = false
}
