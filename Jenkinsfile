pipeline {
    agent {
        label 'ssh-node'
    }

    stages {
        stage('Clone Repository') {
            steps {
                git url: 'https://github.com/gitbucket/gitbucket.git', branch: 'master'
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