# Coral Projects Doc Sync

This folder contains scripts and configuration files that generate a copy of the static html files by MkDocs from the Markdown (.md) files and copies them to the AWS S3 bucket for hosting which is viewable via CloudFront (due to https requirements by HSTS).


## Automated Publishing Workflow
1. Docs are maintained and update in markdown files
2. Github service hook to iron.io which runs Docker file
3. Server generates MkDocs site folder, copying contents to AWS S3 bucket using [http://s3tools.org/s3cmd](http://s3tools.org/s3cmd)
4. AWS Cloudfront displays static files created by MkDocs

## Team Process Workflow
1. Clone git repository
2. Ensure local repository is synched to master
3. If working on significant changes, create new branch
4. Commit changes to Github
5. Solicit Coral Team members for review and feedback
6. Merge changes

## URLs
- Production [https://docs.coralproject.net](https://docs.coralproject.net)
- Staging and testing [https://testdocs.coralproject.net](https://testdocs.coralproject.net)

## Commands

- Command to delete all files from S3 bucket using [s3tools](http://s3tools.org/s3cmd)

	~~~~
	s3cmd del -r --force s3://testdocs.coralproject.net/
	~~~~
- Command to put (push) all files to S3 using [s3tools](http://s3tools.org/s3cmd)

	~~~~
	s3cmd put ./site/* -rvMP --force --no-mime-magic --guess-mime-type s3://testdocs.coralproject.net/
	~~~~

- Command to sync all changed files by comparing the md5 checksum between local and S3 bucket files using [s3tools](http://s3tools.org/s3cmd)
	~~~~

	s3cmd sync ./site/* -rvM --force --no-mime-magic --guess-mime-type --check-md5 s3://testdocs.coralproject.net/
	~~~~

- Command to compress and upload docsync folder contents to Iron.io (run within the folder)

	~~~~
zip -r docsync.zip . && iron worker upload --zip docsync.zip --name docsync coralproject/docsync ./docsync.sh
	~~~~

## Automated Publishing Workflow Set Up //Needs Update//
1. Create an Iron.io account if you do not already have one.
2. Create an Iron.io Project.
3. In the project page, go to Credentials (Key icon) > Download iron.json file.
4. Place the iron.json file in this directory (/docs/docsync)
5. Install the Iron.io command line utility:
  `curl -sSL https://cli.iron.io/install | sh`
6. Copy `config.sample.sh` to `config.sh`
7. Enter the following values into config.sh:
	  - GITHUB_REPO: Github repo to copy from
	  - S3_BUCKET: S3 bucket to copy to
	  - SUBDIR: Subdirectory of repo to copy, ie /site
	  - AWS_ACCESS_KEY: AWS access key
	  - AWS_SECRET_KEY: AWS secret key 
8. Upload docsync to iron.io:
 `zip -r docsync.zip . && iron worker upload --zip docsync.zip --name docsync coralproject/docsync ./docsync.sh`


