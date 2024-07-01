#Internet Gateway

resource "aws_internet_gateway" "three-tier-gw" {
  vpc_id = aws_vpc.three-tier-vpc.id

  tags = {
    Name = "three tier gateway"
  }
}


resource "aws_internet_gateway_attachment" "example" {
  internet_gateway_id = aws_internet_gateway.three-tier-gw.id
  vpc_id              = aws_vpc.three-tier-vpc.id
}


#NAT Gateway

resource "aws_eip" "nat_ip" {
  id = "eipalloc-08ddd8c4d7e7b71a7"
}


resource "aws_nat_gateway" "three-tier-nat-gateway" {
  subnet_id = aws_subnet.apptier-private-AZ1.id
  allocation_id = aws_eip.nat_ip.id

  tags = {
    Name = "three tier nat gateway"
  }

}