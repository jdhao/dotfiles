
# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific aliases and function
#alias
alias h=history
alias r="fc -s"
alias grep="grep -E -i -n  --color=auto"
alias less="less -m"
alias hexdump='hexdump -C'
alias exit="logout"
alias ldot='ls -d .??*'
alias cp='cp -i'
alias mv='mv -i'

#shell options
set -o ignoreeof
set +o noclobber
set +o notify
shopt -s extglob

