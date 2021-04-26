resource "aws_security_group" "ec2_sg" {
  name_prefix = "minecraft_"
  vpc_id      = module.vpc.vpc_id

  ingress {
    for_each = var.sg_ingress_rules
    from_port = each.value.from
    to_port   = each.value.to
    protocol  = each.value.proto
    cidr_blocks = each.value.cidr
  }

}

variable "sg_ingress_rules" {
    type        = map(map(any))
    default     = {
        port1 = {from=443, to=443, proto="tcp", cidr="0.0.0.0/0", desc=HTTPS"]
        port2 = {from=80, to=80, proto="tcp", cidr="1.2.3.4/32", desc="HTTP"}
        port3 = {from=25565, to=25565, proto="tcp", cidr="1.2.3.4/32", desc="MINECRAFT"}
        port4 = {from=22, to=22, proto="tcp", cidr="1.2.3.4/32", desc="SSH"}
    }
} 