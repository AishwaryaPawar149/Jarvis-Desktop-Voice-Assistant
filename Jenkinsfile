pipeline {
    agent any

    environment {
        SERVER_USER = "ubuntu"
        SERVER_IP   = "13.201.37.19"
        APP_PATH    = "/home/ubuntu/Jarvis-Desktop-Voice-Assistant"
        SSH_CRED_ID = "terraform"
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
                    sh "ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} 'echo ✅ SSH Connection Successful'"
                }
            }
        }

        stage('Setup Python & System Requirements') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            echo "🔧 Installing Python and dependencies..."
                            sudo apt update
                            sudo apt install -y python3 python3-pip python3-venv portaudio19-dev
                            echo ✅ System Requirements Installed
                        '
                    """
                }
            }
        }

        stage('Clean Previous Deployment') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            if [ -d "${APP_PATH}" ]; then
                                rm -rf ${APP_PATH}/*
                            else
                                mkdir -p ${APP_PATH}
                            fi
                            echo ✅ Previous Deployment Cleared
                        '
                    """
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

        stage('Create Virtual Environment') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            cd ${APP_PATH}
                            echo "🐍 Creating Python virtual environment..."
                            python3 -m venv venv
                            echo ✅ Virtual Environment Created
                        '
                    """
                }
            }
        }

        stage('Install Dependencies') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            cd ${APP_PATH}
                            source venv/bin/activate
                            echo "📦 Installing Python packages..."
                            pip install --upgrade pip
                            pip install -r requirements.txt
                            echo ✅ Dependencies Installed Successfully
                        '
                    """
                }
            }
        }

        stage('Create Systemd Service') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            echo "⚙️ Creating systemd service..."
                            sudo tee /etc/systemd/system/jarvis.service > /dev/null <<EOF
[Unit]
Description=Jarvis Desktop Voice Assistant
After=network.target sound.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=${APP_PATH}
Environment="PATH=${APP_PATH}/venv/bin:/usr/local/bin:/usr/bin:/bin"
ExecStart=${APP_PATH}/venv/bin/python ${APP_PATH}/Jarvis/jarvis.py
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
EOF
                            sudo systemctl daemon-reload
                            sudo systemctl enable jarvis.service
                            echo ✅ Service Created and Enabled
                        '
                    """
                }
            }
        }

        stage('Restart Jarvis Service') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            echo "🔄 Restarting Jarvis service..."
                            sudo systemctl restart jarvis.service
                            sleep 3
                            echo ✅ Service Restarted
                        '
                    """
                }
            }
        }

        stage('Verify Deployment') {
            steps {
                sshagent([SSH_CRED_ID]) {
                    sh """
                        ssh -o StrictHostKeyChecking=no ${SERVER_USER}@${SERVER_IP} '
                            echo "🔍 Checking service status..."
                            sudo systemctl status jarvis.service --no-pager | head -15
                            
                            echo ""
                            echo "📋 Recent logs:"
                            sudo journalctl -u jarvis.service -n 20 --no-pager
                        '
                    """
                }
            }
        }
    }

    post {
        success {
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "🎉 SUCCESS: Jarvis Deployed Successfully!"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "✅ Application deployed to: ${APP_PATH}"
            echo "✅ Service: jarvis.service is running"
            echo "✅ Check logs: sudo journalctl -u jarvis.service -f"
        }
        failure {
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo "❌ DEPLOYMENT FAILED!"
            echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
            echo ""
            echo "💡 Troubleshooting steps:"
            echo "   1. Check SSH credentials in Jenkins"
            echo "   2. Verify EC2 security groups allow SSH (port 22)"
            echo "   3. SSH manually: ssh ubuntu@${SERVER_IP}"
            echo "   4. Check service logs: sudo journalctl -u jarvis.service"
        }
        always {
            echo "🧹 Cleaning workspace..."
            cleanWs()
        }
    }
}