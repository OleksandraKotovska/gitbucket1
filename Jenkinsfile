pipeline {
    agent {
        label 'agent'
    }
    environment {
        IMAGE_NAME = 'devops-gitbucket-project'
        DOCKER_HUB_CREDENTIALS = credentials('dockerhub')
        DOCKER_HUB_USER = "${DOCKER_HUB_CREDENTIALS_USR}"
        DOCKER_HUB_PASS = "${DOCKER_HUB_CREDENTIALS_PSW}"
    }
    stages {
        stage('Pull the repo') {
            steps {
                checkout scm
            }
        }
        
        stage('Build war file') {
            steps {
                script {
                    sh 'sbt package'
                    sh 'sbt executable'
                }
            }
        }
        stage('Run tests') {
            steps {
                sh 'sbt "testOnly * -- -l ExternalDBTest"'
            }
        }
        stage('Build Docker Image') {
            steps {
                script {
                    def fullImageName = "${DOCKER_HUB_USER}/${IMAGE_NAME}"
                    
                    def imageExists = sh(script: "docker images -q ${fullImageName}", returnStdout: true).trim()
                    if (imageExists) {
                        echo "Docker image ${fullImageName} exists. Deleting old image..."
                        sh "docker rmi -f ${fullImageName}"
                    } else {
                        echo "Docker image ${fullImageName} does not exist. Creating a new one..."
                    }
                    docker.build(fullImageName, ".")
                    sh 'docker image prune -f'
                }
            }
        }
        stage('Login to Docker Hub') {
            steps {
                sh 'echo $DOCKER_HUB_PASS | docker login -u $DOCKER_HUB_USER --password-stdin'
            }
        }
        stage('Push image to Docker Hub') {
            steps {
                script {
                    def fullImageName = "${DOCKER_HUB_USER}/${IMAGE_NAME}"
                    sh "docker push ${fullImageName}"
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
