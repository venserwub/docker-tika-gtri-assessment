# Install, and Run

Download git repository:

`git clone https://github.com/venserwub/docker-tika-gtri-assessment.git`

Building the tika image:

`docker build . -t tikaserver`


Standing up an instance:


`docker run --rm -d -p 9998:9998 tikaserver`

Using the upload script:

`./scripts/tika-upload.sh *path_to_file* *server_ip:port*`

# Configuration
## iptables rules

Currently the Dockerfile file has the line to call tika-iptables.sh commented out, to enable delete the '#' on the line:

`#RUN /bin/bash -c /tmp/scripts/tika-iptables.sh`

# Assignment Thoughts and Difficulties
## 1. & 2. downloading and installing tika

This is my first time using tika and maven, so I'm excited to see the workflow and usage of both.

First difficulty was found in trying to manually install java, I spent some time trying to get a java repo installed and kept running into gpg key errors on install, before finally realizing I could use the default java package. Below is associated code for manual install that was failing.

```
export CODENAME="$(cat /etc/lsb-release | sed -n '/CODENAME/p' | awk -F '=' '{print $2}')"
echo "deb http://ppa.launchpad.net/webupd8team/java/ubuntu $CODENAME main" >> /etc/apt/sources.list
echo "deb-src http://ppa.launchpad.net/webupd8team/java/ubuntu $CODENAME main" >> /etc/apt/sources.list
apt-key adv --keyserver keyserver.ubuntu.com --recv-keys C2518248EEA14886
gpg --keyserver hkp://keyserver.ubuntu.com --recv C2518248EEA14886
gpg --export --armor C2518248EEA14886 | apt-key add -
```


Trying to install tika via maven seems to error with a message about a test failing.
Adding -DskipTests seems to get the build farther along, but doesn't seem to skip tests at all.

testing solution in original post at https://stackoverflow.com/questions/13170860/failed-to-execute-goal-org-apache-maven-pluginsmaven-surefire-plugin2-10test

Adding the repo from the above link to the pom.xml hasn't caused the build to succeed.

I've hit a wall in trying to install tika. The maven install always fails after ten minutes. The link included in the error message leads to a forum post with conflicting problems/solutions, and none of them worked for me. 

I've scripted as much as I've gotten working, and will complete the Dockerfile as much as I can without a fully functional script.

## 3. upload script to tika server

I'm confused by the requirements here and how they apply to Tika, all the tutorials I'm finding are treating tika like a command line tool, or a java library, so I'm not sure what uploading files to a tika server is supposed to look like. Will have to see once I get tika working if I can get more clues then.

I couldn't get maven to install tika on my own scripts, so I'm going to test this task with a premade docker image

Getting a working install of tika helped me understand it a lot more. The server version has an api where you can post files and depending on the header and what address you relates to running a similar command as running tika in the command line.

I got the tika-upload.sh script working, and it successfully returns the plain text of a provided file.

## 4. iptables setup

I'm not too sure on the implementation details for this script.
Specifically, whether or not this should be added to the docker build or just kept as an additional script. 

For now I'm going to leave the line to add it to the build commented out.

running iptables inside of a container seems to require the --privileged flag on docker run

I got the tika-iptables.sh script working, the only roadbump being that iptables seems to require --priviliged access when inside of a docker container.

### iptables-save output

```
root@91f4d312cf44:/# iptables-save
\# Generated by iptables-save v1.6.1 on Wed Aug 28 17:48:28 2019
\*filter
:INPUT ACCEPT [0:0]
:FORWARD ACCEPT [0:0]
:OUTPUT ACCEPT [0:0]
-A INPUT -s 192.168.0.0/16 -m time --timestart 07:00:00 --timestop 19:00:00 --datestop 2038-01-19T03:14:07 -j ACCEPT                                                                                              
COMMIT

\# Completed on Wed Aug 28 17:48:28 2019
```
