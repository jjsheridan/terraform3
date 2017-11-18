provider "aws" {
	region = "us-west-2"
	}

data "aws_s3_bucket" "selected" {
	bucket = "tfstatez321"
	}
	
#resource "aws_s3_bucket" "tf-state-bucket" {
#	bucket = "tfstatez321"
#	acl = "private"
#	versioning {
#		enabled = true
#		}
	
#	lifecycle {
#		prevent_destroy = true
#		}
#	}

#output "s3_bucket_arn"	{
#	value = "${aws_s3_bucket.tf-state-bucket.arn}"
#	}

resource "aws_dynamodb_table" "terraform_statelock"	{
	name		= "statelock"
	read_capacity = 1
	write_capacity = 1
	hash_key 	= "LockID"
	
	attribute {
	  name = "LockID"
	  type = "S"
	  }
	 }

data "terraform_remote_state" "mybucket"	{
	backend = "s3"
	config {
	  encrypt = "true"
	  bucket = "tfstatez321"
	  key = "mybucket/terraform.tfstate"
	  region = "us-west-2"
	  }
	}
