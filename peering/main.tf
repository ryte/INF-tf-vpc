# Requester's side of the connection. This resource will be created under the account from which the VPC peering was requested.
resource "aws_vpc_peering_connection" "peer" {
  vpc_id        = "${var.main_vpc_id}"
  peer_vpc_id   = "${var.peer_vpc_id}"
  peer_owner_id = "${var.peer_account_id}"
  peer_region   = "${var.peer_region}"
  auto_accept   = false
  tags          = "${merge(local.tags,map("PeerSide","Requester"))}"
}

# Accepter's side of the connection. This resource will be created under the account that receives the VPC peering request.
resource "aws_vpc_peering_connection_accepter" "peer" {
  depends_on                = ["aws_vpc_peering_connection.peer"]
  provider                  = "aws.peer"
  vpc_peering_connection_id = "${aws_vpc_peering_connection.peer.id}"
  auto_accept               = true
  tags                      = "${merge(local.tags,map("PeerSide","Accepter"))}"
}
