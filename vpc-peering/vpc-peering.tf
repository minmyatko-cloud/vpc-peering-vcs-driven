resource "aws_vpc_peering_connection" "fevpc_peering_bevpc" {
  vpc_id      = data.tfe_outputs.fe_network_ws.nonsensitive_values.frontend_vpc_id
  peer_vpc_id = data.tfe_outputs.be_network_ws.nonsensitive_values.backend_vpc_id
  auto_accept = true

  accepter {
    allow_remote_vpc_dns_resolution = true
  }

  requester {
    allow_remote_vpc_dns_resolution = true
  }
}

resource "aws_route" "fevpc_private_subnet02_to_bevpc_private_subnet02" {
  route_table_id            = data.tfe_outputs.fe_network_ws.nonsensitive_values.frontend_private_routetable02_id
  destination_cidr_block    = data.tfe_outputs.be_network_ws.nonsensitive_values.backend_private_subnets_cidr_blocks["private_subnet_2"]
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

resource "aws_route" "bevpc_private_subnet02_to_fevpc_private_subnet02" {
  route_table_id            = data.tfe_outputs.be_network_ws.nonsensitive_values.backend_private_routetable02_id
  destination_cidr_block    = data.tfe_outputs.fe_network_ws.nonsensitive_values.frontend_private_subnets_cidr_blocks["private_subnet_2"]
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

resource "aws_route" "fevpc_private_subnet03_to_bevpc_private_subnet03" {
  route_table_id            = data.tfe_outputs.fe_network_ws.nonsensitive_values.frontend_private_routetable03_id
  destination_cidr_block    = data.tfe_outputs.be_network_ws.nonsensitive_values.backend_private_subnets_cidr_blocks["private_subnet_3"]
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

resource "aws_route" "bevpc_private_subnet03_to_fevpc_private_subnet03" {
  route_table_id            = data.tfe_outputs.be_network_ws.nonsensitive_values.backend_private_routetable03_id
  destination_cidr_block    = data.tfe_outputs.fe_network_ws.nonsensitive_values.frontend_private_subnets_cidr_blocks["private_subnet_3"]
  vpc_peering_connection_id = aws_vpc_peering_connection.fevpc_peering_bevpc.id
}

# fe-securty-group (inbound from backend and outbound to backend)

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_ssh_from_be_private_sg02" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  referenced_security_group_id = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg02_allow_icmp_from_be_private_sg02" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  referenced_security_group_id = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "fe_private_sg02_allow_ssh_to_be_private_instance_02" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  cidr_ipv4                    = "${data.tfe_outputs.be_compute_ws.nonsensitive_values.be_private_instance_ips["instance_02"]}/32"
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "fe_private_sg02_allow_icmp_to_be_private_instance_02" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  cidr_ipv4                    = "${data.tfe_outputs.be_compute_ws.nonsensitive_values.be_private_instance_ips["instance_02"]}/32"
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_ssh_from_be_private_sg03" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  referenced_security_group_id = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "fe_private_sg03_allow_icmp_from_be_private_sg03" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  referenced_security_group_id = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "fe_private_sg03_allow_ssh_to_be_private_instance_03" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  cidr_ipv4                    = "${data.tfe_outputs.be_compute_ws.nonsensitive_values.be_private_instance_ips["instance_03"]/32}"
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "fe_private_sg03_allow_icmp_to_be_private_instance_03" {
  security_group_id            = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  cidr_ipv4                    = "${data.tfe_outputs.be_compute_ws.nonsensitive_values.be_private_instance_ips["instance_03"]}/32"
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

# Be-Secuirty-Group

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_ssh_from_fe_private_sg02" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  referenced_security_group_id = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg02_allow_icmp_from_fe_private_sg02" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  referenced_security_group_id = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg02_id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg02_allow_ssh_to_fe_instance_02" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  cidr_ipv4                    = "${data.tfe_outputs.fe_compute_ws.nonsensitive_values.fe_private_instance_ips["instance_02"]}/32"
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg02_allow_icmp_to_fe_instance_2" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg02_id
  cidr_ipv4                    = "${data.tfe_outputs.fe_compute_ws.nonsensitive_values.fe_private_instance_ips["instance_02"]}/32"
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_ssh_from_fe_private_sg03" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  referenced_security_group_id = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_ingress_rule" "be_private_sg03_allow_icmp_from_fe_private_sg03" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  referenced_security_group_id = data.tfe_outputs.fe_security_ws.nonsensitive_values.frontend_private_sg03_id
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg03_allow_ssh_to_fe_instance_3" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  cidr_ipv4                    = "${data.tfe_outputs.fe_compute_ws.nonsensitive_values.fe_private_instance_ips["instance_03"]}/32"
  from_port                    = 22
  ip_protocol                  = "tcp"
  to_port                      = 22
}

resource "aws_vpc_security_group_egress_rule" "be_private_sg03_allow_icmp_to_fe_instance_3" {
  security_group_id            = data.tfe_outputs.be_security_ws.nonsensitive_values.backend_private_sg03_id
  cidr_ipv4                   = "${data.tfe_outputs.fe_compute_ws.nonsensitive_values.fe_private_instance_ips["instance_03"]}/32"
  from_port                    = 8
  ip_protocol                  = "icmp"
  to_port                      = 0
}