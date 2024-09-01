pipeline {
    agent {
        label 'agent'
    }
    environment {
        IMAGE_NAME = 'devops-gitbucket-project'
    }
    stages {
        stage('Checkout') {
            steps {
                checkout scm
            }
        }
        
        stage('Build') {
            steps {
                script {
                    sh 'sbt package'
                    
                    sh 'sbt executable'
                    
                }
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    dir('/home/jenkins/workspace/gitbucket-pipeline_develop') {
                        sh 'ls -la'
                        docker.build("${IMAGE_NAME}:${env.BUILD_ID}", ".")
                    }
                }
            }
        }
        
    }
}
