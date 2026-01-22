**Terraform Type Constraints** :
Type constraints in Terraform are used with input variables to restrict the type of values a variable can accept. 
This helps prevent mistakes and makes your code more robust.
we have 2 types 
    1. Primitive Type Constraints
    2. Complex / Non-Primitive Types
**1. Primitive Type Constraints**: These are single-value types
| Type     | Description            | Example    |
| -------- | ---------------------- | ---------- |
| `string` | Text value             | `"eastus"` |
| `number` | Numeric value          | `42`       |
| `bool`   | Boolean (true / false) | `true`     |
Example:
    variable "environment" {
    type        = string
    description = "The environment name"
    default     = "Dev"
    }
    
    variable "replicas" {
    type        = number
    default     = 3
    }
    
    variable "is_production" {
    type    = bool
    default = false
    }
**2.Complex / Non-Primitive Types** : These are collections or structured values
| Type     | Description                               | Example                                      |
| -------- | ----------------------------------------- | -------------------------------------------- |
| `list`   | Ordered collection of values              | `["dev", "qa", "prod"]`                      |
| `set`    | Unordered collection of **unique** values | `["dev", "qa"]`                              |
| `map`    | Key-value pairs                           | `{ environment = "Dev", region = "ukwest" }` |
| `object` | Structured type with named attributes     | `{ name = string, location = string }`       |
| `tuple`  | Ordered collection with **mixed types**   | `[ "eastus", 3, true ]`                      |
Example:
    variable "regions" {
    type    = list(string)
    default = ["ukwest", "eastus"]
    }
    
    variable "env_tags" {
    type = map(string)
    default = {
    environment = "Dev"
    project     = "TerraformDemo"
    }
    }
    
    variable "server" {
    type = object({
    name     = string
    location = string
    enabled  = bool
    })
    default = {
    name     = "webserver"
    location = "ukwest"
    enabled  = true
    }
    }
    
    variable "mixed_tuple" {
    type    = tuple([string, number, bool])
    default = ["eastus", 2, true]
    }

