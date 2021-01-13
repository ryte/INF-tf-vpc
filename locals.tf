locals {
  name = "${var.environment}-vpc"
}

locals {
  tags = merge(
    var.tags,
    {
      "Module" = "vpc"
      "Name"   = local.name
    },
  )
}
