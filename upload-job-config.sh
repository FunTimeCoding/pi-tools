#!/bin/sh -e

~/src/jenkins-tools/bin/delete-job.sh pi-tools || true
~/src/jenkins-tools/bin/put-job.sh pi-tools job.xml
