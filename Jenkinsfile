pipeline {

    agent any

    environment {
        SERVER_IP = "43.205.92.192"
        SSH_CRED_ID = "pull-key"
        APP_PATH = "/home/ubuntu/Jarvis-Desktop-Voice-Assistant"
    }

    stages {

        stage('Checkout Code from GitHub via SSH') {
            steps {
                git branch: 'main', 
                url: 'git@github.com:AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git', 
                credentialsId: 'pull-key'
            }
        }

        stage('Pull latest changes to EC2') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                        cd ${APP_PATH} &&
                        git pull origin main
                    '
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                        cd ${APP_PATH} &&
                        pip install -r requirements.txt
                    '
                    """
                }
            }
        }

        stage('Restart Jarvis Service') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                        sudo systemctl restart jarvis.service
                    '
                    """
                }
            }
        }

        stage('Verify Application Running') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ubuntu@${SERVER_IP} '
                        systemctl status jarvis.service
                    '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🎉 SUCCESS: Jarvis Deployed Successfully via Jenkins!"
        }
        failure {
            echo "❌ Deployment failed! Check logs."
        }
    }
}
