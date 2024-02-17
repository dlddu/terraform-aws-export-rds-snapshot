data "aws_caller_identity" "from" {
  provider = aws.from
}

resource "aws_db_snapshot" "from" {
  provider               = aws.from
  db_instance_identifier = var.from_db_identifier
  db_snapshot_identifier = local.exported_snapshot_name
}

resource "aws_kms_key" "from" {
  provider = aws.from
}

resource "aws_db_snapshot_copy" "from" {
  provider                      = aws.from
  source_db_snapshot_identifier = aws_db_snapshot.from.db_snapshot_arn
  target_db_snapshot_identifier = local.encrypted_snapshot_name
  kms_key_id                    = aws_kms_key.from.arn
}
