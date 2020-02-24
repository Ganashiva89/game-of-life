pipeline {
    agent any 
    tools { 
        maven 'maven' 
      
    }
stages { 
     
 stage('checkout') { 
     steps {


        checkout([$class: 'GitSCM', branches: [[name: '*/master']], doGenerateSubmoduleConfigurations: false, extensions: [], submoduleCfg: [], userRemoteConfigs: [[credentialsId: 'git', url: 'https://github.com/shivanani220/game-of-life.git']]])      
  
     }
   }
stage('Build') {
	steps {
         sh label: '', script: 'mvn clean package'
    
	}
   }

 
  stage('Unit Test Results') {
      steps {
      junit '**/target/surefire-reports/TEST-*.xml'
      
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
         nexusArtifactUploader artifacts: [[artifactId: 'gameoflife', classifier: '', file: 'gameoflife-web/target/gameoflife.war', type: 'war']], credentialsId: 'nexus', groupId: 'new', nexusUrl: '3.12.104.45:8081/nexus/', nexusVersion: 'nexus2', protocol: 'http', repository: 'java', version: '$BUILD_NUMBER'
      }
     }	     
    stage('Deploy War') {
      steps {
        sh label: '', script: 'ansible-playbook deploy.yml'
      }
 }
}
post {
       success {
            archiveArtifacts 'gameoflife-web/target/*.war'
        }
       failure {
           mail bcc: '', body: '', cc: '', from: '', replyTo: '', subject: '', to: 'shivavamshi..89@gmail.com'
        }
    }       
}
