# Requester's side of the connection. This resource will be created under the account from which the VPC peering was requested.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${var.main_vpc_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_owner_id = "${var.peer_account_id}"
  peer_region   = "${var.peer_region}"
  auto_accept   = false
  tags          = "${merge(local.tags,map("PeerSide","Requester"))}"
}

# Requester's side of the routing through the vpc peering.
resource "aws_route" "peering_route_requester" {
  depends_on                = ["aws_vpc_peering_connection.peer"]
  count                     = "${length(var.requester_route_table_ids)}"
  route_table_id            = "${var.requester_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.accepter_cidr_v4}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
}

# Accepter's side of the connection. This resource will be created under the account that receives the VPC peering request.
resource "aws_vpc_peering_connection_accepter" "peer" {
  provider                  = "aws.peer"
  depends_on                = ["aws_vpc_peering_connection.peer"]
  count                     = "${length(var.accepter_route_table_ids)}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true
  tags                      = "${merge(local.tags,map("PeerSide","Accepter"))}"
}

# Accepter's side of the routing through the vpc peering.
resource "aws_route" "peering_route_accepter" {
  provider                  = "aws.peer"
  depends_on                = ["aws_vpc_peering_connection_accepter.peer"]
  count                     = "${length(var.accepter_route_table_ids)}"
  route_table_id            = "${var.accepter_route_table_ids[count.index]}"
  destination_cidr_block    = "${var.requester_cidr_v4}"
  vpc_peering_connection_id = "${aws_vpc_peering_connection_accepter.peer.id}"
}
