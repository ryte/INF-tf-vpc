locals {
  name = "${var.environment}-${var.project}-peer"
}

locals {
  tags = {
    CID         = "${var.cid}"
    Environment = "${var.environment}"
    Module      = "vpc/peer"
    Name        = "${local.name}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
    Provisioner = "Terraform"
  }
}
