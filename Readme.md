#About
Some simple scripts that show how to set up and use Red Hat JBoss A-MQ with Red Hat Openshift Container Platform.

Important notes: 
- For Red Hat PS MW SAs, this has been validated against _rhsademo_ and this is the recommended platform.
- Assumes password authentication
- In general these scripts attempt to do simple validation checks and attempt to prevent uncessary processes. It _should_ be generally safe to rerun any of these at any time without causing any harm.
- When in doubt, run the **clean.sh** script

#Prerequisites

You'll need a couple of things for this demo to work. Most of these are standard kit for Red Hat PS MW SAs.
- an existing installation of Openshift Container Platform
- the requisite JBoss xPaaS images installed on this instance
- an account with default privileges on this instance
- sufficient resource quotes (recommend 10 services, 10 pods, 6 CPUs, 6 GB Ram, 6 GB storage)
- a local workstation with a (tiny) amount of storage; Fedora 24+ recommended
- command line tools: bash 4.2+ ; openshift [cli tools](https://access.redhat.com/downloads/content/290) (user account at access.redhat.com required)
- eclipse with openshift, git, maven, and a handful of other plugins; [JBoss Developer Studio 10.0+](http://developers.redhat.com/products/devstudio/download/) (user account at access.redhat.com required) recommended as it already has the necessary plugins
- a web browser; Firefox 48+ recommended

#Workflow

The recommend workflow is
- clone this repository
- set your password via an environment variable; if present OPENSHIFT_RHSADEMO_USER_PASSWORD_DEFAULT will be used, otherwise it expects OPENSHIFT_PRIMARY_USER_PASSWORD_DEFAULT
- verify any settings in **config.sh** are correct; primarily this will be to point to the correct Openshift instance and **setting your username**
- run **setup.sh** on your local workstation
- check out the resources that are created on the Openshift instance you are using (via the console, cli, or eclipse plugin)
- create an eclipse maven project using the camel-archetype-activemq archetype
- make the necessary modification's indicated by the setup script to the default camel-context.xml provided at *<the project location on disk>/src/main/resources/META-INF/spring/camel-context.xml*
- run the camel route
  either in eclipse
    1. select the project
    2. go to the menu "Run >> Run Configurations..."
    3. alt-select "Maven Build"
    4. select new
    5. enter for the base directory the workspace location of the project, and "camel:run" for the goal
    6. apply changes and you may now use the combo-box run icon on the default icon-bar
  or command line (from the location of the pom.xml file in your project), **mvn camel:run**
- observe the messages being pushed from your local workstation ( *<the project location on disk>/src/data/message&ast;.xml* ), to the openshift hosted A-MQ broker, to the target location ( either *<the project location on disk>/target/messages/other* or *<the project location on disk>/target/messages/uk* )
- observe the A-MQ destination being created on the broker's console (go the openshift console, find the broker's pod, select open java console) and messages enqueued/dequeued
- run **scale.sh** on your local workstation
- observe the activemq broker connections in your running camel route fail and reconnect to other scaled instances of your A-MQ brokers
- rerun the camel route and watch the messages flow again
- run **clean.sh** to remove any script and openshift artifacts; the eclipse project/artifacts are left in place in case you want to keep them
