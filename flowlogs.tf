resource "aws_flow_log" "flow_log" {
  count           = var.deploy_flowlogs ? 1 : 0
  tags            = local.tags
  log_destination = aws_cloudwatch_log_group.log_group[0].arn
  iam_role_arn    = aws_iam_role.flowlogs_role[0].arn
  vpc_id          = aws_vpc.vpc.id
  traffic_type    = var.flowlogs_traffic_type
}

resource "aws_cloudwatch_log_group" "log_group" {
  count             = var.deploy_flowlogs ? 1 : 0
  name              = "flowlogs-${local.name}"
  retention_in_days = var.flowlogs_retention_in_days

  tags = merge(local.tags, {Name = "flowlogs-${local.name}"})
}

resource "aws_iam_role" "flowlogs_role" {
  count = var.deploy_flowlogs ? 1 : 0
  name  = "flowlogs_role-${local.name}"
  tags  = local.tags

  assume_role_policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Sid": "",
      "Effect": "Allow",
      "Principal": {
        "Service": "vpc-flow-logs.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
EOF

}

resource "aws_iam_role_policy" "flowlogs_policy" {
  count = var.deploy_flowlogs ? 1 : 0
  name  = "flowlogs-${local.name}"
  role  = aws_iam_role.flowlogs_role[0].id

  policy = <<EOF
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Action": [
        "logs:CreateLogGroup",
        "logs:CreateLogStream",
        "logs:PutLogEvents",
        "logs:DescribeLogGroups",
        "logs:DescribeLogStreams"
      ],
      "Effect": "Allow",
      "Resource": "*"
    }
  ]
}
EOF

}
