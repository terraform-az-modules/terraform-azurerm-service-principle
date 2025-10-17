##-----------------------------------------------------------------------------
## Variables
##-----------------------------------------------------------------------------
variable "label_order" {
  type        = list(any)
  default     = ["name", "environment", "location"]
  description = "Label order, e.g. `name`,`application`,`centralus`."
}
variable "name" {
  description = "Base name for the Service Principal."
  type        = string
}

variable "environment" {
  description = "Environment name (e.g., dev, stage, prod)."
  type        = string
}

variable "location" {
  description = "Azure region where resources will be deployed."
  type        = string
}

variable "role_name" {
  description = "Role name to assign to the Service Principal (e.g., Contributor, Reader)."
  type        = string
  default     = null
}

variable "resource_group_name" {
  description = "Resource group name where the role assignment will be applied."
  type        = string
}

variable "custom_name" {
  description = "Optional: Override naming convention with a custom name."
  type        = string
  default     = null
}

