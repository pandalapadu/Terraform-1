In this session, we will discuss Terraform variables.

Terraform supports three types of variables:
        1. Input Variables
        2. Output Variables
        3. Local Variable
Summary :
Input variables accept values,
output variables expose values,
local variables process values.


1️⃣ Input Variables:
    - Used to provide input values to the Terraform configuration
    - Make the code flexible and reusable
    - Values can be passed using tfvars, CLI flags, or environment variables
2️⃣ Output Variables :
    - Used to retrieve values from Terraform after execution
    - Commonly used to expose resource attributes
    - Helpful for sharing values between modules
3️⃣ Local Variables :
    - Used for internal calculations and derived values
    - Help reduce duplication and improve code readability
    - Scoped only within the module

Terraform Variable Constraints (Data Types)
Terraform variable types are broadly classified into **primitive** and **non-primitive** types.
**Primitive Types** :: Primitive types allow only a single value.
        1. string – text values
        2. number – numeric values
        3. bool – true / false values
**Non-Primitive (Complex) Types** :: Non-primitive types allow complex or multiple values.
        1. list – ordered collection of values
        2. set – unordered collection of unique values
        3. map – key–value pairs
        4. object – structured values with named attributes
        5. tuple – ordered collection with mixed data types
Summary :
Primitive types store single values,
while non-primitive types store collections or structured data.
==================Example for each variable ====================
Terraform **Input Variable** _Precedence Order (lowest → highest)_:
        1.Defined in variable blocks
                variable "region" {
                default = "us-east-1"
                }
        
        2.terraform.tfvars-----------------> region = "us-west-2"
        3.Explicit -var-file flags --------> terraform apply -var-file="prod.tfvars"
        4.Environment variables (TF_VAR_*) → export TF_VAR_region="ap-south-1"
        5.Command-line -var flags (highest precedence) ---> terraform apply -var="region=ca-central-1"

Terraform **output Variable**
        output "rg_name" {
        value = azurerm_resource_group.rg.name
        }
Terraform **Local Variable** Example
Local variables are used for internal values and computations within a module.
            locals {
            rg_name = "rg-${var.project}-${var.env}"
            common_tags = {
            Environment = var.env
            Project     = var.project
            }
            }
Usage :
            resource "azurerm_resource_group" "rg" {
            name     = local.rg_name
            location = var.region
            tags     = local.common_tags
            }
=======================================================================
| Variable Type   | Purpose                                  |
| --------------- | ---------------------------------------- |
| Input Variable  | Accept values from users or environments |
| Local Variable  | Compute and reuse internal values        |
| Output Variable | Expose values after Terraform execution  |

Input variables follow a strict precedence order, local variables simplify internal logic, and output variables expose values from Terraform state.