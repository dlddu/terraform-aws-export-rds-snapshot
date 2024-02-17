output "migrated_snapshot_name" {
  value = aws_db_snapshot_copy.to.target_db_snapshot_identifier
}
