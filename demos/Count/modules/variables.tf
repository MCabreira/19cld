variable "aws_region" {
  description = "The AWS region to create things in."
  default     = "us-east-1"
}

variable "aws_amis" {
  type = "map"
  default = {
    us-east-1 = "ami-13be557e"
    us-west-2 = "ami-06b94666"
    eu-west-1 = "ami-844e0bf7"
  }
}

variable "KEY_NAME" {
  default = "fiap-18cld"
}
variable "PATH_TO_KEY" {
  default = ".ssh/fiap-18cld.pem"
}
variable "INSTANCE_USERNAME" {
  default = "ubuntu"
}
variable "instance-count" {
  default = "1"
}

provider "aws" {
  region = "${var.aws_region}"
}

variable "project" {
  default = "18cld"
}

data "aws_vpc" "vpc" {
  tags {
    Name = "${var.project}"
  }
}

data "aws_subnet_ids" "all" {
  vpc_id = "${data.aws_vpc.vpc.id}"

  tags {
    Tier = "Public"
  }
}

data "aws_subnet" "public" {
  count = "${length(data.aws_subnet_ids.all.ids)}"
  id    = "${data.aws_subnet_ids.all.ids[count.index]}"
}

resource "random_shuffle" "random_subnet" {
  input        = ["${data.aws_subnet.public.*.id}"]
  result_count = 1
}

variable "filename" {
  description = "The name of the file, without the file extension, e.g. foo"
  // required = true
}
