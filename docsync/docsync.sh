. ./config.sh
git clone $GITHUB_REPO ./repo
cd repo/$SUBDIR
s3cmd -rPM --access_key=$AWS_ACCESS_KEY --secret_key=$AWS_SECRET_KEY --region=US sync ./ s3://$S3_BUCKET
