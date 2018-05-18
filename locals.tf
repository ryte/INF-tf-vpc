locals {
  name = "${var.tags.environment}-vpc"
  tags = "${merge(
    var.tags,
    map(
      "Name", "OpenShift Master"
      "Module", "vpc"
      "Name", "${local.name}"
    )
  )}"
}