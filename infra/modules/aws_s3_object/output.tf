output "s3_object" {
  value = "Uploaded to S3 file: \nid: ${resource.aws_s3_object.object.id}\nkey: ${resource.aws_s3_object.object.key}\nversion_id: ${resource.aws_s3_object.object.version_id}\n"
}
