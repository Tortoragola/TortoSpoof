

# Alias Setup

## Overview

Aliases allow you to run TortoSpoof commands quickly in your terminal without typing the full commands each time. This makes it easier and faster to spoof locations or manage your spoofing session.

## Adding Aliases

**Step 1:** Open your shell configuration file in a text editor. This is usually `~/.zshrc` for Zsh users or `~/.bashrc` for Bash users.

**Step 2:** Add the following alias definitions to the end of your file:

```shell
alias spoof='function _spoof(){ pymobiledevice3 developer dvt simulate-location set "$1" "$2" & caffeinate -dims; }; _spoof'
alias spoofclear='pymobiledevice3 developer dvt simulate-location clear'
alias spoofstop='pymobiledevice3 developer dvt simulate-location stop'
alias keepawake='caffeinate -dims'
```

**Step 3:** Save the file and reload your shell configuration by running:

```shell
source ~/.zshrc
# or, for Bash:
source ~/.bashrc
```

## Usage Examples

Set your location to Istanbul:
```shell
spoof 41.0082 28.9784
```

Clear the fake location:
```shell
spoofclear
```

Stop the spoofing session:
```shell
spoofstop
```

Keep your Mac awake without spoofing:
```shell
keepawake
```

## Tips

- Aliases are user-specific and reside in your shell's RC file (`~/.zshrc` or `~/.bashrc`).
- After editing your RC file, you must run `source ~/.zshrc` or `source ~/.bashrc` for changes to take effect.
- Aliases remain available in every new terminal session once added to your RC file.