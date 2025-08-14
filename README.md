
# TortoSpoof

TortoSpoof is a simple, effective GPS location spoofing tool for iPhones, designed to let you simulate your device's location with ease. It includes robust keep-awake features to ensure your spoofed location remains active, making it ideal for testing, development, and privacy scenarios.

## Features

- 📍 **Precise Location Spoofing**: Set your iPhone's GPS location to any coordinates instantly.
- 🛑 **Keep-Awake Functionality**: Prevents your device from sleeping, ensuring continuous spoofing.
- ♾ **Looped Location Paths**: Simulate movement by looping through a series of coordinates.
- 🔄 **Quick Location Switching**: Easily switch between saved locations for rapid testing.

## Requirements

- macOS (for running the tool)
- Python 3.8+
- Xcode Command Line Tools (for device communication)
- An iPhone (iOS 13 or later recommended)
- USB cable for device connection

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/TortoSpoof.git
   cd TortoSpoof
   ```
2. **Install dependencies:**
   ```bash
   pip install -r requirements.txt
   ```
3. **(Optional) Grant necessary permissions:**  
   Some features may require accessibility or device permissions.

## Usage

1. **Connect your iPhone to your Mac via USB.**
2. **Start TortoSpoof:**
   ```bash
   python tortospoof.py
   ```
3. **Select or input your desired location coordinates.**
4. **Enable keep-awake and other features as needed via the interface or command line options.**
5. **To stop spoofing, simply exit the program.**

> **Note:** For advanced usage, such as looping locations or scripting, see the [docs/USAGE.md](docs/USAGE.md) file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
