output "s3_basic_info" {
  value = "id: ${aws_s3_bucket.s3_bucket.id}; name: ${aws_s3_bucket.s3_bucket.bucket}; arn: ${aws_s3_bucket.s3_bucket.arn}"
}

output "s3_bucket_name" {
  value = aws_s3_bucket.s3_bucket.bucket
}


