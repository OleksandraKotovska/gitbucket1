pipeline {
    agent {
        label 'agent'
    }
    environment {
        IMAGE_NAME = 'devops-gitbucket-project:latest'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_HUB_USER = "${DOCKER_HUB_CREDENTIALS_USR}"
        DOCKER_HUB_PASS = "${DOCKER_HUB_CREDENTIALS_PSW}"
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
        stage('Login to dockerhub') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'dockerhub', usernameVariable: 'DOCKER_HUB_USER', passwordVariable: 'DOCKER_HUB_PASS')]) {
                    sh 'echo $DOCKER_HUB_PASS | docker login -u $DOCKER_HUB_USER --password-stdin'
            }
        }
        stage('Push image to dockerhub') {
            steps {
                sh "docker push ${IMAGE_NAME}"
            }
        }
    }
    post {
        always {
            sh 'docker logout'
        }
    }
}