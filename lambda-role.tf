resource "aws_iam_role_policy" "lambda_policy" {
  name   = "lambda_json2ddb_policy"
  role   = aws_iam_role.lambda_json2ddb_role.id
  policy = file("iam/lambda-policy.json")
}

resource "aws_iam_role" "lambda_json2ddb_role" {
  name               = "lambda_json2ddb_role"
  assume_role_policy = file("iam/lambda-assume-policy.json")
}