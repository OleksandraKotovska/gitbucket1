pipeline {
    agent {
        label 'agent1'
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    if (env.CHANGE_ID) {
                        // This is a PR build
                        echo "Building Pull Request: ${env.CHANGE_ID}"
                    } else {
                        // This is a branch build
                        echo "Building Branch: ${env.BRANCH_NAME}"
                    }
                }
                // Standard checkout step
                checkout scm
            }
        }
        stage('Hello') {
            steps {
                echo 'Hello World'
            }
        }
    }
}
