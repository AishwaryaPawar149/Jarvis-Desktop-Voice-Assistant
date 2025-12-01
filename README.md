# 🤖 Jarvis Desktop Voice Assistant

A Python-based desktop voice assistant inspired by Iron Man's JARVIS. This intelligent assistant can perform various tasks through voice commands including web searches, opening applications, playing music, and much more.

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Status](https://img.shields.io/badge/Status-Active-success.svg)

---

##  Table of Contents

- [Features](#features)
- [Prerequisites](#prerequisites)
- [Installation](#installation)
- [Deployment](#deployment)
- [Usage](#usage)
- [Voice Commands](#voice-commands)
- [Troubleshooting](#troubleshooting)
- [Contributing](#contributing)
- [License](#license)

---

##  Features

-  **Voice Recognition** - Natural speech-to-text conversion
-  **Text-to-Speech** - Human-like voice responses
-  **Web Search** - Google, YouTube, Wikipedia searches
-  **App Control** - Open applications via voice
-  **Media Playback** - Play music and videos
-  **Time & Date** - Get current time and date information
-  **Weather Updates** - Real-time weather information
-  **System Control** - Shutdown, restart, sleep commands

---

##  Prerequisites

Before installation, ensure you have:

- **Python 3.8+** installed
- **pip** package manager
- **Git** for cloning repository
- **Microphone** for voice input
- **Speakers/Headphones** for audio output

### System Requirements

- **OS:** Windows 10/11, Linux (Ubuntu 20.04+), macOS
- **RAM:** Minimum 4GB
- **Storage:** 500MB free space
- **Internet:** Required for web-based features

---

##  Installation

### Local Setup (Desktop/Laptop)

1. **Clone the repository:**
```bash
   git clone https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git
   cd Jarvis-Desktop-Voice-Assistant
```

2. **Create virtual environment:**
```bash
   python3 -m venv venv
```

3. **Activate virtual environment:**
   
   **Linux/Mac:**
```bash
   source venv/bin/activate
```
   
   **Windows:**
```bash
   venv\Scripts\activate
```

4. **Install dependencies:**
```bash
   pip install --upgrade pip
   pip install -r requirements.txt
```

5. **Run Jarvis:**
```bash
   cd Jarvis
   python jarvis.py
```

---

##  Deployment

### Automated Deployment with Jenkins CI/CD

This project includes automated deployment to AWS EC2 using Jenkins pipeline.

#### Prerequisites:
- Jenkins server configured
- AWS EC2 instance (Ubuntu)
- SSH credentials configured in Jenkins

#### Deployment Steps:

1. **Configure Jenkins:**
   - Create new Pipeline job
   - Point to this repository
   - Add SSH credentials with ID: `terraform`

2. **Update Jenkinsfile:**
```groovy
   environment {
       SERVER_IP = "YOUR_EC2_PUBLIC_IP"
   }
```

3. **Run Pipeline:**
   - Jenkins will automatically:
     - Clone repository
     - Setup Python environment
     - Install dependencies
     - Create systemd service
     - Deploy application

#### Manual EC2 Deployment:
```bash
# SSH to EC2
ssh ubuntu@YOUR_EC2_IP

# Clone repository
git clone https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant.git
cd Jarvis-Desktop-Voice-Assistant

# Setup Python
sudo apt update
sudo apt install -y python3 python3-pip python3-venv portaudio19-dev

# Create virtual environment
python3 -m venv venv
source venv/bin/activate

# Install dependencies
pip install -r requirements.txt

# Create systemd service
sudo nano /etc/systemd/system/jarvis.service
```

**Service file content:**
```ini
[Unit]
Description=Jarvis Desktop Voice Assistant
After=network.target sound.target

[Service]
Type=simple
User=ubuntu
WorkingDirectory=/home/ubuntu/Jarvis-Desktop-Voice-Assistant
Environment="PATH=/home/ubuntu/Jarvis-Desktop-Voice-Assistant/venv/bin:/usr/local/bin:/usr/bin:/bin"
ExecStart=/home/ubuntu/Jarvis-Desktop-Voice-Assistant/venv/bin/python /home/ubuntu/Jarvis-Desktop-Voice-Assistant/Jarvis/jarvis.py
Restart=on-failure
RestartSec=10
StandardOutput=journal
StandardError=journal

[Install]
WantedBy=multi-user.target
```

**Enable and start service:**
```bash
sudo systemctl daemon-reload
sudo systemctl enable jarvis.service
sudo systemctl start jarvis.service
sudo systemctl status jarvis.service
```

---

##  Usage

### Starting Jarvis

**Local:**
```bash
cd Jarvis
python jarvis.py
```

**On Server:**
```bash
sudo systemctl start jarvis.service
```

### Check Service Status
```bash
# Status
sudo systemctl status jarvis.service

# Live logs
sudo journalctl -u jarvis.service -f

# Recent logs
sudo journalctl -u jarvis.service -n 50
```

### Stop Jarvis
```bash
sudo systemctl stop jarvis.service
```

---

##  Voice Commands

### General Commands
- "Hello Jarvis" - Activate assistant
- "What's your name?" - Get assistant name
- "How are you?" - Casual conversation
- "Thank you" - Gratitude response

### Search & Browse
- "Search Google for [query]"
- "Open YouTube"
- "Search Wikipedia for [topic]"
- "Open [website name]"

### System Control
- "What time is it?"
- "What's the date?"
- "Open [application name]"
- "Shutdown system"
- "Restart system"

### Media
- "Play [song name]"
- "Play music"
- "Stop music"

### Weather
- "What's the weather?"
- "Weather in [city]"

---

##  Troubleshooting

### Common Issues

#### 1. **Microphone not detected**
```bash
# Check available microphones
python -c "import speech_recognition as sr; print(sr.Microphone.list_microphone_names())"
```

#### 2. **Audio output issues**
```bash
# Linux - Install audio libraries
sudo apt install portaudio19-dev python3-pyaudio

# Check audio devices
aplay -l
```

#### 3. **Service not starting**
```bash
# Check logs for errors
sudo journalctl -u jarvis.service -n 100

# Check service status
sudo systemctl status jarvis.service

# Restart service
sudo systemctl restart jarvis.service
```

#### 4. **Permission errors**
```bash
# Fix file permissions
sudo chown -R ubuntu:ubuntu /home/ubuntu/Jarvis-Desktop-Voice-Assistant
chmod +x Jarvis/jarvis.py
```

#### 5. **Module not found errors**
```bash
# Reinstall dependencies
source venv/bin/activate
pip install --upgrade pip
pip install -r requirements.txt --force-reinstall
```

---

##  Contributing

Contributions are welcome! Please follow these steps:

1. Fork the repository
2. Create feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit changes (`git commit -m 'Add AmazingFeature'`)
4. Push to branch (`git push origin feature/AmazingFeature`)
5. Open Pull Request

---


##  Author

**Aishwarya Pawar**

- GitHub: [@AishwaryaPawar149](https://github.com/AishwaryaPawar149)
- Repository: [Jarvis-Desktop-Voice-Assistant](https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant)

---

##  Future Enhancements

- [ ] Multi-language support
- [ ] Custom wake word detection
- [ ] Integration with smart home devices
- [ ] Mobile app support
- [ ] Cloud synchronization
- [ ] Advanced AI conversations

---

** If you like this project, please give it a star on GitHub!**