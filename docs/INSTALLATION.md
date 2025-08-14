

# Installation Guide

Welcome to the TortoSpoof installation guide! Follow these steps to get TortoSpoof running on your Mac and iPhone.

## Prerequisites

- **macOS** (tested on macOS 13+)
- **Python 3.9 or later**
- **Homebrew** (for package installation)
- **Developer Mode enabled on the iPhone**
- **USB cable** to connect iPhone to Mac

---

## Step 1: Install Required Tools

If you don't have Homebrew installed, install it first:
```shell
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
```

Install Python 3:
```shell
brew install python3
```

Install `pymobiledevice3`:
```shell
pip3 install pymobiledevice3
```

---

## Step 2: Enable Developer Mode on iPhone

1. Connect your iPhone to your Mac via USB.
2. On your iPhone, go to **Settings > Privacy & Security > Developer Mode**.
3. Toggle **Developer Mode** on and restart your iPhone if prompted.

---

## Step 3: Clone the Repository

```shell
git clone https://github.com/<yourusername>/TortoSpoof.git
cd TortoSpoof
```

---

## Step 4: Set Up Aliases

For quick commands, set up aliases as described in [docs/ALIASES.md](ALIASES.md).

---

## Step 5: Test the Connection

Verify your iPhone is detected:
```shell
pymobiledevice3 list-devices
```
Your device should appear in the list.

---

## Step 6: First Spoof Test

Try a test spoof (example coordinates for Istanbul):
```shell
spoof 41.0082 28.9784
```
Check your iPhone to verify the location has changed.

---

## Troubleshooting

If you encounter issues, see [docs/TROUBLESHOOTING.md](TROUBLESHOOTING.md) for help.