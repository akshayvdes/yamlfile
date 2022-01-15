pipeline {
	agent none
environment {
		DOCKERHUB_CREDENTIALS=credentials('docker_slave_slave-2')
	}
    stages {
	
       stage('checkout') {
    agent  { label 'tom' }
            steps {
                sh 'sudo rm -rf welcome-to-devops-war'
	sh 'git clone https://github.com/akshayvdes/welcome-to-devops-war.git'	
              }
        }
	 stage('build') {
 agent  { label 'tom' }
	steps {
 
                dir('welcome-to-devops-war'){
                  sh 'pwd'
                sh 'ls'
            
                sh 'docker build -t tomcat:$BUILD_NUMBER .'  
                }
            }
	 }
	 stage('deploy'){
 agent  { label 'tom' }
	     steps{
	        sh 'docker rm -f mytomcat'
	         sh 'docker run -d --name mytomcat -p 8888:8080 tomcat:$BUILD_NUMBER'
	     }
	 }
		stage('Login') {
agent  { label 'tom' }
			steps {
				sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 036127958665.dkr.ecr.us-east-2.amazonaws.com'
			}
		}
	stage('Push') {
 agent  { label 'tom' }

			steps {
			    sh 'docker tag tomcat:$BUILD_NUMBER 036127958665.dkr.ecr.us-east-2.amazonaws.com/tomcatnew:$BUILD_NUMBER'
				sh 'docker push 036127958665.dkr.ecr.us-east-2.amazonaws.com/tomcatnew:$BUILD_NUMBER'
			}
		}

    stage('pull image'){
    agent { label 'deplo' }
        steps{
		sh 'aws ecr get-login-password --region us-east-2 | docker login --username AWS --password-stdin 036127958665.dkr.ecr.us-east-2.amazonaws.com'
            sh 'docker rm -f mytomcat'
            sh 'docker run -d --name mytomcat -p 7100:8080 036127958665.dkr.ecr.us-east-2.amazonaws.com/tomcatnew:$BUILD_NUMBER'
        }
    }
    }
}
