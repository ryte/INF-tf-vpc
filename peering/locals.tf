locals {
  name = "${var.environment}-${var.project}-peering"
}

locals {
  tags = {
    CID         = "${var.cid}"
    Environment = "${var.environment}"
    Module      = "vpc/peering"
    Name        = "${local.name}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
    Provisioner = "Terraform"
  }
}
