# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs  "$HOME"/
cp dotfiles/.bashrc "$HOME"/

# Clear
rm -rf dotfiles
