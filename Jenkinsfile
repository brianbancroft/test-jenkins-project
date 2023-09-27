pipeline {
    agent {
        docker {
            image 'node:lts-buster-slim'
        }
    }
    environment {
        CI = 'true'
    }
    stages {
        stage('Build') {
            steps {
                sh 'npm install'
            }
        }
        stage('Test') {
            steps {
                sh 'npm run lint && npm run ci'
            }
        }
    }
}