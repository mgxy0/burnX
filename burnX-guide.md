
# 📘 User Guide for burnX

## 🔍 Overview

`burnX` is a powerful and flexible utility for copying and converting files, as well as burning CD/DVDs, creating ISO images, and copying files to USB devices. This guide will help you understand how to use its various features in detail.

## 📄 Copy and Convert Files

To copy and convert files, use the `copy` command. For example:

```sh
./burnX copy input.txt output.txt
```

This command copies the contents of `input.txt` to `output.txt`.

### ⚙️ Options for Copy and Convert

- `block_size` (optional): Size of each block in bytes (default: 512)
- `count` (optional): Number of blocks to copy (default: 0, meaning all blocks)
- `skip` (optional): Number of input blocks to skip (default: 0)
- `seek` (optional): Number of output blocks to skip (default: 0)

### 📝 Examples

- Copy a file with block size of 1K bytes:
  ```sh
  ./burnX copy input.txt output.txt 1024
  ```

- Skip 10 input blocks and 5 output blocks, and copy 100 blocks:
  ```sh
  ./burnX copy input.txt output.txt 512 100 10 5
  ```

## 📀 Create ISO Image

To create an ISO image from a directory, use the `iso` command:

```sh
./burnX iso /path/to/source output.iso
```

This command creates an ISO image from the contents of `/path/to/source` directory and saves it as `output.iso`.

### Example

Create an ISO image of the `my_folder` directory:

```sh
./burnX iso my_folder my_image.iso
```

## 💿 Burn ISO to CD/DVD

To burn an ISO image to a CD/DVD, use the `burn` command. Specify the device and the image file:

```sh
./burnX burn /dev/sr0 image.iso
```

This command burns the `image.iso` file to the CD/DVD device at `/dev/sr0`.

### Example

Burn an ISO image to a CD/DVD:

```sh
./burnX burn /dev/sr0 my_image.iso
```

## 🔌 Copy to USB Device

To copy a file to a USB device, use the `usb` command. Specify the input file and the USB device:

```sh
./burnX usb input.txt /dev/sdX
```

This command copies `input.txt` to the USB device at `/dev/sdX`.

### ⚙️ Options for Copy to USB Device

- `block_size` (optional): Size of each block in bytes (default: 512)
- `count` (optional): Number of blocks to copy (default: 0, meaning all blocks)
- `skip` (optional): Number of input blocks to skip (default: 0)
- `seek` (optional): Number of output blocks to skip (default: 0)

### Example

Copy a file to a USB device with a block size of 1K bytes:

```sh
./burnX usb input.txt /dev/sdX 1024
```

## 💿 Burn DMG to USB or CD/DVD

To burn a DMG image to a USB or CD/DVD, use the `dmg` command. Specify the image file and the device:

```sh
./burnX dmg image.dmg /dev/sdX
```

This command burns the `image.dmg` file to the USB device at `/dev/sdX` or to a CD/DVD.

### Example

Burn a DMG image to a USB device:

```sh
./burnX dmg my_image.dmg /dev/sdX
```

## 🔧 Additional Information

Ensure you have the necessary permissions to read and write to the specified devices. You might need to run the commands with `sudo` if you encounter permission issues.

For any issues or contributions, please visit the project's [GitHub repository](https://github.com/yourusername/burnX).
