#Create VPC

resource "aws_vpc" "three-tier-vpc" {

    cidr_block = "10.0.0.0/16"
  
}

#Subnet creation

resource "aws_subnet" "webapp-public-AZ1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.1.0/24"

  tags = {
    Name = "webapp-public-AZ1"
  }
}

resource "aws_subnet" "webapp-public-AZ2" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1b"

  cidr_block = "10.0.2.0/24"

  tags = {
    Name = "webapp-public-AZ2"
  }
}

resource "aws_subnet" "apptier-private-AZ1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.3.0/24"

  tags = {
    Name = "apptier-private-AZ1"
  }
}

resource "aws_subnet" "apptier-private-AZ2" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.4.0/24"

  tags = {
    Name = "apptier-private-AZ2"
  }
}

resource "aws_subnet" "dbtier-private-AZ1" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1a"
  cidr_block = "10.0.5.0/24"

  tags = {
    Name = "dbtier-private-AZ1"
  }
}

resource "aws_subnet" "dbtier-private-AZ2" {
  vpc_id     = aws_vpc.three-tier-vpc.id
  availability_zone = "us-east-1b"
  cidr_block = "10.0.6.0/24"

  tags = {
    Name = "dbtier-private-AZ2"
  }
}

