
pipeline {
    environment {
      registry = 'https://hub.docker.com/repository/docker/flannelette/training-project'
      credentialsId = 'dockerhub-flannelette'
      dockerImage = ''
    }

    agent any
 
    tools {
        maven "maven363"
    }

    stages {
        stage('checkout') {
            steps {
                git branch: 'main', url: 'https://github.com/Flannelette/Flannelette.git'
            }
        }
        stage('Execute Maven') {
            steps {
                sh 'mvn package'             
            }
        }
        stage('Docker Build and Tag') {
            steps {
                sh 'docker build -t demowebapp:latest .' 
                sh 'docker tag demowebapp flannelette/demowebapp:latest'
            }
        }
        stage('Push img to Docker Hub') {
            steps {
                script{ 
			docker.withRegistry(demowebapp:latest, credentialsID){dockerImage.push()}
		}
	    }
        }
        stage('Run Docker Container on Jenkins') {
            steps {
                sh "docker run -d -p 8003:8000 flannelette/demowebapp"
            }
        }
        stage('Run Docker Container on Production') {
            steps {
                sh "docker -H ssh://ubuntu@ec2-52-87-243-9.compute-1.amazonaws.com 8003:8000 flannelette/demowebapp"
            }
        }
    }
}
