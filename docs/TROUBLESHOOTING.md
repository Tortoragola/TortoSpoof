# Troubleshooting Guide

## iOS version not supported

TortoSpoof may require updates when Apple changes how location services work in new iOS versions. If you encounter issues, please:

- Check for the latest version of `pymobiledevice3`.
- Review the iOS compatibility notes for any known issues or required updates.
- Keep your tool and dependencies up to date to ensure compatibility.

## RSD failed

Remote Service Discovery (RSD) can fail due to several reasons:

- Faulty or non-certified USB cable.
- The iOS device is locked.
- Developer Mode is turned off on the device.

To resolve this, try clearing and restarting the spoof service with new coordinates:

```shell
spoof clear && spoof <LAT> <LON>
```

Ensure your device is unlocked and Developer Mode is enabled before attempting to connect.

## Device not found

If your device is not detected, try the following:

- Run the command to list connected devices:

  ```shell
  pymobiledevice3 list-devices
  ```

- On macOS, make sure your device is trusted. When you connect your device, a prompt should appear asking to trust the computer. Confirm this prompt on the device.

## Location not changing

If the location does not update as expected:

- Retry the spoof command by stopping and restarting the spoof service with new coordinates:

  ```shell
  spoof stop && spoof <LAT> <LON>
  ```

- Ensure no other location spoofing applications are running that might interfere.

## Mac goes to sleep during spoofing

If your Mac goes to sleep during spoofing, it can interrupt the process. To prevent this, note that the spoof command automatically runs `caffeinate` to keep your Mac awake during the spoofing session, so no additional tools or steps are necessary.
