
// imports
import jenkins.model.Jenkins

// get Jenkins instance
Jenkins jenkins = Jenkins.getInstance()
jenkins.setNumExecutors(6)
jenkins.save()
