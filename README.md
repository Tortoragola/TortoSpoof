
# TortoSpoof

TortoSpoof is a simple, effective GPS location spoofing tool for iPhones, designed to let you simulate your device's location with ease. It includes robust keep-awake features to ensure your spoofed location remains active, making it ideal for testing, development, and privacy scenarios.

## Features

- 📍 **Precise Location Spoofing**: Set your iPhone's GPS location to any coordinates instantly.
- 🛑 **Keep-Awake Functionality**: Prevents your device from sleeping, ensuring continuous spoofing.
- ♾ **Looped Location Paths**: Simulate movement by looping through a series of coordinates.
- 🔄 **Quick Location Switching**: Easily switch between saved locations for rapid testing.

## Requirements

- macOS (for running the tool)
- Xcode Command Line Tools (for device communication)
- An iPhone (iOS 13 or later recommended)
- USB cable for device connection

> **Note:** All required dependencies are automatically handled by the `install.sh` script.

## Installation

1. **Clone the repository:**
   ```bash
   git clone https://github.com/yourusername/TortoSpoof.git
   cd TortoSpoof
   ```
2. **Install dependencies and set up environment:**
   ```bash
   ./install.sh
   source ~/.zshrc
   ```
3. **(Optional) Grant necessary permissions:**  
   Some features may require accessibility or device permissions.

## Usage

1. **Connect your iPhone to your Mac via USB.**
2. **Spoof your location using the following commands:**
   ```bash
   spoof <LAT> <LON>         # Set your iPhone's location to the given latitude and longitude
   spoof clear               # Clear the spoofed location and restore real GPS
   spoof stop                # Stop spoofing and exit
   ```

> **Note:** While spoofing is active, TortoSpoof automatically keeps your Mac awake to ensure uninterrupted spoofing.

For advanced usage, such as looping locations or scripting, see the [docs/USAGE.md](docs/USAGE.md) file.

## License

This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
