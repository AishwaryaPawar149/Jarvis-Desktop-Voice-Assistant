# 🤖 Jarvis Desktop Voice Assistant

A Python-based desktop voice assistant inspired by Iron Man's JARVIS. This intelligent assistant can perform various tasks through voice commands including web searches, opening applications, playing music, and much more.

![Python](https://img.shields.io/badge/Python-3.8+-blue.svg)
![Status](https://img.shields.io/badge/Status-Active-success.svg)

---

## Table of Contents

* [Features](#features)
* [Prerequisites](#prerequisites)
* [Installation](#installation)
* [Deployment](#deployment)
* [Usage](#usage)
* [Voice Commands](#voice-commands)
* [Troubleshooting](#troubleshooting)
* [Contributing](#contributing)


---

## Features

* **Voice Recognition** - Natural speech-to-text conversion
* **Text-to-Speech** - Human-like voice responses
* **Web Search** - Google, YouTube, Wikipedia searches
* **App Control** - Open applications via voice
* **Media Playback** - Play music and videos
* **Time & Date** - Get current time and date information
* **Weather Updates** - Real-time weather information
* **System Control** - Shutdown, restart, sleep commands

---

## Prerequisites

Before installation, ensure you have:

* **Python 3.8+** installed
* **pip** package manager
* **Git** for cloning repository
* **Microphone** for voice input
* **Speakers/Headphones** for audio output

### System Requirements

* **OS:** Windows 10/11, Linux (Ubuntu 20.04+), macOS
* **RAM:** Minimum 4GB
* **Storage:** 500MB free space
* **Internet:** Required for web-based features

---

## Installation

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

## Deployment

### Automated Deployment with Jenkins CI/CD

This project includes automated deployment to AWS EC2 using Jenkins pipeline.

#### Prerequisites:

* Jenkins server configured
* AWS EC2 instance (Ubuntu)
* SSH credentials configured in Jenkins

>  Note: Terraform is used only for provisioning the EC2 server (Infrastructure as Code). The application setup is handled by Jenkins.

#### Deployment Steps:

1. **Configure Jenkins:**

   * Create new Pipeline job
   * Point to this repository
   * Add SSH credentials with ID: `terraform`

2. **Update Jenkinsfile:**

```groovy
   environment {
       SERVER_IP = "YOUR_EC2_PUBLIC_IP"
   }
```

3. **Run Pipeline:**

   * Jenkins will automatically:

     * Clone repository
     * Setup Python environment on EC2
     * Install dependencies
     * Create systemd service
     * Deploy application

#### Manual EC2 Deployment (Optional):

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
```

---

## Usage

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
sudo systemctl status jarvis.service
sudo journalctl -u jarvis.service -f
sudo journalctl -u jarvis.service -n 50
```

### Stop Jarvis

```bash
sudo systemctl stop jarvis.service
```

---

## Voice Commands

### General Commands

* "Hello Jarvis" - Activate assistant
* "What's your name?" - Get assistant name
* "How are you?" - Casual conversation
* "Thank you" - Gratitude response

### Search & Browse

* "Search Google for [query]"
* "Open YouTube"
* "Search Wikipedia for [topic]"
* "Open [website name]"

### System Control

* "What time is it?"
* "What's the date?"
* "Open [application name]"
* "Shutdown system"
* "Restart system"

### Media

* "Play [song name]"
* "Play music"
* "Stop music"

### Weather

* "What's the weather?"
* "Weather in [city]"

---

## Troubleshooting

Refer to the previous troubleshooting commands for microphone, audio, service, permissions, and module issues.

---

## Contributing

Contributions are welcome! Please fork the repository, create a feature branch, commit, push, and open a pull request.

---

## Author

**Aishwarya Pawar**

* GitHub: [@AishwaryaPawar149](https://github.com/AishwaryaPawar149)
* Repository: [Jarvis-Desktop-Voice-Assistant](https://github.com/AishwaryaPawar149/Jarvis-Desktop-Voice-Assistant)

---

## Future Enhancements

* Multi-language support
* Custom wake word detection
* Integration with smart home devices
* Mobile app support
* Cloud synchronization
* Advanced AI conversations

---

**⭐ If you like this project, please give it a star on GitHub!**
