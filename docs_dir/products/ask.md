# Ask

_Updated: 11/3/2016_

### Latest Release 0.0.7

- [Download the latest release](https://github.com/coralproject/ask-install/releases) of the ask-installer from our Github repository

- If you have questions about installing Ask, please email [jeff@mozillafoundation.org](jeff@mozillafoundation.org).

## What is Ask?

Ask enables newsrooms and media companies to create custom comment forms which can be easily embededed into media websites.

* **Attract multimedia contributions**: Ask can help you gather submissions in a variety of formats including text, photo, video, and audio, helping you craft immersive, authentic and sensory-driven articles
* **Surface high quality comments**: Contributions can be connected to user profiles, allowing editors to manage high volume articles and feature comments that add value to the conversation
* **Boost engagement**: Editors and journalists can directly tap into the contributor stream to easily solicit, invite and feature user-generated content that compliments the narrative
* **Community**: Commenters can lend their their personal knowledge and experiences for trending stories, improving the quality of the coverage while building a sense of investment among readers
* **Publishers**: Once installed and integrated with the Coral Project ecosystem, editors and publishers will gain the power to explore, filter and rank contributor traits, behavioural patterns and associated metadata

 We've created a guide on creating effective, targeted questions that attract and engage contributors. [You can read it here](https://blog.coralproject.net/forms-audience-engagement/). `#ProTip`
 
 ____


## Ask Installation ##

**1. [Deploy AWS EC2 Server](#1-deploy-aws-ec2-server)**

**2. [Set up S3 bucket & IAM User](#2-set-up-s3-bucket-iam-user)**

**3. [Activate DNS for SSL cert](#3-activate-dns-for-ssl-cert)**

**4. [Configure Ask Environment](#4ask-configuration-tool)**

**5. [Run Ask Install](#5-run-ask-install)**

**6. [Upgrading Your Ask Install](#placeholder)**


## Before You Get Started

This installation guide is intended for the primary use case of a cloud installation of Ask on Amazon AWS. Ask can be deployed locally an into most cloud platforms. 

The install consists of standing up a server, configuring secure terminal access via ssh, creating an S3 bucket for file storage, connecting the server to publicly available DNS for SSL cert generation, downloading the latest Ask installer from github, providing answers for the configuration script and then activating the Ask server which downloads, builds and launches a series of Docker containers for the front-end, MongoDB database, web server, authentication, etc.

### Hosting your Ask Install

Ask can be installed on a local machine or a server. Local installs are generally for evaluation or development purposes. Server installs are no different than local installs except they are on a server that is accessible by others. 

Before starting, you will need to:

- Provision a server
- Get access to it via ssh

The web url will generally look like this: `http://localhost:2020`. You may pick any free port you like. If you’re not sure which ports are free, use :2020 as this is rarely taken. Local installs do not support ssl over https.

### Operating System

- Any version of [Linux supported by Docker](https://docs.docker.com/engine/installation/linux/). +1 for [Ubuntu](https://docs.docker.com/engine/installation/linux/ubuntulinux/) (Recommended method and distro)
- Ask can run on any Linux Docker container service. Cloud options include AWS, Azure and similar cloud hosting providers
- MacOS Yosemite 10.10.3 or above 
- _Microsoft Windows is not supported at this time_
- _Windows Server Containers 2016 is untested_


### SSL certificates / HTTPS

Server installs can use ssl to allow secure https connections but dns needs to be installed first. In order to activate SSL, a domain or subdomain must be mapped to the Ask instance so the webserver portion of Ask (we use [Caddy](https://caddyserver.com/)) can request a certificate from [Let's Encrypt](https://letsencrypt.org/).

## 1. Deploy AWS EC2 Server

  1. Select an AWS AMI Image that contains a [supported Operating System](#operating-system):
    - [Ubuntu Server 16.04 LTS - Xenial HVM](https://aws.amazon.com/marketplace/pp/B01JBL2M0O?ref_=gtw_msl_sim_os__B01JBL2M0O_4) (Recommended)
    	- ami-6e165d0e
    	- SSD Volume Type 64-bit
    	- EBS General Purpose (SSD) Volume Type
   

  2. Select Instance Type and then click 'Next':
    - t2.medium (Recommended)
    
  3. Configure Instance Details and then click 'Next'
    - Number of Instances: 
    	- 1 (Recommended)
    - Network, Subnet and Auto-Assign Public IP: 
    	- Ensure the EC2 instance is placed into a VPC network and subnet that match your desired goals for demo/testing/production availability
    - IAM Role:
    	- None
    - Leave these items at defaults (Optional)
      - Shutdown behaviour
      - Enable termination protection
      - Monitoring
      - Monitoring
      
  4. Add storage:
    - Enter '8GB' and then click 'Next'
  
  5. Tag Instance (Optional) 

  6. Configure Security Group
  
	You can use an existing security group or create a new one in AWS's VPC.
	
	- Networking Tips
		- Limit remote access via `ssh/22` to only the necessary IP's of your office connection which can be found using sites like [https://whatismyipaddress.com/](https://whatismyipaddress.com/)

		- If you use a VPN, you can find out what range is covered and enter that in as well
   
   	- We recommend you define access for the following ports:
	
			Type  Protocol  Port  Source    IP
			SSH   TCP     	22    MY IP   	YOUR-IP-ADDRESS/32 (example 64.28.114.31/32)
			HTTPS TCP     	443   ANYWHERE  0.0.0.0/0
			HTTP  TCP     	80    ANYWHERE  0.0.0.0/0

  7. Review your EC2 Instance Settings for the server

  8. Create new key pair or use existing one (You will need this information to ssh into the server) and note the download location
 
  9. Launch your new AWS EC2 instance!
  
  10. To ssh into the server, you need to change the permissions on your private key (NAME-YOU-SELECTED-FOR-THE-KEY.pem file) that you downloaded a few steps ago. It may be in your `Downloads` folder. This file cannot be readable by everyone; if it is, your ssh connection will be refused. Running the unix command 'chmod' against the file will resolve it.

	- You can `cd` to the directory that contains the .pem file
	- Reference it's current location but stay in your current directory
	- Move it to a new location


			$ chmod 400 /path/to/your/private-key.pem


11. Have questions? Check out the Amazon AWS knowledgebase article [Connecting to Your Linux Instance Using SSH](http://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AccessingInstancesLinux.html) 

11. Connect to your newly launched server via SSH using this format:


			$ ssh -i /path/to/your/private-key.pem ubuntu@public-AWS-DNS-NAME


	_Note: Make sure you're using `ubuntu` for the username to connect if that is the AMI you selected and launched. `root` may not work._


3. Once you're able to successfully connect, run the following command on the remote server to download and install the images, packages, certificates and tools related to Docker. These items will be used as the foundation for your Ask instance:


		$ sudo apt-get -y update && sudo apt-get install apt-transport-https ca-certificates && sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list && sudo apt-get -y update && sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual && sudo apt install python-pip && sudo apt-get -y install docker-engine && sudo chown -R $(whoami) /usr/local/bin && curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose 

	
4. Run this command which will query both `docker` and `docker-compose` packages for their location and version:


		$ which docker;docker --version;which docker-compose;docker-compose --version

	
	Make note of the locations and version in a text file in case you need to troubleshoot your installation. You should get results similar to this:


		/usr/local/bin/docker
		Docker version 1.12.1, build 23cf638
		/usr/local/bin/docker-compose
		docker-compose version 1.8.0, build unknown

		
____


## 2. Set up S3 bucket & IAM User


New to working with Amazon's S3 file storage service? Check out this AWS knowledge article [S3 buckets - Getting Started with Amazon Simple Storage Service](http://docs.aws.amazon.com/AmazonS3/latest/gsg/GetStartedWithS3.html) and then continue through the set up guide.

1. From AWS S3 dashboard, [create new bucket](http://docs.aws.amazon.com/AmazonS3/latest/gsg/CreatingABucket.html).
	
	During the Ask Configuration Tool set up you will be asked to provide:
	- The name of your S3 bucket
	- The region the bucket is located in 

			Example
			
			YOUR-BUCKET-NAME.s3.amazonaws.com
			us-east-1


			
2. Next, add a bucket policy by clicking on bucket name and then clicking on 'Properties' in upper right hand corner. 
3. Click on 'Permissions' and select the "Add Bucket Policy" if you have just created the bucket (otherwise the label will say 'Edit Bucket Policy')
4. Copy/Paste the following into the bucket policy box, then select 'Save' and 'Close'.

						{
				"Version": "2008-10-17",
				"Statement": [
					{
						"Sid": "AllowPublicRead",
						"Effect": "Allow",
						"Principal": {
							"AWS": "*"
						},
						"Action": "s3:GetObject",
						"Resource": "arn:aws:s3:::YOUR-BUCKET-NAME/*"
					}
				]
			}


              
              
              
	Note: Please ensure your bucket name falls within the [AWS Bucket DNS Naming Convention](http://docs.aws.amazon.com/AmazonS3/latest/dev/BucketRestrictions.html).

4. Create IAM user with write access to AWS S3 bucket

	- From the AWS IAM dashboard, create a new user, giving the same name as the S3 bucket
	- Make note of the credentials in a secure location and then finish the user set up
	- On the left, click 'Policies', then 'Create policy' and 'Create your own policy' so you can paste in the following and change the bucket name:
	


						{
			    "Version": "2012-10-17",
			    "Statement": [
			        {
			            "Sid": "Stmt1478122637000",
			            "Effect": "Allow",
			            "Action": [
			                "s3:PutObject",
			                "s3:PutObjectAcl",
			                "s3:PutObjectVersionAcl"
			            ],
			            "Resource": [
			                "arn:aws:s3:::YOUR-BUCKET-NAME-HERE"
			            ]
			        }
			    ]
			}


	- Now click into the user and click the tab 'Permissions', then 'Attach Policy' and find the one you just created, attaching it to this user.
	- You will need the user 'Access Key ID' (Not the Secret Key' during the Ask Installation
			
____


## 3. Activate DNS for SSL cert

1. Depending on who your domain registrar is, this process will vary. The end goal is to create an A record for EC2 Instance connecting the server's Public IP and the domain/subdomain you've selected:

		Example 
		A 	ask-stg-docs.coralproject.net   54.193.105.56
			
	Once you've made the changes and verified that the DNS is resolving to the new address ([OpenDNS CacheCheck](https://cachecheck.opendns.com/) is a reliable way to check for DNS propogation).
	
	It's time to test the DNS resolution by reconnecting to the remote server using the new domain/subdomain address. If you're still connected to the remote server, exit it and reconnect via the DNS address you've created:


		Example
		$ ssh -i /path/to/your/secret-key.pem ubuntu@ask-stg-docs.coralproject.net

____

## 4.Ask Configuration Tool

Back on the remote server, change directories to begin running the Ask Configuration Tool


Run this command to create the `coral` directory in the `/opt/` directory and then drop into it:

	$ sudo mkdir /opt/coral/ && cd /opt/coral/


Run this command to download the latest release of Ask (0.0.7), unzip it an change directories into it:


	$sudo curl -LOk https://github.com/coralproject/ask-install/releases/download/v0.0.7/ask-install_0.0.7_linux_amd64.tar.gz && sudo tar zxvf ask-install_0.0.7_linux_amd64.tar.gz && cd ask-install_0.0.7_linux_amd64/
	
From this directory, run the following commands:

- To ensure the files were unpacked properly

		$ sudo ls -la

- To Start the Ask Configuration Tool

		$ sudo ./ask-install 
		
			
Here are the prompts you will recieve during the configuration process:
	
		**Coral Project ASK Installer**
		
		~~ General Configuration ~~
		
		Do you want to use the stable version of ask?: (y)
				
		This is where you can specify the host on which the provided server will bind
		to. If you specify the host with a port, it will specifically bind to that port,
		otherwise, port 80, 443 will be bound to
		
		What's the external hostname of this machine?: (Use DNS name you created. Example ask-stg-docs.coralproject.net)
		
		Do you want SSL enabled?: (y)
		
		External URL will be "https://ask-stg-docs.coralproject.net", is that ok?: (y)
		
		Do you want to enable recaptcha?: (y) WHERE TO FIND THIS?
		Create a captcha id via Google service: [https://www.google.com/recaptcha/admin#list](https://www.google.com/recaptcha/admin#list)
		
		Create label for easy identification
		Enter DNS domain or subdomain you created earlier (Example 
		
		Do you want to enable Google Analytics?: 
		
		What is the Google Analytics ID?: 
		_YOU NEED TO HAVE ALREADY CREATED A Google Analytics ID and PROPERTY CREATED_
		
		~~ Amazon ~~
		
		Do you want forms uploaded to S3?: (y)
		
		What's the S3 Bucket we can upload forms?: (enter your bucket url using the virtual-style url: ask-stg-docs.amazonaws.com)
		                                  
		What's the S3 Region for this bucket?: (example: us-east-1)
		
		You can find your bucket location in the properties of the bucket where you went to add the policy.
		
		NOTE: Most buckets are created in the US Standard region which translates to: us-east-1
		
		What's the AWS_ACCESS_KEY_ID with write access?: 
		
		What's the AWS_ACCESS_KEY associated with this AWS_ACCESS_KEY_ID?:
		
		Is this bucket hosted in AWS?: (y)
		
		Auth EXPLAIN THIS IS FOR THE ASK APPLICATION TO SIGN IN
		
		What's the name for the user account?: WHICH WHAT USER ACCOUNT?
		
		
		~~ Auth ~~
		
		What's the name for the user account?: 
		
		_YOUR-PREFERRED-USERNAME_
		
		What's the email address for the user account?: 
		
		_YOUR-PREFERRED-EMAIL-ADDRESS_
		
		Password
		
		_YOUR-PREFERRED-PASSWORD_


____

## 5. Run Ask installer

1. Start the Ask Install

		$sudo bash setup.sh
		
2. Your outupt should be similar to this:

		Pulling service layers:
		
		Pulling cay (coralproject/cay:release)...
		release: Pulling from coralproject/cay
		3690ec4760f9: Pull complete
		e13b170882f4: Pull complete
		6a5d3c1484a0: Pull complete
		f421a9935a76: Pull complete
		aa99a6213a5e: Pull complete
		37e8dfe8d33c: Pull complete
		320469ff2d48: Pull complete
		Digest: sha256:3b4530c303ceedef51f2d21de9bf8593fd11dae2cdd16a2953a22f214fde3971
		Status: Downloaded newer image for coralproject/cay:release
		Pulling auth-mongo (mongo:3.2)...
		3.2: Pulling from library/mongo
		43c265008fae: Pull complete
		679a27ed88fa: Pull complete
		480a2b7cac89: Pull complete
		ab47cdcec495: Pull complete
		9256de55cd57: Pull complete
		4b9dc6db2834: Pull complete
		9c2b45b7a40c: Pull complete
		24f5d27d1e75: Pull complete
		51170f94141d: Pull complete
		Digest: sha256:89ad0ed6321f48107356db1e11984e56614bdee64c3ad8a05484187f276ff705
		Status: Downloaded newer image for mongo:3.2
		Pulling auth (coralproject/coral-auth:release)...
		release: Pulling from coralproject/coral-auth
		43c265008fae: Already exists
		af36d2c7a148: Pull complete
		143e9d501644: Pull complete
		f6a5aab6cd0c: Pull complete
		1e2b64ecebce: Pull complete
		328ff1526764: Pull complete
		c76215a860ef: Pull complete
		214652c77563: Pull complete
		69cd98d02bcc: Pull complete
		b93a19fe5519: Pull complete
		Digest: sha256:1d4a12cdf42bb705afa82ca8e8f553ca62dd1077bb1db1a5521fd92d29a3fccb
		Status: Downloaded newer image for coralproject/coral-auth:release
		Pulling shelf-mongo (mongo:3.2)...
		3.2: Pulling from library/mongo
		Digest: sha256:89ad0ed6321f48107356db1e11984e56614bdee64c3ad8a05484187f276ff705
		Status: Image is up to date for mongo:3.2
		Pulling askd (coralproject/askd:release)...
		release: Pulling from coralproject/askd
		0c7a0ecaa102: Pull complete
		Digest: sha256:76dac36cd8932ff2126b1f37fe2fd6953e89fef1fb02cfed047efb41481d86dc
		Status: Downloaded newer image for coralproject/askd:release
		Pulling elkhorn (coralproject/elkhorn:release)...
		release: Pulling from coralproject/elkhorn
		43c265008fae: Already exists
		af36d2c7a148: Already exists
		143e9d501644: Already exists
		f6a5aab6cd0c: Already exists
		1e2b64ecebce: Already exists
		328ff1526764: Already exists
		d8ec3ca6e46d: Pull complete
		03a50b1af8ce: Pull complete
		45a08e4a4e5b: Pull complete
		9a3d11a196aa: Pull complete
		a2c06c847a68: Pull complete
		071185f1e460: Pull complete
		d9cbe6f0e6cb: Pull complete
		Digest: sha256:f2bc639dc5a2ad4f53c892836583cd7c1fac7fc612d8c4789332e6bf1b591bfc
		Status: Downloaded newer image for coralproject/elkhorn:release
		Pulling caddy (abiosoft/caddy:latest)...
		latest: Pulling from abiosoft/caddy
		c0cb142e4345: Pull complete
		609cd02c9311: Pull complete
		e9712291594a: Pull complete
		7fb56319a17b: Pull complete
		59112d0d06c2: Pull complete
		Digest: sha256:bdc0b59a6a6b88135f6a61343a66870f565966b0080f4dd492447cf651e10ead
		Status: Downloaded newer image for abiosoft/caddy:latest
		Layers pulled.
		
		Creating the services now:
		
		Creating network "askinstall007linuxamd64_back-auth" with the default driver
		Creating network "askinstall007linuxamd64_bastion" with the default driver
		Creating network "askinstall007linuxamd64_back-shelf" with the default driver
		Creating volume "askinstall007linuxamd64_shelf-mongo" with default driver
		Creating volume "askinstall007linuxamd64_auth-mongo" with default driver
		Creating volume "askinstall007linuxamd64_caddy-certs" with default driver
		Creating askinstall007linuxamd64_cay_1
		Creating askinstall007linuxamd64_auth-mongo_1
		Creating askinstall007linuxamd64_shelf-mongo_1
		Creating askinstall007linuxamd64_askd_1
		Creating askinstall007linuxamd64_auth_1
		Creating askinstall007linuxamd64_elkhorn_1
		Creating askinstall007linuxamd64_caddy_1
		
		Services created.
		
		Now creating user:
		
		Created user 879f8fcb-c7a2-49b2-8fd3-1d7e7d1b3611.
		
		User was created.
		
		Please remove this file as it contains the plaintext password.
		
____
		
## 6. Upgrading Your Ask Install

		$ sudo docker-compose pull
		$ ./ask-install -s Coral Project ASK Installer
		$ sudo bash setup.sh
____

## FAQ & Troubleshooting

**We have encountered errors when installing into symlinked folders**

**SSL Certificates / HTTPS**

Will you be hosting Ask over https? If you’re ok with http or you’re installing a local machine (as opposed to a server that’s accessible by others), you may proceed to the next question.


If you want to use https, you will need to go to your DNS provider and set up the domain to point to your new server before you run the install script. This is required because Ask contains an automated mechanism for acquiring a secure certification (https://github.com/mholt/caddy) and keeping it up to date. The server must be reach it using a publicly accessbile url such as [https://your.domain.com](https://your.domain.com) in order for this to happen.


**Spam Reducting with Captcha**

Do you want reCAPTCHA enabled?


Ask Forms can be protected from bots submitting false entries via reCAPTCHA.  You can learn more about it here: [https://www.google.com/recaptcha/intro/index.html](https://www.google.com/recaptcha/intro/index.html).


If you want to use reCAPTCHA, you need to have signed up for an account and have the keys ready as they will be needed during the Ask install process.


**What is AWS S3 and why would you want to activate it?**


Ask publishes forms and gallery embeds to static files. This improves load times, allows for greater scale and availability. If you don’t expect many thousands of forms requests per day, it is probably best to not use S3. By default Ask will publish files to and serve them from the same server it runs on.


If you want to publish to S3, please create a bucket for Ask and have the following pieces of info at hand during the installation:


- S3 bucket name
- S3 public key
- S3 secret key

For very large or international sites, you may want to consider using a CDN caching services in front of your S3 bucket such as [Amazon CloudFront](https://aws.amazon.com/cloudfront/), [Cloud Flare] (https://www.cloudflare.com/) or similar.


If you’d like to use another platform to host your files, let us know. We can work together to build it as an option into the Coral Platform. Send a mesage to [jeff@mozillafoundation.org](jeff@mozillafoundation.org).

**Software Versions*

### Docker 
Docker 1.12.1 or later is required. 

- Visit the Docker website for [stable releases](https://www.docker.com/products/docker)

Please make sure that the docker install is a stable release as we have encountered problems with experimental Docker releases.

**Cannot connect to the Docker daemon. Is the docker daemon running on this host?**

This error can occur if you need to run the docker command with sudo such as:

		$ sudo docker ps

____


