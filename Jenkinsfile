pipeline {
    agent any 
    tools { 
        maven 'maven' 
      
    }
stages { 
     
 stage('checkout') { 
     steps {

        git credentialsId: 'git', url: 'https://github.com/shivanani220/game-of-life.git'
  
     }
   }

   stage('Build') {
       steps {
         sh label: '', script: 'mvn clean package '
       }
 }
 
   stage('Unit Test Results') {
      steps {
      junit '**/build/test-reports/*.xml'      
     }
 }
	  stage('sonarqube') {
         environment {
           scannerHome = tool 'sonarqube'
       }
         steps {
            withSonarQubeEnv('sonarqube') {
            sh "${scannerHome}/bin/sonar-scanner"
           }
          timeout(time: 10, unit: 'MINUTES') {
           waitForQualityGate abortPipeline: true
           }
	     }
      }    
     stage('Artifact upload') {
      steps {
        nexusArtifactUploader credentialsId: 'nexus', groupId: 'CI_CD', nexusUrl: 'http://3.133.98.64:8081/nexus', nexusVersion: 'nexus2', protocol: 'http', repository: 'java', version: '$BUILD_ID'
        }
     }
    stage('Deploy War') {
      steps {
        sh label: '', script: 'ansible-playbook deploy.yml'
      }
    }

   post {

        failure {
         mail bcc: '', body: '', cc: '', from: '', replyTo: '', subject: '', to: 'shivavamshi.89@gmail.com'      
	}
   }       
  }
}
