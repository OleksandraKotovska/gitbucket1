pipeline {
    agent {
        label 'agent1'
    }

    stages {
        stage('Checkout') {
            steps {
                script {
                    if (env.CHANGE_ID) {
                        echo "Building Pull Request: ${env.CHANGE_ID}"
                        checkout scm
                    } else {
                        echo "Skipping build because this is not a Pull Request."
                        currentBuild.result = 'SUCCESS'
                        return
                    }
                }
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
