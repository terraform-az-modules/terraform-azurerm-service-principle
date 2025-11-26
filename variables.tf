##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "Label order, e.g. `name`,`application`,`centralus`."
}

variable "custom_name" {
  type        = string
  default     = null
  description = "Override default naming convention"
}

variable "name" {
  description = "The name of the Azure AD Application"
  type        = string
  default     = "my-app-registration"
}

variable "location" {
  type        = string
  default     = "canadacentral"
  description = "Azure region where the WAF policy will be deployed"
}

variable "environment" {
  type        = string
  default     = ""
  description = "Environment (e.g. `prod`, `dev`, `staging`)."
}

variable "resource_position_prefix" {
  type        = bool
  default     = true
  description = <<EOT
  Controls the placement of the resource type keyword (e.g., "vnet", "ddospp") in the resource name.

  - If true, the keyword is prepended: "vnet-core-dev".
  - If false, the keyword is appended: "core-dev-vnet".

  This helps maintain naming consistency based on organizational preferences.
  EOT
}

variable "managedby" {
  type        = string
  default     = "terraform-az-modules"
  description = "ManagedBy, eg 'terraform-az-modules'."
}

variable "repository" {
  type        = string
  default     = "https://github.com/terraform-az-modules/terraform-azurerm-waf"
  description = "Terraform current module repo"

  validation {
    # regex(...) fails if it cannot find a match
    condition     = can(regex("^https://", var.repository))
    error_message = "The module-repo value must be a valid Git repo link."
  }
}

variable "deployment_mode" {
  type        = string
  default     = "terraform"
  description = "Specifies how the infrastructure/resource is deployed"
}

variable "extra_tags" {
  type        = map(string)
  default     = null
  description = "Variable to pass extra tags."
}

variable "owner_object_id" {
  description = "Object ID of the owner (user or service principal)"
  type        = string
  default     = ""
}

variable "secret_map" {
  description = "Map of secret names to expiry times (Terraform duration format)"
  type        = map(string)
  default     = {}
}
variable "enable" {
  description = "Enable or disable creation of all resources"
  type        = bool
  default     = true
}
variable "enable_api_permission" {
  description = "Whether to enable Microsoft Graph API permissions (User.Read, Email, Profile, OpenID)"
  type        = bool
  default     = true
}
variable "enable_token_config" {
  type        = bool
  description = "Enable token configuration for the application"
  default     = true
}
variable "redirect_uris" {
  type        = list(string)
  description = "List of web redirect URIs for the Azure AD Application"
  default     = ["https://localhost/"]
}

variable "front_channel_logout_urls" {
  type        = list(string)
  description = "List of front-channel logout URLs"
  default     = ["https://localhost/logout"]
}
variable "api_permissions" {
  type = list(object({
    id   = string
    type = string
  }))
  default = [
    { id = "e1fe6dd8-ba31-4d61-89e7-88639da4683d", type = "Scope" },
    { id = "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0", type = "Scope" },
    { id = "14dad69e-099b-42c9-810b-d002981feec1", type = "Scope" },
    { id = "37f7f235-527c-4136-accd-4a02d197296e", type = "Scope" },
  ]
}
variable "resource_app_id" {
  description = "The App ID of the resource API (e.g. Microsoft Graph API)"
  type        = string
  default     = "00000003-0000-0000-c000-000000000000" # Microsoft Graph API
}