data "aws_db_snapshot" "this" {
  db_snapshot_identifier = var.from_snapshot_name
}

resource "aws_db_snapshot_copy" "this" {
  source_db_snapshot_identifier = data.aws_db_snapshot.this.db_snapshot_arn
  target_db_snapshot_identifier = var.intermediate_snapshot_name
  kms_key_id                    = aws_kms_key.this.arn
  shared_accounts               = [var.to_account_id]
}
