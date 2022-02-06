terraform {
  backend "remote" {
    organization = "rx-terraform"
    workspaces {
      name = "integration"
    }
  }
  required_version = ">= 0.13.0"
}


variable "AWS_ACCESS_KEY" {
}

variable "AWS_SECRET_KEY" {
}

variable "AWS_REGION" {
  default = "us-west-2"
}

provider "aws" {
  region     = var.AWS_REGION
  access_key = var.AWS_ACCESS_KEY
  secret_key = var.AWS_SECRET_KEY
}

variable "AMIS" {
  type = map(string)
  default = {
    # Ubuntu 20:    "ami-0892d3c7ee96c0bf7"
    # Amazon Linux: "ami-066333d9c572b0680"

    us-west-2 = "ami-0892d3c7ee96c0bf7"
    us-east-1 = "ami-04505e74c0741db8d"
  }
}

resource "aws_instance" "rx-terraform-vm" {
  ami           = var.AMIS[var.AWS_REGION]
  instance_type = "t2.micro"
  key_name      = "richardx"
  tags = {
    Name = "rx-terraform-vm"
  }
}

output "my-output" {
  value = aws_instance.rx-terraform-vm
}
