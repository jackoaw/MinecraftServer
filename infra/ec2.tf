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

resource "aws_instance" "minecraft_server" {
  ami           = "ami-0742b4e673072066f" # us-east-1 Amazon Linux 2 AMI 
  instance_type = "t3.medium"
  # security_groups = ""
  # ebs_block_device = resource.aws_ebs_volume.id
  key_name = "kubKeyPair"
  
  user_data = << EOF
  #! /bin/bash
  curl https://launcher.mojang.com/v1/objects/1b557e7b033b583cd9f66746b7a9ab1ec1673ced/server.jar ~
  java -Xmx1024M -Xms1024M --nogui --universe /minecraft -jar --world friends minecraft_server.1.16.5.jar
  EOF

  associate_public_ip_address = "true"
  vpc_security_group_ids = module.aws_security_group.ec2_sg
}

resource "aws_volume_attachment" "minecraft_files" {
  device_name = "/minecraft"
  volume_id   = aws_ebs_volume.minecraft_ebs.id
  instance_id = aws_instance.minecraft_server.id
}