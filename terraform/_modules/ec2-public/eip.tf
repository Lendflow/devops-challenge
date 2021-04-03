resource "aws_eip" "instance-public" {
  vpc = true
}

resource "aws_eip_association" "instance-public" {
  instance_id   = aws_instance.instance-public.id
  allocation_id = aws_eip.instance-public.id
}

