pipeline {
    agent {
        label 'agent'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/OleksandraKotovska/gitbucket1.git', branch: 'master'
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
