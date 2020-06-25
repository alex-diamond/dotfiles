# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs  "$HOME"
cp dotfiles/.bashrc "$HOME"

# XFCE-look
mkdir -p ~/.icons
mkdir -p ~/.themes

# Configure for current Manjaro desktop
sudo chown skynet:skynet /mnt/DATA
mkdir -p /mnt/DATA/torrents

# SOFTWARE
mkdir -p /mnt/DATA/geant4
mkdir -p /mnt/DATA/geant4/build
mkdir -p /mnt/DATA/geant4/install

# Clear
rm -rf dotfiles
