locals {
  name   = "${var.environment}-subnet-public"
  is_ngw = var.ngw ? 1 : 0
}

locals {
  tags = merge(
    var.tags,
    {
      "Module" = "vpc/subnet/public"
      "Name"   = local.name
    },
  )
}
