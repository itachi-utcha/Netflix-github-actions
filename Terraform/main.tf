resource "aws_instance" "github-actions-project" {
  ami  = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t3.xlarge"
  subnet_id = "subnet-0b790859db11a06b7"
  key_name = "N.Verginia"
  vpc_security_group_ids = [aws_security_group.jenkins-sg.id]
  user_data = templatefile("./user_data.sh", {})
  tags = {
    Name = "github-actions-project"
  }
  root_block_device {
    volume_size = 20
  }
  iam_instance_profile = "SSM-2-Advanced"
}

resource "aws_security_group" "jenkins-sg" {
  name        = "Jenkins-Security Group"
  description = "Open 22,443,80,8080,9000"

  # Define a single ingress rule to allow traffic on all specified ports
  ingress = [
    for port in [22, 80, 443, 8081, 9000,] : {
      description      = "TLS from VPC"
      from_port        = port
      to_port          = port
      protocol         = "tcp"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }
  ]

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Jenkins-sg"
  }
}
