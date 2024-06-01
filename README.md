# burnX  

![DALL·E-2024-06-01-12 49 10-Logo-design-for-burnX-featuring-a-burning-USB-key(1)](https://github.com/mgxy0/burnX/assets/127632468/3187aedd-d53f-4673-a936-1d9742a0beff)

`burnX` is a C++ utility that mimics the functionality of `dd`, a Unix tool for copying and converting files, while adding capabilities to burn CD/DVDs and create ISO images. This tool is designed to be independent and does not rely on external libraries for core functionalities.

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

Linux
  ```sh
  sudo apt-get install libisofs-dev libburn-dev
  ```
MacOS
 ```sh
  brew install libisofs libburn
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

### Burn ISO to CD/DVD 💿

  ```sh
  ./burnX burn /dev/sr0 image.iso
  ```

### Copy to USB Device <svg xmlns="http://www.w3.org/2000/svg" viewBox="0 0 640 512"><!--!Font Awesome Free 6.5.2 by @fontawesome - https://fontawesome.com License - https://fontawesome.com/license/free Copyright 2024 Fonticons, Inc.--><path d="M641.5 256c0 3.1-1.7 6.1-4.5 7.5L547.9 317c-1.4 .8-2.8 1.4-4.5 1.4-1.4 0-3.1-.3-4.5-1.1-2.8-1.7-4.5-4.5-4.5-7.8v-35.6H295.7c25.3 39.6 40.5 106.9 69.6 106.9H392V354c0-5 3.9-8.9 8.9-8.9H490c5 0 8.9 3.9 8.9 8.9v89.1c0 5-3.9 8.9-8.9 8.9h-89.1c-5 0-8.9-3.9-8.9-8.9v-26.7h-26.7c-75.4 0-81.1-142.5-124.7-142.5H140.3c-8.1 30.6-35.9 53.5-69 53.5C32 327.3 0 295.3 0 256s32-71.3 71.3-71.3c33.1 0 61 22.8 69 53.5 39.1 0 43.9 9.5 74.6-60.4C255 88.7 273 95.7 323.8 95.7c7.5-20.9 27-35.6 50.4-35.6 29.5 0 53.5 23.9 53.5 53.5s-23.9 53.5-53.5 53.5c-23.4 0-42.9-14.8-50.4-35.6H294c-29.1 0-44.3 67.4-69.6 106.9h310.1v-35.6c0-3.3 1.7-6.1 4.5-7.8 2.8-1.7 6.4-1.4 8.9 .3l89.1 53.5c2.8 1.1 4.5 4.1 4.5 7.2z"/></svg>


  ```sh
  ./burnX usb input.txt /dev/sdX
  ```

### Burn DMG to USB or CD/DVD 📀

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
