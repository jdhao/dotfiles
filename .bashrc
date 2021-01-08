# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi


################  shell options ############################

# forbid the use of ctrl + d to logout the login shell
# see  https://goo.gl/nUCd8o 
set -o ignoreeof

# keep you from accidentally overwrite existing files
# see https://www.cs.ait.ac.th/~on/O/oreilly/unix/upt/ch13_06.htm
set -o noclobber

# do not get immediate notification of background job termination
set +o notify

[ -f ~/.fzf.bash ] && source ~/.fzf.bash
