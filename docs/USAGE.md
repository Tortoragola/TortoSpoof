# Usage Guide

## Overview

TortoSpoof (iSpoof) is a tool that allows you to set a fake GPS location on your iPhone from your Mac. It also provides features to keep your Mac awake while spoofing and to restore your iPhone's original location when you're done.

## Prerequisites

- macOS installed on your Mac.
- Python 3.x installed.
- `pymobiledevice3` Python package installed.
- Developer Mode enabled on your iPhone.

## Setting a Fake Location

To set a fake GPS location on your iPhone, use the following command:

```shell
spoof <LAT> <LON>
```

Replace `<LAT>` and `<LON>` with the latitude and longitude coordinates you want to spoof. For example:

```shell
spoof 37.7749 -122.4194
```

## Clearing the Fake Location

To clear the fake location and restore your iPhone's original GPS location, run:

```shell
spoof clear
```

## Stopping Spoofing

To stop the spoofing process completely, use:

```shell
spoof stop
```

## Keeping Mac Awake

The keep-awake feature runs automatically when you start spoofing to prevent your Mac from sleeping. If you want to run the keep-awake feature alone without spoofing, use:

```shell
keepawake
```

## Tips & Notes

- Ensure your iPhone is connected to your Mac via USB while using TortoSpoof.
- If you reboot your iPhone or Mac, you may need to re-run the spoof command.
- To check your current spoofed location, use the appropriate commands or verify on your iPhone's location services.
