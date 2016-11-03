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

## Ask Installation ##

**1. [Deploy AWS EC2 Server](#1-deploy-aws-ec2-server)**

**2. [Set up S3 bucket](#2-set-up-s3-bucket)**

**3. [Activate DNS for SSL cert](#3-activate-dns-for-ssl-cert)**

**4. [Configure Ask Environment](#4-configure-ask-environment)**

**5. [Run Ask Install](#5-run-ask-install)**


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


### Launch A new Amazon AWS Instance via EC2 Dashboard

  1. Select AMI Image
    - Ubuntu Server 16.04 LTS (HVM), SSD Volume Type 64-bit - ami-6e165d0e
Ubuntu Server 16.04 LTS (HVM),EBS General Purpose (SSD) Volume Type. Support available from Canonical (http://www.ubuntu.com/cloud/services).

  2. Select Instance Type and then click 'Next'
    - t2.medium
    
  3. Configure Instance Details and then click 'Next'
    - **Number of Instances:** 1
    - **Network, Subnet and Auto-Assign Public IP:** Ensure the EC2 instance is placed into a VPC network and subnet that match your desired demo/testing/production goals
    - **IAM Role:** None
    - **Leave these items as defaults (Optional)**
      - Shutdown behaviour
      - Enable termination protection
      - Monitoring
      - Monitoring
      
  4. Add storage:
    - Enter '8GB' and then click 'Next'
  
  5. Tag Instance (Optional) 

  6. Configure Security Group
    - You can use an existing security group or create a new one in AWS's VPC
    - We recoommend you define access for the following ports:
        
    ``` 
    Type  Protocol  Port  Source    IP
    SSH   TCP     	22    MY IP   	YOUR-IP-ADDRESS/32 (example 64.28.114.31/32)
    HTTPS TCP     	443   ANYWHERE  0.0.0.0/0
    HTTP  TCP     	80    ANYWHERE  0.0.0.0/0
    ```
    
    - We recommend you limit remote access via ```ssh/22``` to only the necessary IP's of your office connection which can be found using sites like [https://whatismyipaddress.com/](https://whatismyipaddress.com/)
    - If you use a VPN, you can find out what range is covered and enter that in

  7. Review EC2 Instance Settings
  8. Create new key pair or use existing one
  9. Connect to Server via SSH using this format:
	
```bash
ssh -i your-key.pem ubuntu@public-AWS-DNS-NAME
```
	
2. Chmod 400 on .pem key



3. Run this on the remote server:

```bash
$sudo apt-get -y update && sudo apt-get install apt-transport-https ca-certificates && sudo apt-key adv --keyserver hkp://p80.pool.sks-keyservers.net:80 --recv-keys 58118E89F3A912897C070ADBF76221572C52609D && echo "deb https://apt.dockerproject.org/repo ubuntu-xenial main" | sudo tee /etc/apt/sources.list.d/docker.list && sudo apt-get -y update && sudo apt-get -y install linux-image-extra-$(uname -r) linux-image-extra-virtual && sudo apt install python-pip && sudo apt-get -y install docker-engine && sudo chown -R $(whoami) /usr/local/bin && curl -L "https://github.com/docker/compose/releases/download/1.8.1/docker-compose-$(uname -s)-$(uname -m)" > /usr/local/bin/docker-compose && chmod +x /usr/local/bin/docker-compose 
```
	
4. Run this command:

```bash
$ which docker
$ docker --version
$ which docker-compose
$ docker-compose --version
```	
		


## 2. Set up S3 bucket

## 3. Activate DNS for SSL cert

. Set up A record for EC2 Instance Public IP

			Example ask-stg-docs.coralproject.net   54.193.105.56
			
. Now exit the remote server and reconnect via the DNS address

```bash
			Example
			$ssh -i your-key.pem ubuntu@ask-stg-docs.coralproject.net
```

## 4. Configure Ask environment

Change directories to begin running the Ask Configuration Tool

```bash
	$cd /opt/coral/
```

Run this command

```bash
	$sudo curl -LOk https://github.com/coralproject/ask-install/releases/download/v0.0.7/ask-install_0.0.7_linux_amd64.tar.gz && sudo tar zxvf ask-install_0.0.7_linux_amd64.tar.gz 
```

## 5. Run Ask installer
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


____


