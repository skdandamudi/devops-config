
// imports
import jenkins.model.Jenkins

// Sets executors count
Jenkins jenkins = Jenkins.getInstance()
jenkins.setNumExecutors(6)
instance.setSlaveAgentPort([50000])
jenkins.save()

//Set the administrator email address
def jenkinsLocationConfiguration = JenkinsLocationConfiguration.get()
jenkinsLocationConfiguration.setAdminAddress("sudheer.dandamudi@navitas-tech.com")
jenkinsLocationConfiguration.save()

//set Git global config
def gitConfig = inst.getDescriptor("hudson.plugins.git.GitSCM")
gitConfig.setGlobalConfigName("sscdbot")
gitConfig.setGlobalConfigEmail("steadystatecd@gmail.com")
gitConfig.save()
