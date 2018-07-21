mkdir tmp && cd tmp || exit
git clone --recursive https://github.com/Andersbakken/rtags.git
cd rtags || exit
mkdir build && cd build || exit
cmake -DCMAKE_EXPORT_COMPILE_COMMANDS=1 ..
make -j4
sudo make install
cd || exit && rm -rf tmp
