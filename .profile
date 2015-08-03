# ~/.profile: executed by the command interpreter for login shells.
# This file is not read by bash(1), if ~/.bash_profile or ~/.bash_login
# exists.
# see /usr/share/doc/bash/examples/startup-files for examples.
# the files are located in the bash-doc package.

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# if running bash
if [ -n "$BASH_VERSION" ]; then
    # include .bashrc if it exists
    if [ -f "$HOME/.bashrc" ]; then
	. "$HOME/.bashrc"
    fi
fi

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/bin" ] ; then
    PATH="$HOME/bin:$PATH:/usr/local/phantom-fix/phantomjs/bin"
fi

export WORKON_HOME=$HOME/.virtualenvs

alias ll='ls -l'

# Only load Liquid Prompt in interactive shells, not from a script or from scp
[[ $- = *i*  ]] && source ~/liquidprompt/liquidprompt

# Add django bash completion
. $HOME/.dotfile/django_bash_completion.sh