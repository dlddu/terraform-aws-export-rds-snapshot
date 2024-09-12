output "intermediate_snapshot_arn" {
  value = aws_db_snapshot_copy.this.db_snapshot_arn
}
