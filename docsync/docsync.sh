. ./config.sh
git clone $GITHUB_REPO ./repo
cd ./repo
mkdocs build --clean
cd $SUBDIR
s3cmd del -r --force --access_key=$AWS_ACCESS_KEY --secret_key=$AWS_SECRET_KEY s3://$S3_BUCKET
s3cmd put ./* -rM --force --no-mime-magic --guess-mime-type --access_key=$AWS_ACCESS_KEY --secret_key=$AWS_SECRET_KEY s3://$S3_BUCKET 