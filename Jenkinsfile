pipeline {
    agent any

    environment {
        EC2_USER = 'ubuntu'
        EC2_HOST = '13.126.10.149'
        SSH_CRED_ID = 'terraform-ssh-creds'  // Jenkins SSH Credential ID
        APP_DIR = '/home/ubuntu/Jarvis-Desktop-Voice-Assistant'
    }

    stages {
        stage('Checkout') {
            steps {
                git branch: 'main', url: 'git@github.com:AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git', credentialsId: 'pull-key'
            }
}

        }

        stage('Pull latest changes to EC2') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${EC2_USER}@${EC2_HOST} \
                    'cd ${APP_DIR} && git pull origin main'
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh ${EC2_USER}@${EC2_HOST} \
                    'cd ${APP_DIR} && pip3 install -r requirements.txt --user'
                    """
                }
            }
        }

        stage('Restart Jarvis Service') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh ${EC2_USER}@${EC2_HOST} \
                    'sudo systemctl restart jarvis'
                    """
                }
            }
        }

        stage('Verify Application Running') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                    ssh ${EC2_USER}@${EC2_HOST} \
                    'sudo systemctl status jarvis | tail -n 10'
                    """
                }
            }
        }
    }

    post {
        success {
            echo "🚀 Jarvis successfully deployed on EC2!"
        }
        failure {
            echo "❌ Deployment failed! Check logs."
        }
    }
}
