pipeline {
    agent any

    environment {
        IMAGE_NAME = 'sittyan/finead-todo-app:latest'
    }

    stages {

        stage('Build') {
            steps {
                sh '''
                cd TODO/todo_backend
                npm install

                cd ../todo_frontend
                npm install
                npm run build
                '''
            }
        }

        stage('Containerise') {
            steps {
                sh '''
                docker build -t $IMAGE_NAME .
                '''
            }
        }

        stage('Push') {
            steps {
                withCredentials([usernamePassword(
                    credentialsId: 'dockerhub-creds',
                    usernameVariable: 'DOCKER_USER',
                    passwordVariable: 'DOCKER_PASS'
                )]) {
                    sh '''
                    echo $DOCKER_PASS | docker login -u $DOCKER_USER --password-stdin
                    docker push $IMAGE_NAME
                    docker logout
                    '''
                }
            }
        }

        stage('Verify') {
            steps {
                sh '''
                docker images | grep finead-todo-app
                '''
            }
        }
    }
}
