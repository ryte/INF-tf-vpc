locals {
  name = "${var.environment}-${var.project}-vpc"
}

locals {
  tags = {
    CID         = "${var.cid}"
    Environment = "${var.environment}"
    Module      = "vpc"
    Name        = "${local.name}"
    Owner       = "${var.owner}"
    Project     = "${var.project}"
    Provisioner = "Terraform"
  }
}
