# Set git configuration
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

# Put configuration files to the $HOME folder
git clone https://github.com/karlkorp/dotfiles.git
cp dotfiles/.emacs    "$HOME"/
cp dotfiles/.vimrc    "$HOME"/
cp dotfiles/.bashrc   "$HOME"/
cp dotfiles/.octaverc "$HOME"/
rm -rf dotfiles
