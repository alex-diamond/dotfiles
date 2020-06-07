# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs  "$HOME"
cp dotfiles/.bashrc "$HOME"

sudo chown skynet:skynet /mnt/DATA
mkdir -p /mnt/DATA/TORRENTS

# SOFTWARE
mkdir -p /mnt/DATA/SOFTWARE
mkdir -p /mnt/DATA/SOFTWARE/CERN
mkdir -p /mnt/DATA/SOFTWARE/CERN/ROOT
mkdir -p /mnt/DATA/SOFTWARE/CERN/ROOT/BUILD
mkdir -p /mnt/DATA/SOFTWARE/CERN/ROOT/INSTALL
mkdir -p /mnt/DATA/SOFTWARE/CERN/GEANT4
mkdir -p /mnt/DATA/SOFTWARE/CERN/GEANT4/BUILD
mkdir -p /mnt/DATA/SOFTWARE/CERN/GEANT4/INSTALL

# Clear
rm -rf dotfiles
