#!/bin/bash
set -eux
set -o pipefail

#######################################################################
#                            Building Tmux                            #
#######################################################################
echo "Install Tmux"

# First we need to build Tmux dependency packages: libevent and ncurses
# Building libevent
LIBEVENT_SRC_NAME=$HOME/packages/libevent.tar.gz
LIBEVENT_PACK_DIR=$HOME/packages/libevent
LIBEVENT_LINK="https://github.com/libevent/libevent/releases/download/release-2.1.10-stable/libevent-2.1.10-stable.tar.gz"

if [[ ! -d "$LIBEVENT_PACK_DIR" ]]; then
    echo "Creating libevent directory under packages directory"
    mkdir -p "$LIBEVENT_PACK_DIR"
fi

if [[ ! -f $LIBEVENT_SRC_NAME ]]; then
    echo "Downloading libevent source files"
    curl -Lo  "$LIBEVENT_SRC_NAME" "$LIBEVENT_LINK"
fi

echo "Building libevent"
echo "Extracting to directory $HOME/packages/libevent"

tar zxvf "$LIBEVENT_SRC_NAME" -C "$LIBEVENT_PACK_DIR" --strip-components 1
cd "$LIBEVENT_PACK_DIR"
./configure --prefix="$HOME/local"
make -j && make install
cd "$HOME"

# Building ncurses
NCURSES_SRC_NAME=$HOME/packages/ncurses.tar.gz
NCURSE_PACK_DIR=$HOME/packages/ncurses
NCURSES_LINK="https://ftp.gnu.org/pub/gnu/ncurses/ncurses-6.1.tar.gz"

if [[ ! -d "$NCURSE_PACK_DIR" ]]; then
    echo "Creating ncurses directory under packages directory"
    mkdir -p "$NCURSE_PACK_DIR"
fi

if [[ ! -f $NCURSES_SRC_NAME ]]; then
    curl -Lo "$NCURSES_SRC_NAME" "$NCURSES_LINK"
fi

echo "Building ncurses"
echo "Extracting to $HOME/packages/ncurses directory"
tar zxvf "$NCURSES_SRC_NAME" -C "$NCURSE_PACK_DIR" --strip-components 1
cd "$NCURSE_PACK_DIR"

./configure --prefix="$HOME/local" CXXFLAGS="-fPIC" CFLAGS="-fPIC"
make -j && make install
cd "$HOME"

# Building tmux
TMUX_SRC_NAME=$HOME/packages/tmux.tar.gz
TMUX_PACK_DIR=$HOME/packages/tmux
TMUX_LINK="https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz"

if [[ ! -d "$TMUX_PACK_DIR" ]]; then
    echo "Creating tmux directory under packages directory"
    mkdir -p "$TMUX_PACK_DIR"
fi

if [[ ! -f $TMUX_SRC_NAME ]]; then
    curl -Lo "$TMUX_SRC_NAME" "$TMUX_LINK"
fi

echo "Building Tmux"
echo "Extracting to $HOME/packages/tmux directory"
tar zxvf "$TMUX_SRC_NAME" -C "$TMUX_PACK_DIR" --strip-components 1
cd "$TMUX_PACK_DIR"

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-L$HOME/local/lib"
    make -j && make install

cd "$HOME"

#######################################################################
#                            Building zsh                             #
#######################################################################

echo "Installing zsh"
ZSH_SRC_NAME=$HOME/packages/zsh.tar.xz
ZSH_PACK_DIR=$HOME/packages/zsh
ZSH_LINK="https://sourceforge.net/projects/zsh/files/latest/download"

if [[ ! -d "$ZSH_PACK_DIR" ]]; then
    echo "Creating zsh directory under packages directory"
    mkdir -p "$ZSH_PACK_DIR"
fi

if [[ ! -f $ZSH_SRC_NAME ]]; then
    curl -Lo "$ZSH_SRC_NAME" "$ZSH_LINK"
fi

tar xJvf "$ZSH_SRC_NAME" -C "$ZSH_PACK_DIR" --strip-components 1
cd "$ZSH_PACK_DIR"

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include" \
    LDFLAGS="-L$HOME/local/lib"
make -j && make install

cd "$HOME"

#######################################################################
#                         Install zsh plugins                         #
#######################################################################
# Install zinit
mkdir ~/.zinit
git clone --depth 1 https://github.com/zdharma/zinit.git ~/.zinit/bin

DOT_FILES_DIR=$HOME/projects/dotfiles
mkdir -p "$DOT_FILES_DIR"

if [[ ! -d "$DOT_FILES_DIR" ]]; then
    git clone https://github.com/jdhao/dotfiles "$DOT_FILES_DIR"
fi

ln -sf  "$DOT_FILES_DIR/.bash_profile" "$HOME/.bash_profile"
ln -sf  "$DOT_FILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf  "$DOT_FILES_DIR/.pylintrc" "$HOME/.pylintrc"
ln -sf  "$DOT_FILES_DIR/.tmux.conf" "$HOME/.tmux.conf"

# Initialize zsh and install plugins
# shellcheck source=/dev/null
source "$HOME/.bash_profile"
