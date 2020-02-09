#!/bin/bash
if [ ! -f /nexus-data/expanded ]; then
    /usr/bin/tar -xzvf /nexus-data.tar.gz -C /
    touch /nexus-data/expanded
fi
sh -c ${SONATYPE_DIR}/start-nexus-repository-manager.sh

