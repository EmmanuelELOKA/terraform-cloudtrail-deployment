# root account
provider "aws" {
  alias = "Cloudtrail"
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}
# logs account
provider "aws" {
  alias = "s3"
  region     = "us-east-1"
  access_key = ""
  secret_key = ""
}
