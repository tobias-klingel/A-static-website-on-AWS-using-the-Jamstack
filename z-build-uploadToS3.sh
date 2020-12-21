#!/usr/bin/env bash

#This schript runs "hugo", delted old fieles in S3, flushed cache and uploads new files

bucketname=my-unique-bucket-name #<-------------------- Edit!

# CloudFront ID
distributionID=XXXXXXXXXXX #<----------------------------------------- Edit!

#AWS profile
profileName=myaws #<----------------------------------------- Edit! Must be the same as in ~.aws/credentials

echo "**************************************************************"
echo "Run hugo build script and upload to AWS"
echo "Run \$hugo"
hugo
echo "**************************************************************"
echo ""

echo "**************************************************************"
echo "Delete old files in S3 bucket, Bucket name: "$bucketname
aws s3 rm s3://$bucketname --recursive --profile $profileName
echo "**************************************************************"
echo ""

echo "**************************************************************"
echo "Flush CloudFront cache, distribution ID: " $distributionID
aws cloudfront create-invalidation \
    --distribution-id $distributionID \
    --paths "/*" --profile $profileName
echo "**************************************************************"
echo ""

echo "**************************************************************"
echo "Upload files to S3"
aws s3 cp public/ s3://$bucketname --grants read=uri=http://acs.amazonaws.com/groups/global/AllUsers --recursive --profile $profileName
echo "**************************************************************"
echo ""

echo "-----------> Script finished <-------------"
echo ""
