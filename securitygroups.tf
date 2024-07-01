resource "aws_security_group" "internet-facing-lb-sg" {
  vpc_id      = aws_vpc.three-tier-vpc.id
  name        = "Internet-facing-lb-sg"
  description = "External Load Balancer security group"

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "webtier-sg" {
  vpc_id      = aws_vpc.three-tier-vpc.id
  name        = "webtier-sg"
  description = "SG for the Web Tier"

  
  ingress {
    from_port   = "My IP"
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ aws_security_group.internet-facing-lb-sg.id ]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "internal-lb-sg" {
  vpc_id      = aws_vpc.three-tier-vpc.id
  name        = "internal-lb-sg"
  description = "SG for the Internal Load Balancer"

  
  ingress {
    from_port   = "My IP"
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ aws_security_group.webtier-sg.id ]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}


resource "aws_security_group" "privateinstance-sg" {
  vpc_id      = aws_vpc.three-tier-vpc.id
  name        = "privateinstance-sg"
  description = "SG for the Web Tier"

  
  ingress {
    from_port   = "My IP"
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    security_groups = [ aws_security_group.internal-lb-sg.id ]
  }

    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}

resource "aws_security_group" "DB-instance-sg" {
  vpc_id      = aws_vpc.three-tier-vpc.id
  name        = "DB-instance-sg"
  description = "SG for the Database SG"

  
  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


    egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

}
