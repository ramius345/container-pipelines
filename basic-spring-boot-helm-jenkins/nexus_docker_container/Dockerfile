FROM sonatype/nexus3
COPY nexus-data.tar.gz /nexus-data.tar.gz
COPY startup.sh /startup.sh
CMD ["/bin/bash", "-c", "/startup.sh"]