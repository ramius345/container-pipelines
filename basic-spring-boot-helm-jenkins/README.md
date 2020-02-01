# Jenkins Spring Boot Pipeline

## Requirements
An openshift 4.2 cluster
helm installed


## Setting up the pipeline and projects.

This pipeline assumes that you will want to manually create each of the projects associated with it.  You need the following projects:

* jenkins-pipeline
* dev-project
* test-project

## Installing everything with a script
1. 

## Installing Manually

1. Create your dev project using  `oc new-project dev-project`
1. Run `helm install --name-template dev-project dev-project-chart`
1. Create your test project using `oc new-project test-project`
1. Run `helm install --name-template test-project test-project-chart`
1. Create your pipeline project using `oc new-project jenkins-pipeline`
1. Run `helm install --name-template jenkins pipeline-chart`

You now have a functioning pipeline.

## Building your project

1. Go into the jenkins-pipeline project and run oc start-build helloworld.pipeline
1. Run oc get route to find your jenkins
1. 


