# Coral Projects Doc Sync

This simple script copies the /site directory of the coralproject/docs repo to s3 for hosting. 

It is drapped in a docker container and designed to be run on an Iron.io Iron Worker.

##Installation

1. Create an Iron.io account if you do not already have one.
2. Create an Iron.io Project.
3. In the project page, go to Credentials (Key icon) > Download iron.json file.
4. Place the iron.json file in this directory (/docs/docsync)
5. Install the Iron.io command line utility:
  `curl -sSL https://cli.iron.io/install | sh`
6. Copy `config.sample.sh` to `config.sh`
7. Enter the following values into config.sh:
  -GITHUB_REPO: Github repo to copy from
  -S3_BUCKET: S3 bucket to copy to
  -SUBDIR: Subdirectory of repo to copy, ie /site
  -AWS_ACCESS_KEY: AWS access key
  -AWS_SECRET_KEY: AWS secret key 
8. Upload docsync to iron.io:
 `zip -r docsync.zip . && iron worker upload --zip docsync.zip --name docsync coralproject/docsync ./docsync.sh`

