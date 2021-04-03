resource "aws_instance" "instance-public" {
  ami                  = data.aws_ami.ubuntu.id
  iam_instance_profile = "${var.env}-${var.name}-profile"
  instance_type        = var.instance_type
  ebs_optimized = var.ebs_optimized
  lifecycle {
    ignore_changes = [ami]
  }
  root_block_device {
    volume_type = "gp2"
    volume_size = var.root_size
  }
  key_name               = var.keypair
  subnet_id              = data.aws_subnet.a.id
  tenancy                = var.tenancy
  vpc_security_group_ids = local.vpc_security_group_ids
  tags = merge(
    {
      "Name"                   = "${var.env}-${var.name}",
      "Role"                   = var.role
      "Cluster"                = var.cluster
      prometheus_node_exporter = "9100"
    },
    var.tags,
    local.default_tags,
  )
}

resource "aws_ebs_volume" "instance-public-data" {
  count             = var.ebs ? 1 : 0
  availability_zone = data.aws_subnet.a.availability_zone
  size              = var.ebs_size
  encrypted         = true
  type              = "gp2"

  tags = merge(
    {
      "Name"                   = "${var.env}-${var.name}",
      "Role"                   = var.role
      "Cluster"                = var.cluster
      prometheus_node_exporter = "9100"
    },
    var.tags,
    local.default_tags,
  )
}

resource "aws_volume_attachment" "instance-public-data" {
  count       = var.ebs ? 1 : 0
  device_name = "/dev/sde"
  volume_id   = aws_ebs_volume.instance-public-data[0].id
  instance_id = aws_instance.instance-public.id
}

