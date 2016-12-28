node {
   stage('Preparation') { 
      // Get some code from a GitHub repository
      git 'https://github.com/mcgonagle/ansible_f5.git'
   }
   stage('Testing') {
       echo 'ansible-lint'
       sh "/usr/local/bin/ansible-lint site.yml"
       echo 'ansible-review'
       sh "/usr/local/bin/ansible-review site.yml"
   }
   stage('Proceed') {
      def userInput = input(
         id: 'userInput', message: 'Proceed?', parameters: [
         [$class: 'TextParameterDefinition', defaultValue: 'yes', description: 'proceed', name: 'proceed']
      ])  
      //if (+userInput == "no" || +userInput == 'No') {
      //     error 'Do not proceed.'
      //} 
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
