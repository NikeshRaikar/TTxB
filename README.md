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

---

## 🏗️ Hardware Architecture & Flow

The following diagram illustrates how the TTxB hardware components interface with the vehicle network and process incoming data. 

```mermaid
graph TD
    classDef hardware fill:#2C3E50,stroke:#34495E,stroke-width:2px,color:#fff;
    classDef software fill:#2980B9,stroke:#2980B9,stroke-width:2px,color:#fff;
    classDef vehicle fill:#C0392B,stroke:#C0392B,stroke-width:2px,color:#fff;

    V[Vehicle OBD-II / Gateway]:::vehicle

    subgraph Hardware Layer
        V -- CAN 0 / CAN 1 --> CH[https://github.com/NikeshRaikar/TTxB/blob/main/CAN_HAT_RASPBERYPI.jpeg]:::hardware
        V -- Automotive Ethernet --> ETH[https://github.com/NikeshRaikar/TTxB/blob/main/ADAPTER.jpeg]:::hardware
        CH -- SPI Interface --> RPI[https://github.com/NikeshRaikar/TTxB/blob/main/licensed-image.jpeg]:::hardware
        ETH --> RPI
    end

    subgraph Software Layer ["Software Layer (TTxB-v1.0)"] 
        RPI --> S[systemd Service]:::software
        S --> P[Python Logging Daemon]:::software
        P --> DB[(/var/log/TTxB Storage)]:::software
    end
