Start with:

    git clone --recursive https://github.com/dsem/.dotfiles

then 

    ln -s .dotfile/.vim
    ln -s .dotfile/.vimrc
    ln -s .dotfile/.profile
    ln -s .dotfile/.gitconfig

Open vim and do

    :PluginInstall
