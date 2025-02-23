FROM ubuntu:18.04

# https://stackoverflow.com/questions/8671308/non-interactive-method-for-dpkg-reconfigure-tzdata
ENV DEBIAN_FRONTEND=noninteractive DEBCONF_NONINTERACTIVE_SEEN=true
COPY preseed.txt /etc/preseed.txt
RUN debconf-set-selections /etc/preseed.txt

# http://sites.psu.edu/theubunturblog/installing-r-in-ubuntu/
# https://stackoverflow.com/questions/45719942/how-to-install-tidyverse-on-ubuntu-16-04-and-17-04
RUN apt-get update -y \
 && apt-get install -y libssl-dev libxml2-dev libcurl4-openssl-dev r-base r-base-dev

# Required packages for run_planscore_model.R
RUN R -e 'install.packages("plyr")' \
 && R -e 'install.packages("tidyverse")' \
 && R -e 'install.packages("stringr")' \
 && R -e 'install.packages("arm")' \
 && R -e 'install.packages("msm")'

COPY run_planscore_model.R /usr/local/lib/R/run_planscore_model.R
COPY run-planscore-model.sh /usr/local/bin/run-planscore-model.sh
