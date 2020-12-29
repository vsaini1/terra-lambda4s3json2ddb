locals {
  lambda_zip_loca = "outputs/json2ddb.zip"
}

data "archive_file" "zipfile" {
  type        = "zip"
  source_file = "json2ddb.py"
  output_path  = local.lambda_zip_loca
}

resource "aws_lambda_function" "crt_lambda" {
  function_name = "app_json2ddb"
  filename      = local.lambda_zip_loca
  role          = aws_iam_role.lambda_json2ddb_role.arn
  handler       = "json2ddb.upd_ddb"
  runtime       = "python3.7"

  #source_code_hash = filebase64sha256(local.lambda_zip_loca)
  source_code_hash = filebase64sha256(data.archive_file.zipfile.source_file)
  
  environment {
    variables = {
      foo = "bar"
    }
  }
}