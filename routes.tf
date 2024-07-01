#Route Table for Internet Gateway

resource "aws_route_table" "three-tier-rtb" {
  vpc_id = aws_vpc.three-tier-vpc.id


  route {
    cidr_block = aws_vpc.three-tier-vpc.cidr_block
    gateway_id = aws_internet_gateway.three-tier-gw.id

  }

  tags = {
    Name = "three-tier-rtb"
  }
}


resource "aws_route_table_association" "rtb_association" {
  route_table_id = aws_route_table.three-tier-rtb.id
  subnet_id = aws_subnet.webapp-public-AZ1.id
}

#Route table for NAT Gateway

resource "aws_route_table" "three-tier-rtb-natgw" {
    vpc_id = aws_vpc.three-tier-vpc.id
    
    tags = {
    Name = "nat gateway route table"
  }
  
}

# Route through NAT Gateway
resource "aws_route" "nat_gateway_route" {
  route_table_id         = aws_route_table.three-tier-rtb-natgw.id
  destination_cidr_block = "0.0.0.0/0"
  nat_gateway_id         = aws_nat_gateway.three-tier-nat-gateway.id
}

# Route Table Association with Private Subnets
resource "aws_route_table_association" "private_subnet_association_AZ1" {
  subnet_id      = aws_subnet.apptier-private-AZ1.id
  route_table_id = aws_route_table.three-tier-rtb-natgw.id
}