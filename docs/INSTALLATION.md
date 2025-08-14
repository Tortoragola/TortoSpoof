# Installation Guide

Welcome to the TortoSpoof installation guide! Follow these steps to get TortoSpoof running on your Mac and iPhone.

## Prerequisites

- **macOS** (tested on macOS 13+)
- **Homebrew** (optional if you run the install script; the script will warn if missing)
- **Developer Mode enabled on the iPhone**
- **USB cable** to connect iPhone to Mac

---

## Step 1: Install Homebrew (Optional)

If you don't have Homebrew installed and want to manage packages manually, install it first:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

---

## Step 2: Enable Developer Mode on iPhone

1. Connect your iPhone to your Mac via USB.
2. On your iPhone, go to **Settings > Privacy & Security > Developer Mode**.
3. Toggle **Developer Mode** on and restart your iPhone if prompted.

---

## Step 3: Clone the Repository and Run the Installer

```shell
git clone https://github.com/Tortoragola/TortoSpoof.git
cd TortoSpoof
./install.sh
source ~/.zshrc
```
The `install.sh` script will handle installing Python, `pymobiledevice3`, and other dependencies, and it will automatically add the GPS spoofing commands to your `.zshrc`.

---

## Step 4: Test the Connection

Before testing, make sure to source your shell configuration:
```shell
source ~/.zshrc
```

Verify your iPhone is detected:
```shell
pymobiledevice3 list-devices
```
Your device should appear in the list.

---

## Step 5: First Spoof Test

Try a test spoof (example coordinates for Istanbul):
```shell
spoof 41.0082 28.9784
```
Check your iPhone to verify the location has changed.

---

## Troubleshooting

If you encounter issues, see [docs/TROUBLESHOOTING.md](TROUBLESHOOTING.md) for help.