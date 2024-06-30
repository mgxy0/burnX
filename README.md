# burnX  

![image](https://github.com/mgxy0/burnX/assets/127632468/c6a0e497-c36b-41b2-8ef2-b444c20d6681) 

`burnX` is a C++ utility that mimics the functionality of `dd`, a Unix tool for copying and converting files, while adding capabilities to burn CD/DVDs, create ISO images and create a install media for MacOS with .app files.

## Features 🛠️

- Copy and convert files with specified block sizes and conversions
-  Burn ISO images to CD/DVD
-   Create ISO images from directories
-   Create a MacOS install media 

## Installation 📦

### Prerequisites 🔣

Install the necessary libraries:

  - libisofs : https://dev.lovelyhq.com/libburnia/libisofs
  - libburn : https://dev.lovelyhq.com/libburnia/libburn

Linux 🐧

  ```sh
  sudo apt-get install libisofs-dev libburn-dev
  ```
MacOS   

 ```sh
  brew install libisofs libburn
  ```

Clone the repository and compile the program:

  ```sh
  git clone https://github.com/mgxy0/burnX.git
  cd burnX
  make
  ```

## Usage ⚙️

### Copy and Convert Files 🔂

  ```sh
  ./burnX copy input.txt output.txt
  ```

### Create ISO Image 💽

  ```sh
  ./burnX iso /path/to/source output.iso
  ```

### Burn ISO to CD/DVD 💿

  ```sh
  ./burnX burn /dev/sr0 image.iso
  ```

### Copy to USB Device ⏏️

  ```sh
  ./burnX usb input.txt /dev/sdX
  ```

### Burn DMG to USB or CD/DVD 💿

  ```sh
  ./burnX dmg image.dmg /dev/sdX
  ```

### Burn .app to USB Device ⏏️

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
