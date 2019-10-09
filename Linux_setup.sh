#######################################################################
#                            Building Tmux                            #
#######################################################################

echo "Install Tmux"

# First we need to build Tmux dependency packages: libevent and ncurses
# Building libevent
LIBEVENT_SRC_NAME=$HOME/packages/libevent.tar.gz
LIBEVENT_PACK_DIR=$HOME/packages/libevent
LIBEVENT_LINK="https://github.com/libevent/libevent/releases/download/release-2.1.10-stable/libevent-2.1.10-stable.tar.gz"

if [ ! -f $LIBEVENT_SRC_NAME ]; then
    wget $LIBEVENT_LINK -O $LIBEVENT_SRC_NAME
fi

echo "Building libevent"
echo "Creating libevent directory under packages directory"
if [ ! -d "$LIBEVENT_PACK_DIR" ]; then
    mkdir -p "$LIBEVENT_PACK_DIR"
fi

echo "Extracting to $HOME/packages/libevent directory"
tar zxvf $LIBEVENT_SRC_NAME -C $LIBEVENT_PACK_DIR --strip-components 1
cd $LIBEVENT_PACK_DIR

./configure --prefix="$HOME/local"
make -j$(nproc) && make install
cd $HOME

# Building ncurses
NCURSES_SRC_NAME=$HOME/packages/ncurses.tar.gz
NCURSE_PACK_DIR=$HOME/packages/ncurses
NCURSES_LINK="ftp://ftp.gnu.org/gnu/ncurses/ncurses-6.1.tar.gz"

if [ ! -f $NCURSES_SRC_NAME ]; then
    wget $NCURSES_LINK -O $NCURSES_SRC_NAME
fi

echo "Building ncurses"
echo "Creating ncurses directory under packages directory"
if [ ! -d "$NCURSE_PACK_DIR" ]; then
    mkdir -p "$NCURSE_PACK_DIR"
fi

echo "Extracting to $HOME/packages/ncurses directory"
tar zxvf $NCURSES_SRC_NAME -C $NCURSE_PACK_DIR --strip-components 1
cd $NCURSE_PACK_DIR

./configure --prefix="$HOME/local" CXXFLAGS="-fPIC" CFLAGS="-fPIC"
make -j$(nproc) && make install
cd $HOME

# Building tmux
TMUX_SRC_NAME=$HOME/packages/tmux.tar.gz
TMUX_PACK_DIR=$HOME/packages/tmux
TMUX_LINK="https://github.com/tmux/tmux/releases/download/2.8/tmux-2.8.tar.gz"

if [ ! -f $TMUX_SRC_NAME ]; then
    wget $TMUX_LINK -O $TMUX_SRC_NAME
fi

echo "Building Tmux"
echo "Creating tmux directory under packages directory"
if [ ! -d "$TMUX_PACK_DIR" ]; then
    mkdir -p "$TMUX_PACK_DIR"
fi

echo "Extracting to $HOME/packages/tmux directory"
tar zxvf $TMUX_SRC_NAME -C $TMUX_PACK_DIR --strip-components 1
cd $TMUX_PACK_DIR

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include -I$HOME/local/include/ncurses" \
    LDFLAGS="-L$HOME/local/lib"
    make -j$(nproc) && make install

cd $HOME

#######################################################################
#                            Building zsh                             #
#######################################################################

echo "Installing zsh"
ZSH_SRC_NAME=$HOME/packages/zsh.tar.xz
ZSH_PACK_DIR=$HOME/packages/zsh
ZSH_LINK="https://sourceforge.net/projects/zsh/files/latest/download"

if [ ! -f $ZSH_SRC_NAME ]; then
    wget $ZSH_LINK -O $ZSH_SRC_NAME
fi

echo "Creating zsh directory under packages directory"
if [ ! -d "$ZSH_PACK_DIR" ]; then
    mkdir -p "$ZSH_PACK_DIR"
fi

tar xJvf $ZSH_SRC_NAME -C $ZSH_PACK_DIR --strip-components 1
cd $ZSH_PACK_DIR

./configure --prefix="$HOME/local" \
    CPPFLAGS="-I$HOME/local/include" \
    LDFLAGS="-L$HOME/local/lib"
make -j$(nproc) && make install

cd $HOME

#######################################################################
#                         Install zsh plugins                         #
#######################################################################

# Install zplugin
sh -c "$(curl -fsSL https://raw.githubusercontent.com/zdharma/zplugin/master/doc/install.sh)"

# Download rc files
curl -Lo $HOME/.bash_profile https://raw.githubusercontent.com/jdhao/dotfiles/master/shell/.bash_profile \
    && curl -Lo $HOME/.zshrc https://raw.githubusercontent.com/jdhao/dotfiles/master/shell/.zshrc \
    && curl -Lo $HOME/.pylintrc https://raw.githubusercontent.com/jdhao/dotfiles/master/pylint/.pylintrc

# Initialize zsh and install plugins
source $HOME/.bash_profile
