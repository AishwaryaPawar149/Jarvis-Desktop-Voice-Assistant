#!/bin/bash
sudo apt update -y
sudo apt install python3 python3-pip git -y

cd /home/ubuntu
git clone https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git

cd Jarvis-Desktop-Voice-Assistant
pip3 install -r requirements.txt

echo "[Unit]
Description=Jarvis Desktop Voice Assistant
After=network.target

[Service]
ExecStart=/usr/bin/python3 /home/ubuntu/Jarvis-Desktop-Voice-Assistant/jarvis.py
Restart=always
User=ubuntu

[Install]
WantedBy=multi-user.target" > /etc/systemd/system/jarvis.service

sudo systemctl daemon-reload
sudo systemctl enable jarvis.service
sudo systemctl start jarvis.service
