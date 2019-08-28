FROM ubuntu:latest

#Copy in install scripts
ADD ./scripts /tmp/scripts

#Execute install scripts
RUN /bin/bash -c /tmp/scripts/tika-install.sh
#RUN /bin/bash -c /tmp/scripts/tika-iptables.sh


