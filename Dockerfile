FROM centos:centos7

RUN yum -y install epel-release wget libcurl-devel libxml2-devel openssl-devel
RUN yum -y install R
RUN yum install -y https://download3.rstudio.org/centos7/x86_64/shiny-server-1.5.16.958-x86_64.rpm && \
    yum clean all && \
    rm -rf /tmp/*
RUN R -e "install.packages(c('shiny', 'rmarkdown'), repos='https://cran.rstudio.com/')"
RUN chown shiny:shiny /var/lib/shiny-server
ADD --chown=shiny:shiny ./entrypoint.sh /entrypoint.sh
ADD --chown=shiny:shiny ./app /srv/shiny-server/app

# uncomment to install additional R dependencies
#RUN R -e "install.packages(c('dep1','dep2'), repos='https://cran.rstudio.com/')"

USER shiny

VOLUME /var/log/shiny-server

EXPOSE 3838

ENTRYPOINT ["/entrypoint.sh"]