**Terraform Meta-Arguments**
What are Meta-Arguments in Terraform?  _**Think of them as instructions to Terraform, not to the cloud provider**._
    In Terraform, meta-arguments are special arguments that apply to many resource and module blocks.
    They do not configure the infrastructure itself. Instead, they control how Terraform creates, manages, and tracks resources.

**Why Meta-Arguments Matter**
Meta-arguments allow you to:
    - Control resource creation order
    - Create multiple similar resources
    - Manage updates and replacements safely
    - Handle multi-region or multi-account deployments

They are essential for writing scalable, predictable, and maintainable Terraform code.
**Terraform Meta-Arguments**

| Meta-Argument | Purpose                                                 | Where Used         | Key Notes / Best Practices                                     |
| ------------- | ------------------------------------------------------- | ------------------ | -------------------------------------------------------------- |
| `depends_on`  | Forces explicit dependency between resources            | Resources, Modules | Use only when Terraform can’t infer dependencies automatically |
| `count`       | Creates multiple instances of a resource                | Resources, Modules | Index-based; changing count may recreate resources             |
| `for_each`    | Iterates over a map or set to create multiple resources | Resources, Modules | Preferred over `count` for stable resource identity            |
| `provider`    | Selects a specific provider configuration               | Resources, Modules | Useful for multi-region and multi-account setups               |
| `lifecycle`   | Controls create, update, and destroy behavior           | Resources only     | Helps avoid downtime and accidental deletions                  |
| `provisioner` | Executes scripts during create/destroy                  | Resources only     | Discouraged; use only as a last resort                         |

lifecycle Sub-Arguments
| Sub-Argument            | Function                                | Typical Use Case                |
| ----------------------- | --------------------------------------- | ------------------------------- |
| `prevent_destroy`       | Blocks resource deletion                | Protect critical infrastructure |
| `create_before_destroy` | Replaces resource without downtime      | Load balancers, servers         |
| `ignore_changes`        | Ignores specific attribute changes      | External tag or config changes  |
| `replace_triggered_by`  | Forces replacement on dependency change | Tightly coupled resources       |

count vs for_each ## Important  for Interview point question

| Aspect            | `count`                | `for_each`             |
| ----------------- | ---------------------- | ---------------------- |
| Collection type   | Number                 | Map or Set             |
| Resource identity | Index-based (`[0]`)    | Key-based (`["name"]`) |
| Stability         | Less stable            | More stable            |
| Recommended use   | Simple, fixed replicas | Most real-world cases  |

Example for each use case :

1.depends_on : Forces Terraform to create one resource after another, even if Terraform cannot infer the dependency automatically.
        resource "aws_instance" "app" {
        ami           = "ami-123"
        instance_type = "t3.micro"
        
        depends_on = [aws_security_group.app_sg]
        }
2. count : Creates multiple instances of the same resource.
       resource "aws_instance" "web" {
       count         = 3
       ami           = "ami-123"
       instance_type = "t3.micro"
       }
   Accessing instances:aws_instance.web[0].id
   Limitations:
        - Index-based
        - Changing the count can cause resource recreation
3. for_each: Creates multiple resources based on a collection (map or set).
   resource "aws_instance" "web" {
   for_each = toset(["a", "b", "c"])
     ami           = "ami-123"
     instance_type = "t3.micro"
        tags = {
         Name = each.key
        }
      }
   Accessing instances: aws_instance.web["a"].id
   Why preferred over count:
              - Resources have stable identities
               - Safer for long-term infrastructure
4. provider: Specifies which provider configuration to use for a resource.
   resource "aws_instance" "west" {
   provider = aws.us_west_2
   ami      = "ami-123"
   }
   Use case:
         - Multi-region 
          - Multi-account deployments
5. lifecycle: Controls how Terraform handles resource changes and destruction.
   resource "aws_instance" "critical" {
   ami           = "ami-123"
   instance_type = "t3.micro"
lifecycle {
prevent_destroy       = true
create_before_destroy = true
ignore_changes        = [tags]
}
}
   Lifecycle options:
       - prevent_destroy – blocks accidental deletion
       - create_before_destroy – avoids downtime
       - ignore_changes – ignores external modifications
       - replace_triggered_by – forces replacement when dependencies change
6. provisioner (Discouraged) - Runs scripts during resource creation or destruction.
   provisioner "local-exec" {
   command = "echo Hello"
   }
