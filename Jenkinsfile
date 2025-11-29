pipeline {
    agent any

    environment {
        EC2_USER = 'ubuntu'
        EC2_HOST = '13.126.10.149'
        SSH_KEY = '/var/lib/jenkins/ssh/terraform.pem'  // Jenkins server path to your private key
        APP_DIR = '/home/ubuntu/Jarvis-Desktop-Voice-Assistant'
    }

    stages {
        stage('Pull latest code') {
            steps {
                sh "ssh -o StrictHostKeyChecking=no -i ${SSH_KEY} ${EC2_USER}@${EC2_HOST} 'cd ${APP_DIR} && git pull origin main'"
            }
        }

        stage('Install dependencies') {
            steps {
                sh "ssh -i ${SSH_KEY} ${EC2_USER}@${EC2_HOST} 'cd ${APP_DIR} && pip3 install -r requirements.txt --user'"
            }
        }

        stage('Restart Jarvis service') {
            steps {
                sh "ssh -i ${SSH_KEY} ${EC2_USER}@${EC2_HOST} 'sudo systemctl restart jarvis'"
            }
        }

        stage('Verify service') {
            steps {
                sh "ssh -i ${SSH_KEY} ${EC2_USER}@${EC2_HOST} 'sudo systemctl status jarvis | tail -n 10'"
            }
        }
    }
}
