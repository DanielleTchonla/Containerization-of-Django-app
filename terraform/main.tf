
resource "aws_vpc" "my_vpc" {
    cidr_block = var.vpc_CIDR
}

resource "aws_subnet" "my_subnet" {
    count =1
    vpc_id = aws_vpc.my_vpc.id
    cidr_block = cidrsubnet(var.vpc_CIDR, 1, count.index * 2)

}

resource "aws_internet_gateway" "my_igw" { 
    vpc_id = aws_vpc.my_vpc.id
}

resource "aws_route_table" "my_route_table" {
    vpc_id = aws_vpc.my_vpc.id
    route {
        cidr_block = "0.0.0.0/0"
        gateway_id = aws_internet_gateway.my_igw.id
    }
}

resource "aws_route_table_association" "my_route_table_association" {
    subnet_id = aws_subnet.my_subnet[0].id
    route_table_id = aws_route_table.my_route_table.id
}

resource "aws_security_group" "my_sg" {
    vpc_id = aws_vpc.my_vpc.id
    ingress {
        from_port = 22
        to_port = 22
        protocol = "tcp"
        cidr_blocks = ["69.181.48.253/32"]
    }
    ingress {
        from_port = 8080
        to_port = 8080
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }
    ingress {
        from_port = 8000
        to_port = 8000
        protocol = "tcp"
        cidr_blocks = ["0.0.0.0/0"]
    }

    egress {
        from_port = 0
        to_port = 0
        protocol = "-1"
        cidr_blocks = ["0.0.0.0/0"]
    }
}


resource "aws_instance" "jenkins_instance" {
  count                    = 1
  ami                      = "ami-080e1f13689e07408"
  instance_type            = "c3.large"
  key_name                 = var.key_name
  vpc_security_group_ids   = [aws_security_group.my_sg.id]
  subnet_id                = aws_subnet.my_subnet[0].id
  associate_public_ip_address = true

  user_data = base64encode(file("./userdata.sh"))
#   > file("${path.module}/hello.txt")

  



  tags = {
    Name = "Jenkins_Danielle"
  }
}
