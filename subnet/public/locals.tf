locals {
  name = "${var.tags["Environment"]}-subnet-public"
  is_ngw = "${var.ngw ? 1 : 0}"
}


locals {
  tags = "${merge(
    var.tags,
    map(
      "Module", "vpc/subnet/public",
      "Name", "${local.name}"
    )
  )}"
}