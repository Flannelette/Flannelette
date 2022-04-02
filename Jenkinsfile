
pipeline {
    environment {
      registry = 'flannelette/training-project'
      //registry = 'https://hub.docker.com/repository/docker/flannelette/training-project'
      dockerhubcred = 'dockerhub-flannelette'
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
		script {dockerImage = docker.build registry + ":$BUILD_NUMBER"}
		//sh 'docker build -t flannelette/demowebapp:latest .' 
                //sh 'docker tag demowebapp flannelette/demowebapp:latest'
            }
        }
        //stage('Login to Docker Hub') {
        //    steps {
	//	    sh 'echo $dockerhubcred_PSW | docker login -u $dockerhubcred_USR --password-stdin'
	//    }
        //}
        stage('Push Img to Docker Hub') {
            steps {
		    withDockerRegistry([credentialsId: "dockerhubcred", url: "https://hub.docker.com/repository/docker/flannelette/training-project"]){
		    	sh 'docker push registry + ":$BUILD_NUMBER"'
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
