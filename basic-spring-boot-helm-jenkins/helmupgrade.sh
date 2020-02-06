#!/bin/bash
PROJECTNAME=$1
GITREPO=$2
BRANCH=$3
JENKINS_PROJECT=$4
DEV_PROJECT=$5


echo "Project: $PROJECTNAME"
echo "Git Repo: $GITREPO"
echo "Branch: $BRANCH"
echo "Jenkins Pipeline Project: $JENKINS_PROJECT"
echo "Dev Project: $DEV_PROJECT"
echo ""
echo "Your Jenkinsfile (saved to Jenkinsfile, copy to your git project!):"

ORIG_PROJECT=$(oc project | cut -d " " -f 3 | sed 's/"//g')

oc project $JENKINS_PROJECT
helm upgrade \
     --set projectname=$PROJECTNAME \
     --set git.repo=$GITREPO \
     --set git.ref=$BRANCH \
     jenkins pipeline-chart


oc project $DEV_PROJECT
helm upgrade \
     --set projectname=$PROJECTNAME \
     --set jenkins.pipeline_project=$JENKINS_PROJECT \
     --set git.repo=$GITREPO \
     --set git.ref=$BRANCH \
     $PROJECTNAME dev-project-chart

oc project $ORIG_PROJECT

