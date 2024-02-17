data "aws_iam_policy_document" "share" {
  statement {
    effect = "Allow"
    principals {
      type        = "AWS"
      identifiers = ["arn:aws:iam::${data.aws_caller_identity.from.account_id}:root", "arn:aws:iam::${data.aws_caller_identity.to.account_id}:root"]
    }
    actions   = ["kms:*"]
    resources = ["*"]
  }
}

resource "aws_kms_key_policy" "from" {
  provider = aws.from
  key_id   = aws_kms_key.from.id
  policy   = data.aws_iam_policy_document.share.json
}

resource "null_resource" "share" {
  triggers = {
    snapshot_id = aws_db_snapshot_copy.from.target_db_snapshot_identifier
  }

  provisioner "local-exec" {
    command = "aws rds modify-db-snapshot-attribute --db-snapshot-identifier ${self.triggers.snapshot_id} --attribute-name restore --values-to-add ${data.aws_caller_identity.to.account_id} --profile ${var.from_profile_name} --region ${var.region}"
  }

  depends_on = [aws_db_snapshot_copy.from]
}
