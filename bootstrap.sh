#!/usr/bin/env bash
# Setup command line environment and tools

# Command to download and execute bootstrap.sh script
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/luojxxx/dotfiles/master/bootstrap.sh)"

PACKAGES="gcc git tmux tldr tree nnn ripgrep fzf ack rsync htop python3 pipenv node yarn prettier eslint yapf"
IFS=' ' read -r -a pkgs <<< "$PACKAGES"

# Install homebrew
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

# If MacOS
if [ "$(uname)" == "Darwin" ]; then
  echo "MacOS nothing special"

# If Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	test -d ~/.linuxbrew && eval $(~/.linuxbrew/bin/brew shellenv)
	test -d /home/linuxbrew/.linuxbrew && eval $(/home/linuxbrew/.linuxbrew/bin/brew shellenv)
	test -r ~/.bash_profile && echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.bash_profile
	echo "eval \$($(brew --prefix)/bin/brew shellenv)" >>~/.profile
fi

# Install packages
for pkg in "${pkgs[@]}"
do
	brew install "$pkg"	
done

# Common installation steps
# Clone repo with dotfiles
git clone https://github.com/luojxxx/dotfiles.git ~/.dotfiles

# Setup symlinks
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.vimrc ~/.vimrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Install Vundle package manager for Vim packages
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
# Post installation you'll need to run :PluginInstall within vim or :PluginClean to remove plugins

# Install Tmux plugin manager
git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
# Post installation you'll need to run prefix+I to install the plugin or prefix+alt+u to remove plugin

# Create vim ftplugin folder and add files
mkdir ~/.vim/ftplugin
echo "let b:ale_fixers = ['prettier', 'eslint']" > ~/.vim/ftplugin/javascript.vim
echo "let b:ale_fixers = ['yapf']" > ~/.vim/ftplugin/python.vim
