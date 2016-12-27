node {
   stage('Preparation') { 
      // Get some code from a GitHub repository
      git 'https://github.com/mcgonagle/ansible_f5.git'
      
      def userInput = input(
      id: 'userInput', message: 'username?', parameters: [
      [$class: 'TextParameterDefinition', defaultValue: 'admin', description: 'username', name: 'username'],
      [$class: 'TextParameterDefinition', defaultValue: 'password', description: 'password', name: 'password']
      ])
     
   }
   stage('Testing') {
       echo 'ansible-lint'
       sh "/usr/local/bin/ansible-lint site.yml"
       echo 'ansible-review'
       sh "/usr/local/bin/ansible-review site.yml"
   }
   stage('Ansible Run') {
   ansiblePlaybook(
       colorized: true, 
       inventory: 'hosts.ini', 
       playbook: 'site.yml', 
       sudoUser: null,
       extraVars: [
            username: 'dev',
            password: [value: 'devdev', hidden: true]
       ])
   }
}
