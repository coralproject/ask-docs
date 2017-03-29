# Talk

_Updated: 3/30/2017_

  Latest Release: Talk v1.3.0

- [View the latest release](https://github.com/coralproject/talk/releases) 

- If you have questions about installing Talk, please email [jeff@mozillafoundation.org](jeff@mozillafoundation.org)

## What is Talk?

Talk is a better commenting platform built with the following goals in mind:

* **Make Comments Better**: We want to create a safe space where readers can offer insights and engage in conversation about the journalism because readers want to feel heard by each other and by the news organizations, and journalists can improve their work.

* **Increase Positive Contributions**: We want to decrease the volume and visibility of negative contributions, and increase that of positive/useful contributions, because newsrooms are spending most of their energy on only the negative contributions.

* **Help More People Comment**: We want to create the best possible spaces for POC and other individuals who don’t usually comment, because both readers and journalists will benefit if comment sections represent more of the diversity of thought and experience of the audience.

## Quick Links

**1. [Quick Start with Heroku](#1-quick-start-with-heroku)**

**2. [Advanced Install](#2-advanced-install)**

**3. [Upgrading](#3-upgrading)**


## Quick Start with Heroku

### Before Getting Started

You need a FB developer account and app ID (https://developers.facebook.com/docs/apps/register)

### Install Steps

Click on "Login with Heroku" (if you don't have a Heroku account you will be prompted to create one)

Questions:

- Heroku app custom name (your-app-name.herokuapp.com)
- Facebook connection
- Set up admin account (email/password)
- Comment configuration options: #TODO
- Embed code to set up Talk on your blog

### What You Get

As part of this install, you will have:
- A Heroku app running the Talk Node.js app
- Generated Heroku app URL (you can customize the URL in the Heroku interface)
- Redis add-on (free)
- Mongodb add-on (free)
- SSL (free for the Heroku domain)
- Sendgrid for SMTP add-on (up to 12K emails/month for free)

### Notes

- You will have to setup your own SSL if you'd like to use a custom domain or subdomain with Heroku (www.your-custom-domain.com)
- You will also have to update `ROOT_URL` and your Facebook app id to work with the new SSL

## Advanced Install

### Before You Get Started

You can deploy Talk on any cloud hosting platform, or on your own VM in your existing infrastructure.

### Requirements

- Node 7.2.1
- Mongo 3.4.0
- Redis 3.2.6
- Docker 1.12.1


### Operating System

- We recommend hosting Talk with any flavor of Linux that is supported by Docker
- 1GB memory (minimum)
- 5GB storage (minimum)


### SSL certificates / HTTPS

Server installs can use SSL to allow secure HTTPS connections but DNS needs to be installed first. In order to activate SSL, a domain or subdomain must be mapped to the Talk instance so the webserver portion of Talk (we use [Caddy](https://caddyserver.com/)) can request a certificate from [Let's Encrypt](https://letsencrypt.org/).

You can also set up your own SSL certificate if you prefer.

### Installing with Docker [#TODO]
- Clone the repo: https://github.com/coralproject/talk
- Set your environment variables in `deploy.sh` (required unless otherwise noted):
  
    "TALK_PORT=5000"
    "TALK_MONGO_URL=mongodb://mongo"
    "TALK_REDIS_URL=redis://redis"
    "TALK_SESSION_SECRET=xxxxxxxxxxxxxxxxx"
    "TALK_FACEBOOK_APP_ID=xxxxxxxxxxxxxxxxx"
    "TALK_FACEBOOK_APP_SECRET=xxxxxxxxxxxxxxxxx"
    "TALK_ROOT_URL=https://talk-stg.coralproject.net"
    "TALK_SMTP_USERNAME=username"
    "TALK_SMTP_PASSWORD=xxxxxxxxxxxxxxxxx"
    "TALK_SMTP_HOST=smtp.host.net"
    "TALK_SMTP_PROVIDER="Provider"
- Run `docker-compose up -d`

### Troubleshooting
One common issue is needing to clean out old Docker images, which you can do with this command (it will not remove any images that are currently running):

  $ docker rmi $(docker images -q)

## Upgrading Your Talk Install

All you have to do to update Talk is run this command on the server:

  $ sudo bash deploy.sh latest
