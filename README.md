# burnX  

<img width="642" alt="Screenshot 2024-07-01 alle 11 50 32" src="https://github.com/mgxy0/burnX/assets/127632468/06528a26-0d23-493d-bc7a-08460eb3de24">

`burnX` is a Ruby utility created with gtk3 for copying and converting files, burn CD/DVDs, create ISO images and create a install media for MacOS with .app files.

## Features 🛠️

-  Copy and convert files 
-  Burn ISO images to CD/DVD
-  Create ISO images from directories
-  Create a MacOS install media [ only MacOS ( require create_install_media and .app installation file from appstore) ]

## Install the necessary libraries :

### Linux 🐧  

```sh
sudo apt-get update
sudo apt-get install libgtk-3-dev genisoimage wodim
```
### MacOS 

```sh
brew install gtk+3
```

## Import and run the project : 

-  Import the ruby project :
```sh
git clone https://github.com/mgxy0/burnX.git
cd burnX
```
-  Install Gems
```sh
sudo bundle install
```
-  Run burnX
```sh
sudo bundle exec ruby main.rb
```

## Requirements 🗃️

-  Ruby 🔻
-  Gtk3 ❇️
[ only Linux]
-  Genisoimage
-  Wodim
  
## License 📄

GNU GPLv3 🐃

-----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------

### 2024 - mgxy0 / mark1n0
