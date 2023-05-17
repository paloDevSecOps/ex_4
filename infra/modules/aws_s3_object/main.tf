resource "aws_s3_object" "object" {
  bucket = var.s3_bucket_name
  key    = var.s3_bucket_key
  source = var.source_path

  etag = filemd5(var.source_path)
}
