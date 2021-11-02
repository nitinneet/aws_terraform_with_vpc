################ Creating Provider ###########
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 3.0"
    }
  }

  backend "s3" {
    #bucket = "yourdomain-terraform"
    bucket  = "terra-state-bucket23"
    key    = "prod/terraform.tfstate"
    region = "us-east-1"
  }
}

provider "aws" {
    access_key = "${var.aws_access_key}"
    secret_key = "${var.aws_secret_key}"
    region     = "${var.region}"
    profile    = "${var.aws_profile}"
}

provider "kubernetes" {

host                   = aws_eks_cluster.ekscluster.endpoint
cluster_ca_certificate = base64decode(aws_eks_cluster.ekscluster.certificate_authority[0].data)
token                  = data.aws_eks_cluster_auth.eksauth.token
load_config_file       = false

}

provider "aws" {
  alias  = "acm_provider"
  region = "${var.region}"
}
