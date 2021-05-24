resource "aws_security_group" "ec2_sg" {
  name_prefix = "minecraft_"
  vpc_id      = module.vpc.vpc_id
}

resource "aws_security_group_rule" "mc_ingress_rules" {
  for_each          = var.sg_ingress_rules
  type              = "ingress"
  from_port         = each.value.from
  to_port           = each.value.to
  protocol          = each.value.proto
  cidr_blocks       = [each.value.cidr]
  description       = each.value.desc
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "mc_egress_rules" {
  type              = "egress"
  from_port         = 0
  to_port           = 0
  protocol          = -1
  cidr_blocks       = ["0.0.0.0/0"]
  description       = "allow all traffic out"
  security_group_id = aws_security_group.ec2_sg.id
}

variable "sg_ingress_rules" {
    type        = map(map(any))
    default     = {
        port1 = {from=443, to=443, proto="tcp", cidr="0.0.0.0/0", desc="HTTPS"},
        port2 = {from=80, to=80, proto="tcp", cidr="0.0.0.0/0", desc="HTTP"},
        port3 = {from=25565, to=25565, proto="tcp", cidr="0.0.0.0/0", desc="MINECRAFT"},
        port4 = {from=22, to=22, proto="tcp", cidr="0.0.0.0/0", desc="SSH"}
    }
} 