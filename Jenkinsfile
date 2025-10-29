pipeline {
    agent any

    environment {
        APP_NAME = "angular-jenkins"
        DEPLOY_PATH = "/opt/lampp/htdocs/"
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'master', url: 'https://github.com/alsaeedfayed/jenkins-docker-angular'
            }
        }

        stage('Build Docker Image') {
            steps {
                sh 'docker build -t ${APP_NAME} .'
            }
        }

        stage('Run Container (simulate deployment)') {
            steps {
                // Stop previous container if it exists
                sh '''
                docker rm -f ${APP_NAME} || true
                docker run -d --name ${APP_NAME} -p 8086:80 ${APP_NAME}
                '''
            }
        }

        stage('Deploy to XAMPP (local Apache)') {
            steps {
                sh '''
                echo "Copying built files to XAMPP htdocs..."
                docker cp ${APP_NAME}:/usr/local/apache2/htdocs/. ${DEPLOY_PATH}
                '''
            }
        }
    }

    post {
        success {
            echo '✅ Build & Deploy Successful!'
        }
        failure {
            echo '❌ Build Failed!'
        }
    }
}
