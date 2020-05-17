# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs  "$HOME"/
cp dotfiles/.bashrc "$HOME"/

# SOFTWARE
mkdir -p "$HOME"/.SOFTWARE/ECLIPSE
mkdir -p "$HOME"/.SOFTWARE/CERN
mkdir -p "$HOME"/.SOFTWARE/CERN/ROOT
mkdir -p "$HOME"/.SOFTWARE/CERN/ROOT/BUILD
mkdir -p "$HOME"/.SOFTWARE/CERN/ROOT/INSTALL
mkdir -p "$HOME"/.SOFTWARE/CERN/GEANT4
mkdir -p "$HOME"/.SOFTWARE/CERN/GEANT4/BUILD
mkdir -p "$HOME"/.SOFTWARE/CERN/GEANT4/INSTALL

# Clear
rm -rf dotfiles
