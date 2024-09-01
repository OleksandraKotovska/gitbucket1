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
                    // Run sbt package to build the regular WAR file
                    sh 'sbt package'
                    
                    // Run sbt executable to build the executable WAR file
                    sh 'sbt executable'
                    
                    // Verify the generated WAR files
                    sh 'ls -la target/scala-2.13/'
                    sh 'ls -la target/executable/'
                }
            }
        }
    }
}
