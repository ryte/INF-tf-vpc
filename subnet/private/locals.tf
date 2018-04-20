locals {
  name = "${var.environment}-${var.project}-subnet-private-${var.name}"
}

locals {
  tags = {
    CID         = "${var.cid}"
    Environment = "${var.environment}"
    Module      = "vpc/subnet/private"
    Name        = "${local.name}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
    Provisioner = "Terraform"
  }
}

locals {
  is_egw = "${var.gw =="egw" ? 1 : 0}"
  is_ngw = "${var.gw =="ngw" ? 1 : 0}"
}
