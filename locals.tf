locals {
  name = "${var.tags["Environment"]}-vpc"
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

