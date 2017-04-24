# .bash_profile

#Environment virables
export PATH="${PATH}:${HOME}/local/clion-1.2.2/bin/:${HOME}/local/caffe-201607/build/tools"
export PATH="${HOME}/anaconda2/bin:${PATH}"
export PATH="/usr/local/texlive/2015/bin/x86_64-linux:${PATH}"

export LD_LIBRARY_PATH="/usr/local/cuda/lib64:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="/usr/local/cudnn-v5/lib64:$LD_LIBRARY_PATH"
export PYTHONPATH="${HOME}/local/caffe-201607/python:$PYTHONPATH"
export PYTHONPATH="${HOME}/mxnet/python:$PYTHONPATH"
export PYTHONPATH="$HOME/PycharmProjects/cnn_image_retrieval:$PYTHONPATH"


export CPLUS_INCLUDE_PATH=".:${HOME}/document/ppp_cpp/support"
export CUDA_HOME=/usr/local/cuda

export MYVIMRC=${HOME}/.vimrc
export HISTSIZE=50
export VISUAL=vi
export PAGER=less 
export LC_COLLATE=C
export LESS='-MNs'
export VIMRUNTIME=/usr/share/vim/vim74

#set the shell prompt
export PS1='[\w]$ '

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

