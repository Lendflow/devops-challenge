
output "public_ip" {
  description = "The public IP address of the instance."
  value       = aws_eip.instance-public.public_ip
}
