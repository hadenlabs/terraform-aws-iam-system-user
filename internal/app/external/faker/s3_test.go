package faker

import (
	"testing"

	"github.com/stretchr/testify/assert"
)

func TestS3FakeBucketName(t *testing.T) {
	name := Bucket().Name()
	assert.NotEmpty(t, name)
}
