locals {
  name   = "${var.environment}-${var.project}-subnet-public-${var.name}"
  is_ngw = "${var.ngw ? 1 : 0}"
}

locals {
  tags = {
    CID         = "${var.cid}"
    Environment = "${var.environment}"
    Module      = "vpc/subnet/public"
    Name        = "${local.name}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
    Provisioner = "Terraform"
  }
}
