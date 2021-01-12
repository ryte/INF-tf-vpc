locals {
  name = "${var.environment}-subnet-private"
}

locals {
  tags = merge(
    var.tags,
    {
      "Module" = "vpc/subnet/private"
      "Name"   = local.name
    },
  )
}

locals {
  is_egw = var.gw == "egw" ? 1 : 0
  is_ngw = var.gw == "ngw" ? 1 : 0
}
