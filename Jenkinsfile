pipeline {
    agent {
        label 'agent1'
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
                    sh 'sbt sbtVersion'
                    sh 'sbt package'
                }
            }
        }
        
        stage('Run tests') {
            steps {
                sh 'sbt "testOnly * -- -l ExternalDBTest"'
            }
        }
    }
}
