# store the terraform state file in s3 and lock with dynamodb
terraform {
  backend "s3" {
    bucket         = "youni-terraform-remote-state"
    key            = "elearning-dev-project/terraform.tfstate"
    region         = "us-west-1"
    profile        = "default"
    dynamodb_table = "technodemics-dbTable"
  }


}



