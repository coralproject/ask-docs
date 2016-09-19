FROM therealwardo/python-2.7-pip
MAINTAINER "David Jay <davidgljay@gmail.com>"

RUN apt-get update
RUN pip install mkdocs
RUN apt-get install s3cmd -y
RUN apt-get install git -y
WORKDIR /usr/docs


CMD bash
