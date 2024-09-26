pipeline {
    agent any

    stages {
        stage('Build') {
            steps {
                git branch: 'main', url: 'https://github.com/shegerbootcamp/microservice-shoping-app.git'
                // Add additional build steps here, e.g., compiling code, running tests, etc.
            }
        }

        stage('Start Docker Containers') {
            steps {
                timeout(time: 60, unit: 'SECONDS') {
                    script {
                        sh 'docker compose up -d'
                        waitUntil {
                            def r = sh script: 'curl -s http://localhost:8010/health | grep "UP"', returnStatus: true
                            return (r == 0)
                        }
                    }
                }
            }
        }

        stage('Run End-to-End Tests') {
            steps {
                script {
                    sh 'cd functional-e2e-tests && mvn clean verify'
                }
            }
        }

        stage('Stop Docker Containers') {
            steps {
                script {
                    sh 'docker compose stop'
                }
            }
        }

        stage('Deploy') {
            steps {
                echo "We will deploy on Kubernetes"
                // Add Kubernetes deployment steps here
            }
        }
    }

    post {
        always {
            // Clean up build artifacts
            cleanWs() // Clean up the workspace after the build
        }
        success {
            slackSend (
                channel: '#jenkins-build-sonar', // Replace with your desired Slack channel
                color: 'good', // Green color for successful builds
                tokenCredentialId: 'SLACK-TOKEN', // Jenkins credential ID for Slack
                message: "Pipeline Success: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${BUILD_URL}"
            )
        }

        failure {
            slackSend (
                channel: '#jenkins-build-sonar', // Replace with your desired Slack channel
                color: 'danger', // Red color for failed builds
                tokenCredentialId: 'SLACK-TOKEN', // Jenkins credential ID for Slack
                message: "Pipeline Failed: ${env.JOB_NAME} #${env.BUILD_NUMBER} - ${BUILD_URL}"
            )
        }
    }
}
