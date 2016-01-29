Start with:

    git clone --recursive git@github.com:dsem/.dotfile.git

then 

    ln -s .dotfile/.vim
    ln -s .dotfile/.vimrc
    ln -s .dotfile/.profile
    cp .dotfile/.gitconfig . # then add email

Open vim and do

    :PluginInstall

Install ruby-devel

Make the command-t binaries

    cd .vim/bundle/command-t/ruby/command-t
    ruby extconf.rb
    make
