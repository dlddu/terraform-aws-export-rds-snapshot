data "aws_db_snapshot" "this" {
  db_snapshot_identifier = var.from_snapshot_name
}

resource "aws_db_snapshot_copy" "this" {
  source_db_snapshot_identifier = data.aws_db_snapshot.this.db_snapshot_arn
  target_db_snapshot_identifier = var.intermediate_snapshot_name
  kms_key_id                    = aws_kms_key.this.arn
}

resource "terraform_data" "this" {
  triggers_replace = aws_db_snapshot_copy.this.db_snapshot_arn

  provisioner "local-exec" {
    command = "aws rds modify-db-snapshot-attribute --db-snapshot-identifier ${aws_db_snapshot_copy.this.target_db_snapshot_identifier} --attribute-name restore --values-to-add ${var.to_account_id} --profile ${var.profile} --region ${var.region}"
  }
}
