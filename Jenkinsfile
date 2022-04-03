
pipeline {
    environment {
      //registry = 'https://hub.docker.com/repository/docker/flannelette/training-project'
      registry = 'flannelette/training-project'
      registrycred = 'dockerhub-flannelette'
      prodcred = 'production_key'
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
        stage('Docker Build') {
            steps {
		script {dockerImage = docker.build registry + ":latest"}
            }
        }
        stage('Push Img to Docker Hub') {
            steps {
		    script {
			    docker.withRegistry('',registrycred){
			    	dockerImage.push()
			    }
		    }
	    }
	}
	stage('Run Docker Container on Jenkins') {
            steps {
                sh "docker run -d -p 8003:8000 flannelette/training-project:latest"
            }
        }
        stage('Run Docker Container on Production') {
            steps {
                sh "ssh -i prodcred ubuntu@ec2-54-92-173-209.compute-1.amazonaws.com"
		sh "docker run -d -p 8003:8000 flannelette/training-project:latest"
            }
        }
    }
}
