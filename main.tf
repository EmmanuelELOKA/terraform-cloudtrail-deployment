resource "aws_cloudtrail" "CloudTrail" {
  provider = "aws.Cloudtrail"
  name = "GlobalS3DataEventsTrail"
  s3_bucket_name = aws_s3_bucket.S3BucketForCloudTrail.id
  is_multi_region_trail = true
  enable_log_file_validation = true
  is_organization_trail = true

  event_selector {
    include_management_events = true
    read_write_type = "All"
    data_resource {
      type = "AWS::S3::Object"
      values = ["arn:aws:s3:::jdp-cloudtrail-logs-20220618"]
    }
  }
}

resource "aws_s3_bucket" "S3BucketForCloudTrail" {
  provider = "aws.s3"
  bucket = "jdp-cloudtrail-logs-20220618"
  policy = <<POLICY
{
    "Version": "2012-10-17",
    "Statement": [
        {
            "Sid": "AWSCloudTrailAclCheck",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:GetBucketAcl",
            "Resource": "arn:aws:s3:::jdp-cloudtrail-logs-20220618"
        },
        {
            "Sid": "AWSCloudTrailWrite",
            "Effect": "Allow",
            "Principal": {
              "Service": "cloudtrail.amazonaws.com"
            },
            "Action": "s3:PutObject",
            "Resource": "arn:aws:s3:::jdp-cloudtrail-logs-20220618/AWSLogs/*",
            "Condition": {
                "StringEquals": {
                    "s3:x-amz-acl": ["public-read",
                        "public-read-write",
                        "authenticated-read"],
		    "aws:SourceArn": "arn:aws:s3:::jdp-cloudtrail-logs-20220618/AWSLogs/*"	
                }
            }
        }
    ]
}
POLICY
}
