# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "techno-terraform-remote-state"
    key            = "elearning-project/terraform.tfstate"
    region         = "us-west-1"
    profile        = "default"
    dynamodb_table = "techno-state-lock"
  }


}

#can you see the console??
# Yes


