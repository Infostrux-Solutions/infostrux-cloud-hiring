data "aws_iam_policy_document" "lambda_assume_role_policy" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]
    principals {
      type        = "Service"
      identifiers = ["lambda.amazonaws.com"]
    }
  }
}

resource "aws_iam_role" "lambda_role" {
  name               = "${local.prefix}-role"
  assume_role_policy = data.aws_iam_policy_document.lambda_assume_role_policy.json
}

data "aws_iam_policy_document" "lambda_policy" {
  statement {
    effect = "Allow"
    actions = [
      "s3:GetObject",
      "s3:ListBucket",
      "s3:PutObject",
    ]
    resources = [
      module.ingest_s3.s3_bucket_arn,
      "${module.ingest_s3.s3_bucket_arn}/*"
    ]
  }
  statement {
    effect = "Allow"
    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
    ]
    resources = [
      "arn:aws:logs:*:*:*",
    ]
  }
}

resource "aws_iam_policy" "lambda_policy" {
  name   = "${local.prefix}-policy"
  path   = "/"
  policy = data.aws_iam_policy_document.lambda_policy.json
}

resource "aws_iam_role_policy_attachment" "lambda_policy" {
  role       = aws_iam_role.lambda_role.name
  policy_arn = aws_iam_policy.lambda_policy.arn
}

resource "aws_cloudwatch_log_group" "lambda" {
  name              = "/aws/lambda/${local.prefix}-lambda"
  retention_in_days = 7
}

module "lambda_function" {

  source  = "terraform-aws-modules/lambda/aws"
  version = "4.10.1"

  function_name = "${local.prefix}-lambda"
  handler       = "lambda_function.lambda_handler"
  runtime       = "python3.9"
  publish       = true

  create_package         = false
  local_existing_package = "${path.module}/builds/lambda_source.zip"

  timeout     = 10
  memory_size = 128

  create_role = false
  lambda_role = aws_iam_role.lambda_role.arn

  environment_variables = {
    UPLOAD_BUCKET = module.ingest_s3.s3_bucket_id
  }

  attach_cloudwatch_logs_policy     = false
  cloudwatch_logs_retention_in_days = 7
  use_existing_cloudwatch_log_group = true

  tags = {
    Name = "${local.prefix}-lambda"
  }
}

resource "aws_cloudwatch_event_rule" "cron_trigger" {
  name                = "${local.prefix}-event-rule"
  description         = "Schedule lambda function"
  schedule_expression = "rate(60 minutes)"
}

resource "aws_cloudwatch_event_target" "lambda_event" {
  target_id = "${local.prefix}-event-target"
  rule      = aws_cloudwatch_event_rule.cron_trigger.name
  arn       = module.lambda_function.lambda_function_arn
}

resource "aws_lambda_permission" "allow_cloudwatch" {
  statement_id  = "AllowExecutionFromCloudWatch"
  action        = "lambda:InvokeFunction"
  function_name = module.lambda_function.lambda_function_name
  principal     = "events.amazonaws.com"
  source_arn    = aws_cloudwatch_event_rule.cron_trigger.arn
}
