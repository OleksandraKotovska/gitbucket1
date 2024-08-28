pipeline {
    agent {
        label 'agent'
    }
    stages {
        stage('Checkout') {
            steps {
                script {
                    if (env.CHANGE_ID) {
                        // This is a PR build
                        echo "Building Pull Request: ${env.CHANGE_ID}"
                        // Checkout the PR branch
                        checkout scm
                    } else {
                        // This is a branch build
                        echo "Building Branch: ${env.BRANCH_NAME}"
                        git url: 'https://github.com/OleksandraKotovska/gitbucket1.git', branch: 'master'
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
