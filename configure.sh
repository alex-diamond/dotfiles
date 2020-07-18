# Set git configuration and clone "dotfiles"
git config --global user.name  "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs  "$HOME"
cp dotfiles/.bashrc "$HOME"

# XFCE-look
mkdir -p ~/.icons
mkdir -p ~/.themes

# Configure for current Manjaro desktop
DATA_PATH=/mnt/DATA
sudo chown skynet:skynet $DATA_PATH
mkdir -p $DATA_PATH/torrents

# CERN SOFTWARE
CERN_PATH=$DATA_PATH/CERN
mkdir -p $CERN_PATH
# ROOT
mkdir -p $CERN_PATH/ROOT
mkdir -p $CERN_PATH/ROOT/build
mkdir -p $CERN_PATH/ROOT/install
# Geant4
mkdir -p $CERN_PATH/Geant4
mkdir -p $CERN_PATH/Geant4/build
mkdir -p $CERN_PATH/Geant4/install

# Clear
rm -rf dotfiles
