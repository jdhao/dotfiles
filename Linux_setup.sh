#!/bin/bash
set -eux
set -o pipefail

# The directory to put all the package tarballs
PACK_DIR=$HOME/packages

#######################################################################
#                            Building Tmux                            #
#######################################################################
echo "Install Tmux"

# First we need to build Tmux dependency packages: libevent and ncurses
# Building libevent
LIBEVENT_SRC_NAME=$PACK_DIR/libevent.tar.gz
LIBEVENT_PACK_DIR=$PACK_DIR/libevent
LIBEVENT_LINK="https://github.com/libevent/libevent/releases/download/release-2.1.12-stable/libevent-2.1.12-stable.tar.gz"

if [[ ! -d "$LIBEVENT_PACK_DIR" ]]; then
    echo "Creating libevent directory under packages directory"
    mkdir -p "$LIBEVENT_PACK_DIR"
fi

if [[ ! -f $LIBEVENT_SRC_NAME ]]; then
    echo "Downloading libevent source files"
    curl -Lo  "$LIBEVENT_SRC_NAME" "$LIBEVENT_LINK"
fi

echo "Building libevent"
echo "Extracting to directory $LIBEVENT_PACK_DIR"

tar zxvf "$LIBEVENT_SRC_NAME" -C "$LIBEVENT_PACK_DIR" --strip-components 1
cd "$LIBEVENT_PACK_DIR"
./configure --prefix="$HOME/local"
make -j && make install
cd "$HOME"

# Building ncurses
NCURSES_SRC_NAME=$PACK_DIR/ncurses.tar.gz
NCURSE_PACK_DIR=$PACK_DIR/ncurses
NCURSES_LINK="https://github.com/mirror/ncurses/archive/refs/tags/v6.4.tar.gz"

if [[ ! -d "$NCURSE_PACK_DIR" ]]; then
    echo "Creating ncurses directory under packages directory"
    mkdir -p "$NCURSE_PACK_DIR"
fi

if [[ ! -f $NCURSES_SRC_NAME ]]; then
    echo "Downloading ncurses source files"
    curl -Lo "$NCURSES_SRC_NAME" "$NCURSES_LINK"
fi

echo "Building ncurses"
echo "Extracting to $PACK_DIR/ncurses directory"
tar zxvf "$NCURSES_SRC_NAME" -C "$NCURSE_PACK_DIR" --strip-components 1
cd "$NCURSE_PACK_DIR"

./configure --prefix="$HOME/local" CXXFLAGS="-fPIC" CFLAGS="-fPIC"
make -j && make install
cd "$HOME"

# Building tmux
TMUX_SRC_NAME=$PACK_DIR/tmux.tar.gz
TMUX_PACK_DIR=$PACK_DIR/tmux
TMUX_LINK="https://github.com/tmux/tmux/releases/download/3.5a/tmux-3.5a.tar.gz"

if [[ ! -d "$TMUX_PACK_DIR" ]]; then
    echo "Creating tmux directory under packages directory"
    mkdir -p "$TMUX_PACK_DIR"
fi

if [[ ! -f $TMUX_SRC_NAME ]]; then
    echo "Downloading tmux source files"
    curl -Lo "$TMUX_SRC_NAME" "$TMUX_LINK"
fi

echo "Building Tmux"
echo "Extracting to directory $TMUX_PACK_DIR"
tar zxvf "$TMUX_SRC_NAME" -C "$TMUX_PACK_DIR" --strip-components 1
cd "$TMUX_PACK_DIR"

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-L$HOME/local/lib"
make -j && make install

cd "$HOME"

#######################################################################
#                                 fd                                  #
#######################################################################
FD_DIR=$HOME/tools/fd
FD_SRC_NAME=$HOME/packages/fd.tar.gz
FD_LINK="https://github.com/sharkdp/fd/releases/download/v10.2.0/fd-v10.2.0-x86_64-unknown-linux-musl.tar.gz"

if [[ -z "$(command -v fd)" ]] && [[ ! -f "$FD_DIR/fd" ]]; then
    echo "Install fd"
    if [[ ! -f $FD_SRC_NAME ]]; then
        echo "Downloading fd and renaming"
        wget $FD_LINK -O "$FD_SRC_NAME"
    fi

    if [[ ! -d "$FD_DIR" ]]; then
        echo "Creating fd directory under tools directory"
        mkdir -p "$FD_DIR"
        echo "Extracting to $HOME/tools/fd directory"
        tar zxvf "$FD_SRC_NAME" -C "$FD_DIR" --strip-components 1
    fi
else
    echo "fd is already installed. Skip installing it."
fi

#######################################################################
#                              Build git                              #
#######################################################################
echo "Installing git"

GIT_SOURCE_NAME=$PACK_DIR/git.tar.gz
GIT_PACK_DIR=$PACK_DIR/git
GIT_LINK="https://github.com/git/git/archive/refs/tags/v2.48.1.tar.gz"

if [[ ! -d "$GIT_PACK_DIR" ]]; then
    echo "Creating git directory under packages directory"
    mkdir -p "$GIT_PACK_DIR"
fi

if [[ ! -f $GIT_SOURCE_NAME ]]; then
    echo "Downloading git source files"
    curl -Lo "$GIT_SOURCE_NAME" "$GIT_LINK"
fi

echo "Building Git"
echo "Extracting to directory $GIT_PACK_DIR"
tar zxvf "$GIT_SOURCE_NAME" -C "$GIT_PACK_DIR" --strip-components 1
cd "$GIT_PACK_DIR"

make configure
./configure --prefix=$HOME/local
make -j && make install
cd "$HOME"

#######################################################################
#                            Building zsh                             #
#######################################################################

echo "Installing zsh"
ZSH_SRC_NAME=$PACK_DIR/zsh.tar.gz
ZSH_PACK_DIR=$PACK_DIR/zsh
ZSH_LINK="https://github.com/zsh-users/zsh/archive/refs/tags/zsh-5.9.tar.gz"

if [[ ! -d "$ZSH_PACK_DIR" ]]; then
    echo "Creating zsh directory under packages directory"
    mkdir -p "$ZSH_PACK_DIR"
fi

if [[ ! -f $ZSH_SRC_NAME ]]; then
    echo "Downloading zsh source files"
    curl -Lo "$ZSH_SRC_NAME" "$ZSH_LINK"
fi

tar zxvf "$ZSH_SRC_NAME" -C "$ZSH_PACK_DIR" --strip-components 1
cd "$ZSH_PACK_DIR"

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include" \
    LDFLAGS="-L$HOME/local/lib"
make -j && make install

cd "$HOME"

#######################################################################
#                             install fzf                             #
#######################################################################
git clone --depth 1 https://github.com/junegunn/fzf.git ~/.fzf
~/.fzf/install

#######################################################################
#                         Install zsh plugins                         #
#######################################################################
# Install zinit
bash -c "$(curl --fail --show-error --silent --location https://raw.githubusercontent.com/zdharma-continuum/zinit/HEAD/scripts/install.sh)"

DOT_FILES_DIR=$HOME/projects/dotfiles
mkdir -p "$DOT_FILES_DIR"

if [[ ! -d "$DOT_FILES_DIR" ]]; then
    git clone --depth 1 https://github.com/jdhao/dotfiles "$DOT_FILES_DIR"
fi

ln -sf  "$DOT_FILES_DIR/.bash_profile" "$HOME/.bash_profile"
ln -sf  "$DOT_FILES_DIR/.zshrc" "$HOME/.zshrc"
ln -sf  "$DOT_FILES_DIR/.pylintrc" "$HOME/.pylintrc"

mkdir -p "$HOME/.tmux"
cp "$DOT_FILES_DIR/tmux/tmux-switch-session.sh" "$HOME/.tmux"
ln -sf  "$DOT_FILES_DIR/tmux/.tmux.conf" "$HOME/.tmux.conf"

# Initialize zsh and install plugins
# shellcheck source=/dev/null
source "$HOME/.bash_profile"
