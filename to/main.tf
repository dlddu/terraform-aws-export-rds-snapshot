data "aws_kms_key" "this" {
  key_id = "alias/aws/rds"
}

resource "aws_db_snapshot_copy" "this" {
  source_db_snapshot_identifier = var.intermediate_snapshot_arn
  target_db_snapshot_identifier = var.to_snapshot_name
  kms_key_id                    = data.aws_kms_key.this.arn
}
