
resource "aws_ebs_volume" "minecraft_ebs" {
  availability_zone = "us-east-1a"
  size              = 40

  tags = {
    Name = "HelloWorld"
  }
}

resource "aws_ebs_snapshot" "minecraft_ebs_snapshot" {
  volume_id = aws_ebs_volume.minecraft_ebs.id

  tags = {
    Name = "Minecraft_Files_Snapshot"
  }
}

#resource "aws_network_interface" "mc_ni" {
#  subnet_id   = module.vpc.public_subnets[0]
#  private_ips = ["10.0.11.2"]
#
#  tags = {
#    Name = "minecraft_ec2_network_interface"
#  }
#}

resource "aws_instance" "minecraft_server" {
  ami           = "ami-0742b4e673072066f" # us-east-1 Amazon Linux 2 AMI 
  instance_type = "t3.medium"
  # security_groups = ""
  # ebs_block_device = resource.aws_ebs_volume.id
  key_name = "minecraft_pem"
  subnet_id   = module.vpc.public_subnets[0]
  
  user_data = file("mc_setup.sh")
  associate_public_ip_address = "true"
  vpc_security_group_ids = [aws_security_group.ec2_sg.id]

#  network_interface {
#    network_interface_id = aws_network_interface.mc_ni.id
#    device_index         = 0
#  }
}

resource "aws_volume_attachment" "minecraft_files" {
  device_name = "/dev/sda2"
  volume_id   = aws_ebs_volume.minecraft_ebs.id
  instance_id = aws_instance.minecraft_server.id
}