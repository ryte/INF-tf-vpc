locals {
  name = "${var.tags["Environment"]}-vpc"
}

locals {
  tags = "${merge(
    var.tags,
    map(
      "Module", "vpc",
      "Name", "${local.name}"
    )
  )}"
}