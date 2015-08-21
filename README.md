ln -s .dotfile/.vim
ln -s .dotfile/.vimrc
ln -s .dotfile/.profile

git clone --recursive https://github.com/dsem/.dotfiles

Open vim and do

    :PluginInstall
