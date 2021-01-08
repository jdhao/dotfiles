export PATH=$HOME/local/bin:$PATH
export SHELL=`which zsh`
[ -f "$SHELL" ] && exec "$SHELL" -l

# Get the aliases and functions
if [ -f ~/.bashrc ]; then
	. ~/.bashrc
fi
