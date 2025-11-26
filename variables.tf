##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "name" {
  type        = string
  default     = "my-app-registration"
  description = "The name of the Azure AD Application"
}

variable "owner_object_id" {
  type        = string
  description = "Object ID of the owner (user or service principal)"
}

variable "secret_map" {
  type        = map(string)
  default     = {}
  description = "Map of secret names to expiry times (Terraform duration format)"
}

variable "enable" {
  type        = bool
  default     = true
  description = "Enable or disable creation of all resources"
}

variable "enable_api_permission" {
  type        = bool
  default     = true
  description = "Whether to enable Microsoft Graph API permissions (User.Read, Email, Profile, OpenID)"
}

variable "redirect_uris" {
  type        = list(string)
  default     = ["https://localhost/"]
  description = "List of web redirect URIs for the Azure AD Application"
}

variable "front_channel_logout_urls" {
  type        = list(string)
  default     = ["https://localhost/logout"]
  description = "List of front-channel logout URLs"
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
    description = "A list of Azure AD API permission objects to assign to the application. Each permission must include the permission ID and type (Scope or Role)."
  }

variable "resource_app_id" {
  type        = string
  default     = "00000003-0000-0000-c000-000000000000" # Microsoft Graph API
  description = "The App ID of the resource API (e.g. Microsoft Graph API)"
}

variable "enable_role_assignment" {
  type        = bool
  default     = false
  description = "Whether to create a role assignment for the service principal."
}

variable "role_definition_name" {
  type        = string
  default     = "Contributor"
  description = "Role definition name to assign (e.g., Reader, AcrPull, Key Vault Reader)."
}

variable "role_scope" {
  type        = string
  default     = null
  description = "Scope for role assignment. Defaults to the current subscription if not set."
}

variable "application_roles" {
  type = list(object({
    display_name         = string
    value                = string
    description          = string
    allowed_member_types = optional(list(string), ["User", "Application"])
  }))
  default = [
    {
      display_name = "Reader"
      value        = "Reader"
      description  = "Read-only access to the application."
    },
    {
      display_name = "Admin"
      value        = "Admin"
      description  = "Full administrative access to the application."
    }
  ]
  description = "List of application roles to create."
}
