# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs   $HOME
cp dotfiles/.bashrc  $HOME
cp dotfiles/.aliases $HOME

# XFCE-look
mkdir -p ~/.icons
mkdir -p ~/.themes

# Configure for current Manjaro desktop
sudo chown skynet:skynet /mnt/DATA
mkdir -p /mnt/DATA/torrents

# CERN SOFTWARE
CERN_PATH=/mnt/DATA/CERN
# ROOT
mkdir -p $CERN_PATH/ROOT
mkdir -p $CERN_PATH/ROOT/build
mkdir -p $CERN_PATH/ROOT/install
# Geant4
mkdir -p $CERN_PATH/Geant4
mkdir -p $CERN_PATH/Geant4/build
mkdir -p $CERN_PATH/Geant4/install
# FLUKA
mkdir -p $CERN_PATH/FLUKA
# FLAIR
mkdir -p $CERN_PATH/FLAIR

# Clear
rm -rf dotfiles
