FROM therealwardo/python-2.7-pip
MAINTAINER "David Jay <davidgljay@gmail.com>"

RUN apt-get update
RUN pip install mkdocs
RUN pip install mkdocs-cinder 
RUN apt-get install wget
RUN wget -O- -q http://s3tools.org/repo/deb-all/stable/s3tools.key | apt-key add -
RUN wget -O/etc/apt/sources.list.d/s3tools.list http://s3tools.org/repo/deb-all/stable/s3tools.list
RUN apt-get update && apt-get install s3cmd -y
RUN apt-get install git -y
WORKDIR /usr/docs


CMD bash
