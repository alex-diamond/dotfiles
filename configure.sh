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
mkdir -p /mnt/DATA/TORRENTS

# SOFTWARE
mkdir -p /mnt/DATA/SOFTWARE
mkdir -p /mnt/DATA/SOFTWARE/GEANT4
mkdir -p /mnt/DATA/SOFTWARE/GEANT4/BUILD
mkdir -p /mnt/DATA/SOFTWARE/GEANT4/INSTALL

# Clear
rm -rf dotfiles
