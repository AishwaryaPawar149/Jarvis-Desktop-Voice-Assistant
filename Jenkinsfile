pipeline {
    agent any

    environment {
        SERVER_USER = "ubuntu"
        SERVER_IP   = "13.201.37.19"
        APP_PATH   = "/home/ubuntu/Jarvis-Desktop-Voice-Assistant"
        SSH_CRED   = "terraform"
    }

    stages {

        stage('Checkout Code') {
            steps {
                echo "📥 Cloning Jarvis repository..."
                git branch: 'main', url: 'https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git', credentialsId: "${SSH_CRED}"
            }
        }

        stage('Test SSH Connection') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'echo "✅ SSH Connection Successful!" && uptime'
                    """
                }
            }
        }

        stage('Clean Previous Deployment') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'rm -rf ${APP_PATH}/* && echo "✅ Previous Deployment Cleared"'
                    """
                }
            }
        }

        stage('Upload Application') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    scp -o StrictHostKeyChecking=no -r * ${SERVER_USER}@${SERVER_IP}:${APP_PATH}/
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                        # Update packages
                        sudo apt update -y

                        # Install Python3 and pip if not installed
                        sudo apt install -y python3 python3-pip

                        # Upgrade pip
                        python3 -m pip install --upgrade pip

                        # Install project dependencies
                        cd ${APP_PATH} && python3 -m pip install -r requirements.txt
                    '
                    """
                }
            }
        }

        stage('Restart Jarvis Service') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                        sudo systemctl daemon-reload
                        sudo systemctl restart jarvis.service
                        sudo systemctl enable jarvis.service
                    '
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sshagent([SSH_CRED]) {
                    sh """
                    ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                        systemctl status jarvis.service --no-pager | head -15
                    '
                    """
                }
            }
        }

    }

    post {
        success {
            echo "🎉 SUCCESS: Jarvis deployed successfully!"
            echo "🌐 Visit your server: http://${SERVER_IP}"
        }
        failure {
            echo "❌ Deployment failed! Check logs above."
            echo "💡 Common issues:"
            echo "   - SSH key not configured in Jenkins"
            echo "   - EC2 server inaccessible"
            echo "   - jarvis.service not setup properly"
        }
        always {
            echo "🧹 Cleaning workspace..."
            cleanWs()
        }
    }
}
