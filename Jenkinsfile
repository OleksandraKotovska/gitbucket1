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
        stage('Build') {
            steps {
                script {
                    // Check if the image exists
                    def imageExists = sh(script: "docker images -q ${IMAGE_NAME}", returnStdout: true).trim()

                    // If image exists, delete it
                    if (imageExists) {
                        echo "Docker image ${IMAGE_NAME} exists. Deleting old image..."
                        sh "docker rmi -f ${IMAGE_NAME}"
                    } else {
                        echo "Docker image ${IMAGE_NAME} does not exist. Creating a new one..."
                    }

                    // Build the new Docker image
                    docker.build("${IMAGE_NAME}", ".")

                    // Optional: Clean up dangling images
                    sh 'docker image prune -f'
                }
            }
        }
        
    }
}
