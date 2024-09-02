pipeline {
    agent {
        label 'agent'
    }
    environment {
        IMAGE_NAME = 'devops-gitbucket-project'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
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
                    def imageExists = sh(script: "docker images -q ${IMAGE_NAME}", returnStdout: true).trim()
                    if (imageExists) {
                        echo "Docker image ${IMAGE_NAME} exists. Deleting old image..."
                        sh "docker rmi -f ${IMAGE_NAME}"
                    } else {
                        echo "Docker image ${IMAGE_NAME} does not exist. Creating a new one..."
                    }
                    docker.build("${IMAGE_NAME}", ".")
                    sh 'docker image prune -f'
                }
            }
        }
        stage('Push image to dockerhub') {
            steps {
                withDockerRegistry([credentialsId: "dockerhub", url: ""]) {
                    sh "docker push ${IMAGE_NAME}"
                }
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}
