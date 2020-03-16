#!/usr/bin/env bash
# Setup command line environment and tools

# Command to download and execute bootstrap.sh script
# /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/luojxxx/dotfiles/master/bootstrap.sh)"

PACKAGES="gcc git tmux tree nnn broot ripgrep fzf ack"
IFS=' ' read -r -a package_array <<< "$PACKAGES"

# If MacOS
if [ "$(uname)" == "Darwin" ]; then
	# Install homebrew
	/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)" 

	# Install formulae
	for pkg in "${package_array[@]}"
	do
		brew install "$pkg"
	done

# If Linux
elif [ "$(expr substr $(uname -s) 1 5)" == "Linux" ]; then
	# Install packages
	for pkg in "${package_array[@]}"
	do
		sudo apt install "$pkg"
	done
fi

# Common installation steps
# Clone repo with dotfiles
git clone https://github.com/luojxxx/dotfiles.git ~/.dotfiles

# Setup symlinks
ln -s ~/.dotfiles/.bashrc ~/.bashrc
ln -s ~/.dotfiles/.vimrc ~/.vimcrc
ln -s ~/.dotfiles/.tmux.conf ~/.tmux.conf

# Install Vundle package manager for Vim packages
git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

