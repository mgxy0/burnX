# burnX  

![DALL·E-2024-06-01-12 49 10-Logo-design-for-burnX-featuring-a-burning-USB-key(1)](https://github.com/mgxy0/burnX/assets/127632468/3187aedd-d53f-4673-a936-1d9742a0beff)

`burnX` is a C++ utility that mimics the functionality of `dd`, a Unix tool for copying and converting files, while adding capabilities to burn CD/DVDs and create ISO images. This tool is designed to be independent and does not rely on external libraries for core functionalities.

## Features 🛠️

- Copy and convert files with specified block sizes and conversions
-  Burn ISO images to CD/DVD
-   Create ISO images from directories

## Installation 📦

### Prerequisites 🔣

Install the necessary libraries:

  ```sh
  sudo apt-get install libisofs-dev libburn-dev
  ```

Clone the repository and compile the program:

  ```sh
  git clone https://github.com/yourusername/burnX.git
  cd burnX
  make
  ```

## Usage 🚀

### Copy and Convert Files 📑

  ```sh
  ./burnX copy input.txt output.txt
  ```

### Create ISO Image 💽

  ```sh
  ./burnX iso /path/to/source output.iso
  ```

### Burn ISO to CD/DVD 🎇

  ```sh
  ./burnX burn /dev/sr0 image.iso
  ```

### Copy to USB Device 🔌


  ```sh
  ./burnX usb input.txt /dev/sdX
  ```

### Burn DMG to USB or CD/DVD 🎆

  ```sh
  ./burnX dmg image.dmg /dev/sdX
  ```

### Burn .app to USB 🌋

The burnX installmedia command allows you to create a boot drive for installing macOS using the macOS installer application downloaded from the Mac App Store. This command formats the USB drive as APFS and copies the macOS installer to the drive, making it bootable. For example for Bigsur:

  ```sh
  sudo ./burnX installmedia /Applications/Install\ macOS\ Big\ Sur.app /Volumes/MyVolume
  ```

## Requirements 🗃️

- MacOS or Linux
- hdiutil, createinstallmedia, Xcode Command Line Tools (only in MacOS)
- libisosofs-dev, libburn-dev

## License 📄

GNU GPLv3 🐃

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2024 - mgxy0 / mark1n0
