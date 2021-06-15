//output "Database" {
//  value = aws_instance.database
//}

output "Database" {
  value = {
    "instance" = aws_instance.database

  }
}