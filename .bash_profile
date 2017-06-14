# .bash_profile

#Environment virables
export PATH="${HOME}/util/anaconda3/bin:${PATH}"

export HISTSIZE=50
export VISUAL=vi
export PAGER=less 
export LC_COLLATE=C
export LESS='-MNs'

#set the shell prompt
export PS1='[\w]$ '

export PYTHONPATH=/home/jdhao/util/mxnet/python:$PYTHONPATH

#set the PERMISSIONS for newly-created files
umask 077

#display welcome message
echo "Welcome! Jiedong"
echo "Today is `date` "
echo 

#system information
echo "Last three logins:"; last `logname` |head -3
echo 
echo "Current users: `users`"
echo
echo "System uptime:"; uptime
echo

# Environment file
if [ -f ${HOME}/.bashrc ]; then
	source ${HOME}/.bashrc
fi

