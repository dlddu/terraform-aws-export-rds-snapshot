data "aws_caller_identity" "to" {
  provider = aws.to
}

data "aws_kms_key" "to" {
  provider = aws.to
  key_id   = "alias/aws/rds"
}

resource "aws_db_snapshot_copy" "to" {
  provider                      = aws.to
  source_db_snapshot_identifier = aws_db_snapshot_copy.from.db_snapshot_arn
  target_db_snapshot_identifier = var.to_snapshot_name
  kms_key_id                    = data.aws_kms_key.to.arn

  depends_on = [aws_kms_key_policy.from, null_resource.share]
}
