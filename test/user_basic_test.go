package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
	"github.com/stretchr/testify/assert"

	"github.com/hadenlabs/terraform-aws-iam-system-user/internal/app/external/faker"
	"github.com/hadenlabs/terraform-aws-iam-system-user/internal/testutil"
)

func TestBasicSuccess(t *testing.T) {
	t.Parallel()

	tags := map[string]interface{}{
		"tag1": "tags1",
	}
	namespace := testutil.Company
	stage := testutil.Stage
	name := faker.Server().Name()
	enabled := true

	terraformOptions := &terraform.Options{
		// The path to where your Terraform code is located
		TerraformDir: "user-basic",
		Upgrade:      true,
		Vars: map[string]interface{}{
			"namespace": namespace,
			"stage":     stage,
			"name":      name,
			"enabled":   enabled,
			"tags":      tags,
		},
	}

	// At the end of the test, run `terraform destroy` to clean up any resources that were created
	defer terraform.Destroy(t, terraformOptions)

	// This will run `terraform init` and `terraform apply` and fail the test if there are any errors
	terraform.InitAndApply(t, terraformOptions)
	outputUserName := terraform.Output(t, terraformOptions, "user_name")
	assert.NotEmpty(t, outputUserName, outputUserName)
}
