# burnX ![DALL·E-2024-06-01-12 49 10-Logo-design-for-burnX-featuring-a-burning-USB-key](https://github.com/mgxy0/burnX/assets/127632468/aaf9d841-1f74-47cd-8575-8a5e3d25229b)

`burnX` is a C utility that mimics the functionality of `dd`, a Unix tool for copying and converting files, while adding capabilities to burn CD/DVDs and create ISO images. This tool is designed to be independent and does not rely on external libraries for core functionalities.

## Features 🛠️

- Copy and convert files with specified block sizes and conversions
- Burn ISO images to CD/DVD
- Create ISO images from directories

## Installation 📦

### Prerequisites

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

### Copy and Convert Files

```sh
./burnX copy input.txt output.txt [block_size] [count] [skip] [seek]
```

### Create ISO Image

```sh
./burnX iso /path/to/source output.iso
```

### Burn ISO to CD/DVD

```sh
./burnX burn /dev/sr0 image.iso
```

## Requirements 🗃️

MacOS or Linux, C, gcc, libisosofs-dev, libburn-dev

## License 📄

GNU GPLv3 🐃

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2024 - mgxy0 / mark1n0
