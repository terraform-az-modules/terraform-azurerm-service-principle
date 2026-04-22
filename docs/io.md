## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| api\_permissions | A list of Azure AD API permission objects to assign to the application. Each permission must include the permission ID and type (Scope or Role). | <pre>list(object({<br>    id   = string<br>    type = string<br>  }))</pre> | <pre>[<br>  {<br>    "id": "e1fe6dd8-ba31-4d61-89e7-88639da4683d",<br>    "type": "Scope"<br>  },<br>  {<br>    "id": "64a6cdd6-aab1-4aaf-94b8-3cc8405e90d0",<br>    "type": "Scope"<br>  },<br>  {<br>    "id": "14dad69e-099b-42c9-810b-d002981feec1",<br>    "type": "Scope"<br>  },<br>  {<br>    "id": "37f7f235-527c-4136-accd-4a02d197296e",<br>    "type": "Scope"<br>  }<br>]</pre> | no |
| application\_roles | List of application roles to create. | <pre>list(object({<br>    display_name         = string<br>    value                = string<br>    description          = string<br>    allowed_member_types = optional(list(string), ["User", "Application"])<br>  }))</pre> | <pre>[<br>  {<br>    "description": "Read-only access to the application.",<br>    "display_name": "Reader",<br>    "value": "Reader"<br>  },<br>  {<br>    "description": "Full administrative access to the application.",<br>    "display_name": "Admin",<br>    "value": "Admin"<br>  }<br>]</pre> | no |
| enable | Enable or disable creation of all resources | `bool` | `true` | no |
| enable\_api\_permission | Whether to enable Microsoft Graph API permissions (User.Read, Email, Profile, OpenID) | `bool` | `true` | no |
| enable\_role\_assignment | Whether to create a role assignment for the service principal. | `bool` | `false` | no |
| front\_channel\_logout\_urls | List of front-channel logout URLs | `list(string)` | <pre>[<br>  "https://localhost/logout"<br>]</pre> | no |
| name | The name of the Azure AD Application | `string` | `"my-app-registration"` | no |
| owner\_object\_id | Object ID of the owner (user or service principal) | `string` | n/a | yes |
| redirect\_uris | List of web redirect URIs for the Azure AD Application | `list(string)` | <pre>[<br>  "https://localhost/"<br>]</pre> | no |
| resource\_app\_id | The App ID of the resource API (e.g. Microsoft Graph API) | `string` | `"00000003-0000-0000-c000-000000000000"` | no |
| role\_definition\_name | Role definition name to assign (e.g., Reader, AcrPull, Key Vault Reader). | `string` | `"Contributor"` | no |
| role\_scope | Scope for role assignment. Defaults to the current subscription if not set. | `string` | `null` | no |
| secret\_map | Map of secret names to expiry times (Terraform duration format) | `map(string)` | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| application\_object\_id | The object ID of the Azure AD Application |
| service\_principal\_client\_id | The Client ID (App ID) of the Service Principal |
| service\_principal\_display\_name | The display name of the Service Principal |
| service\_principal\_id | The ID (object ID) of the created Service Principal |
| service\_principal\_secrets | Map of secret names to their ID and value |

