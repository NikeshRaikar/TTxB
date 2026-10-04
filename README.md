# TTxB: Automotive Network Data Logger

[![Platform: Raspberry Pi 5](https://img.shields.io/badge/Platform-Raspberry%20Pi%205-c51a4a?style=flat-square&logo=raspberry-pi)](#)
[![OS: Debian / Linux](https://img.shields.io/badge/OS-Linux%20%2F%20Debian-a81d33?style=flat-square&logo=linux)](#)
[![Language: Python](https://img.shields.io/badge/Language-Python-3776AB?style=flat-square&logo=python)](#)
[![Build: TTxB-v1.0](https://img.shields.io/badge/Build-TTxB--v1.0-brightgreen?style=flat-square)](#)

TTxB is a robust, lightweight, and automated vehicle network traffic logging suite. Distributed as a custom Debian package (`TTxB-v1.0`), this tool transforms a Raspberry Pi 5 into a fully autonomous logging device capable of capturing multi-protocol automotive data streams seamlessly in the background.

## 🚀 Key Features

*   **Dual-Channel CAN Logging:** Efficiently captures traffic across two Controller Area Network (CAN) channels using a CAN HAT integration and Python-based logging scripts (`python-can`).
*   **Ethernet Bridging:** Dedicated Ethernet bridging configurations to intercept, monitor, and log high-speed network traffic.
*   **Autonomous Background Execution:** Fully managed by custom Linux `systemd` background services, ensuring logging initiates automatically upon vehicle startup/boot without requiring user intervention.
*   **Turnkey Deployment:** Packaged into a standard Debian installer (`.deb`), handling file structure placement, dependency management, and service initialization in a single command.

## 🛠 Hardware & Software Requirements

### Hardware
*   **Raspberry Pi 5** (Recommended for optimal I/O bandwidth and processing performance)
*   **Dual-Channel CAN HAT** 
*   MicroSD card with Raspberry Pi OS (Debian-based)

### Software Ecosystem
*   Python 3.x
*   `python-can` library
*   `systemd` (for daemon management)
*   `dpkg` / `apt` (for installation)

## 📦 Installation

Deployment is streamlined through the pre-compiled `ceT-logger-v1.0` package, which automatically unpacks the required folder structure and control files.

```bash
# Clone the repository (if accessing source files)
git clone [https://github.com/NikeshRaikar/TTxB.git](https://github.com/NikeshRaikar/TTxB.git)
cd TTxB

# Install the custom Debian package
sudo dpkg -i ceT-logger-v1.0.deb

# Resolve any potential missing system dependencies
sudo apt-get install -f
