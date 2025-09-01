import jenkins.model.*
import hudson.slaves.*
import hudson.model.Node

// === CONFIGURE THESE ===
def nodeName = "my-node"
def nodeDescription = "This is a new Jenkins node"
def remoteFS = "/home/jenkins"
def numExecutors = 2
def labelString = "linux docker"
def launchCommand = "java -jar /home/jenkins/slave.jar"
def sshHost = "192.168.1.100"
def sshPort = 22
def sshCredentialsId = "ssh-credentials-id"  // Must already be configured in Jenkins

// === CREATE LAUNCHER ===
def launcher = new hudson.plugins.sshslaves.SSHLauncher(
        sshHost,
        sshPort,
        sshCredentialsId,
        null, // JVM Options
        null, // JavaPath
        launchCommand,
        null, // PrefixStartSlaveCmd
        null, // SuffixStartSlaveCmd
        60,   // Connection Timeout (seconds)
        5,    // Maximum retries
        15    // Retry wait time
)

// === CREATE NODE ===
DumbSlave node = new DumbSlave(
        nodeName,
        nodeDescription,
        remoteFS,
        numExecutors.toString(),
        Node.Mode.NORMAL,
        labelString,
        launcher,
        new RetentionStrategy.Always(),
        new LinkedList<>()
)

// === ADD NODE TO JENKINS ===
Jenkins.instance.addNode(node)

println "Node '${nodeName}' created successfully."
