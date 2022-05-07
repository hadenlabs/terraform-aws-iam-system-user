# How to use this project

```hcl
  module "main" {
    source  = "hadenlabs/iam-system-user/aws"
    version = "0.1.0"
    namespace  = "gitlab"
    stage      = "dev"
    name       = "bot"
  }
```

Full working examples can be found in [examples](./examples) folder.
