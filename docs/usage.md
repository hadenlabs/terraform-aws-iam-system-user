# How to use this project

```hcl
  module "main" {
    source  = "hadenlabs/terraform-aws-iam-system-user/aws"
    version = "0.0.0"
    namespace  = "gitlab"
    stage      = "dev"
    name       = "bot"
  }
```

Full working examples can be found in [examples](./examples) folder.
