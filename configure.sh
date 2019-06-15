# Set git configuration and clone "dotfiles"
git config --global user.name "karlkorp"
git config --global user.email "lispgod@gmail.com"

git clone https://github.com/karlkorp/dotfiles.git

# Put configuration files to the $HOME folder
cp dotfiles/.emacs    "$HOME"/
cp dotfiles/.guile    "$HOME"/
cp dotfiles/.vimrc    "$HOME"/
cp dotfiles/.bashrc   "$HOME"/
cp dotfiles/.octaverc "$HOME"/

# Install local fonts
mkdir -p   "$HOME"/.fonts
tar   -xvf dotfiles/msf.tar
cp    -rf  msf "$HOME"/.fonts

# Clear
rm -rf dotfiles msf
