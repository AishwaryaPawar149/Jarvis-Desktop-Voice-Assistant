pipeline {
    agent any

    environment {
        SERVER_USER = "ubuntu"
        SERVER_IP   = "13.201.37.19"  // Replace with your actual EC2 public IP
        APP_PATH    = "/home/ubuntu/Jarvis-Desktop-Voice-Assistant"
        SSH_CRED_ID = "terraform"       // Jenkins SSH credential ID
    }

    stages {
        stage('Checkout Code') {
            steps {
                echo "📥 Cloning Jarvis repository..."
                git branch: 'main', url: 'git@github.com:AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git', credentialsId: SSH_CRED_ID
            }
        }

        stage('Test SSH Connection') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'echo \'✅ SSH Connection Successful\''"
                }
            }
        }

        stage('Clean Previous Deployment') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'rm -rf ${APP_PATH}/* && echo \'✅ Previous Deployment Cleared\''"
                }
            }
        }

        stage('Upload Application') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "scp -o StrictHostKeyChecking=no -r * ${SERVER_USER}@${SERVER_IP}:${APP_PATH}/"
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'cd ${APP_PATH} && pip install -r requirements.txt'"
                }
            }
        }

        stage('Restart Jarvis Service') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'sudo systemctl restart jarvis.service'"
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'systemctl status jarvis.service --no-pager | head -10'"
                }
            }
        }
    }

    post {
        success {
            echo "🎉 SUCCESS: Jarvis Deployed Successfully via Jenkins!"
        }
        failure {
            echo "❌ Deployment failed! Check logs above."
            echo "💡 Common issues:"
            echo "   - SSH key not configured correctly in Jenkins credentials"
            echo "   - EC2 server not accessible (security groups, public IP)"
            echo "   - Dependencies missing or pip errors"
            echo "   - jarvis.service misconfigured or missing"
        }
        always {
            echo "🧹 Cleaning workspace..."
            cleanWs()
        }
    }
}
