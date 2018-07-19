// imports
import jenkins.model.*
import jenkins.security.s2m.*
import hudson.security.csrf.DefaultCrumbIssuer


// Sets executors count
Jenkins jenkins = Jenkins.getInstance()
jenkins.setNumExecutors(8)

jenkins.getDescriptor("jenkins.CLI").get().setEnabled(false)


jenkins.injector.getInstance(AdminWhitelistRule.class).setMasterKillSwitch(false);

// Disable jnlp
jenkins.setSlaveAgentPort(-1);

// Disable old Non-Encrypted protocols
HashSet<String> newProtocols = new HashSet<>(jenkins.getAgentProtocols());
newProtocols.removeAll(Arrays.asList(
        "JNLP3-connect", "JNLP2-connect", "JNLP-connect", "CLI-connect"
));
jenkins.setAgentProtocols(newProtocols);


jenkins.save()


if(!Jenkins.instance.isQuietingDown()) {
   
    if(jenkins.getCrumbIssuer() == null) {
        jenkins.setCrumbIssuer(new DefaultCrumbIssuer(true))
        jenkins.save()
         
    }
     
}
 


