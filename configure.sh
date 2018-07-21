# Set git configuration
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

# Create frequently used folders
mkdir -p "$HOME"/Torrents
mkdir -p "$HOME"/VirtualBox

# Install RTags
sh rtags_install.sh

# Put configuration files to the $HOME folder
git clone https://github.com/karlkorp/dotfiles.git
cp dotfiles/.emacs             "$HOME"/
cp dotfiles/.vimrc             "$HOME"/
cp dotfiles/.bashrc            "$HOME"/
cp dotfiles/.octaverc          "$HOME"/
cp dotfiles/.emacs_packages.el "$HOME"/
sudo -H sh dotfiles/python_packages.sh
rm -rf dotfiles
