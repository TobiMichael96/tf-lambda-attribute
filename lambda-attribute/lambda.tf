resource "aws_iam_role" "default" {
  name = "${var.project}-${var.stage}-lambda-default"

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    "Statement" = [
      {
        Action = "sts:AssumeRole",
        Principal = {
          Service = "lambda.amazonaws.com"
        },
        Effect = "Allow",
        Sid    = ""
      }
    ]
  })

  tags = local.tags
}

resource "aws_iam_role_policy" "s3_read" {
  name = "${var.project}-${var.stage}-lambda-s3-read"
  role = aws_iam_role.default.id

  policy = jsonencode(
    {
      Version = "2012-10-17",
      "Statement" = [
        {
          Sid = "ExampleStmt",
          Action = [
            "s3:GetObject"
          ],
          Effect   = "Allow",
          Resource = var.s3_buckets
        }
      ]
  })
}

resource "aws_lambda_function" "default" {
  filename      = data.archive_file.lambda_zip.output_path
  function_name = "${var.project}-${var.stage}-default"
  role          = aws_iam_role.default.arn
  handler       = "index.handler"

  environment {
    variables = {
      BUCKET = "tme-tf-state"
      KEY    = "tf_lambda_test.tfstate"
    }
  }

  source_code_hash = filebase64sha256(data.archive_file.lambda_zip.output_path)

  runtime = "nodejs12.x"

  tags = local.tags
}

data "archive_file" "lambda_zip" {
  type        = "zip"
  source_file = "${path.module}/files/index.js"
  output_path = "${path.module}/files/lambda_function.zip"
}