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
cat Jenkinsfile.template | \
    sed "s/<PROJECT_NAME>/${PROJECTNAME}/" | \
    sed "s/<JENKINS_PROJECT>/${JENKINS_PROJECT}/" | \
    sed "s/<DEV_PROJECT>/${DEV_PROJECT}/" | \
    tee Jenkinsfile 
    

oc new-project $JENKINS_PROJECT
helm install \
     --name-template jenkins  \
     --set projectname=$PROJECTNAME \
     --set git.repo=$GITREPO \
     --set git.ref=$BRANCH \
     pipeline-chart


oc new-project nexus
helm install --name-template nexus nexus

oc new-project $DEV_PROJECT
helm install \
     --name-template $PROJECTNAME \
     --set projectname=$PROJECTNAME \
     --set jenkins.pipeline_project=$JENKINS_PROJECT \
     --set git.repo=$GITREPO \
     --set git.ref=$BRANCH \
     dev-project-chart


