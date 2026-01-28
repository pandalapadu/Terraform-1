What are Terraform modules ?
Terraform modules are reusable templates for infrastructure.
Instead of writing the same Terraform code again and again, we package it once as a module and reuse it.

Why do we use modules?
1.Reusability
        Write code once        
        Use it for dev, test, prod
2.Consistency
        Same naming, same settings, fewer mistakes
3.Clean & readable code
        Main Terraform files stay small
        Complex logic lives inside modules
4.Team collaboration
        One team builds modules
        Others just use them

Terraform Modules explained using a Student Progress Card .
Step 1: The problem (without modules)
Imagine a school where: 
Every teacher designs their own progress card
    Different formats
    Different subjects order
    Different grading styles

Result:
    Confusion
    Inconsistency
    More mistakes
    Hard to compare students

This is like writing Terraform code without modules — repeated, messy, and error-prone.
Step 2: The solution (modules)
    The school decides: “We will create one standard progress card template and reuse it for every student.”
    That standard template = Terraform module

| Student Progress Card      | Terraform Module     |
| -------------------------- | -------------------- |
| Progress card template     | Module               |
| Student name, roll no      | Input variables      |
| Subjects & marks logic     | Resource definitions |
| Total, grade, result       | Outputs              |
| Same card for all students | Reusable module      |

Step 3: Inputs (Variables)
Each student is different, but the format stays the same.
For every student, we only change: Name= Student name  , Roll number: Student class num, Marks: Student marks
Terraform : we only change : vnet_name , location, resource_group

Step 4: Outputs :After filling the progress card, we get: Total marks, Grade , Pass/Fail
Terraform Outputs : resource IDs, IP addresses, URLs

Step 5: Reusability
One progress card template can be used for:  Class 1 to Class 10, Any section, Any year.
Same way: One Terraform module Used for dev, test, prod Used by different teams as well .

Step 6: Why this matters in real projects
Without modules: Every student has a different card ❌ , Hard to maintain ❌
With modules: Same structure for everyone ✅  ,Easy to update (change template once) ✅ ,Professional & scalable ✅

Folder structure for multiple environments
terraform-azure/
│
├── modules/
│   ├── resource-group/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   ├── network/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   │
│   └── compute/
│       ├── main.tf
│       ├── variables.tf
│       └── outputs.tf
│
├── envs/
│   ├── dev/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── terraform.tfvars
│   │
│   ├── test/
│   └── prod/
=======in our example we are creating following ==================
08-Terraform-Modules
│
├── 01.envs        → Different students (dev / stage / prod)
│
└── 02.modules     → Progress card templates (reusable)

What should clearly understand

| Concept    | Dev       | Stage     | Prod      |
| ---------- | --------- | --------- | --------- |
| Modules    | Same      | Same      | Same      |
| Code logic | Same      | Same      | Same      |
| Names      | Different | Different | Different |
| VM size    | Small     | Medium    | Large     |
