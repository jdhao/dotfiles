#######################################################################
#                          General settings                           #
#######################################################################
# Enable autocompletion
autoload -Uz compinit

# case insensitive completion
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

#set the PERMISSIONS for newly-created files
umask 077

#######################################################################
#                        zinit configurations                         #
#######################################################################
source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# git.zsh is required by some omz plugins
# zinit ice wait lucid
# zinit snippet OMZ::lib/git.zsh

# Install a OMZ plugin with multiple files
# zinit ice svn lucid
# zinit snippet OMZ::plugins/pip

zinit ice as"completion"
zinit snippet OMZ::plugins/docker/_docker

# pure theme
zinit ice compile'(pure|async).zsh' pick'async.zsh' src'pure.zsh'
zinit light sindresorhus/pure

# spaceship theme
# zinit ice depth'1'
# zinit light denysdovhan/spaceship-prompt

# zinit light skywind3000/z.lua

zinit light softmoth/zsh-vim-mode

zinit ice wait lucid atload'_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice wait lucid
zinit load zdharma-continuum/fast-syntax-highlighting

zinit load MichaelAquilina/zsh-auto-notify

#######################################################################
#                           Plugin settings                           #
#######################################################################

# tweak the pure theme
zstyle :prompt:pure:path color "green"

# tweak spaceship theme
SPACESHIP_USER_SHOW=needed
SPACESHIP_VI_MODE_SHOW=false

# cursor configurations for zsh-vim-mode
MODE_CURSOR_VICMD="green block"
MODE_CURSOR_VIINS="#20d08a blinking bar"
MODE_CURSOR_SEARCH="#ff00ff blinking underline"

# mode configuration for zsh-vim-mode, shown on the right (RPS1 stuff)
MODE_INDICATOR_VIINS='%F{15}<%F{8}INSERT<%f'
MODE_INDICATOR_VICMD='%F{10}<%F{2}NORMAL<%f'
MODE_INDICATOR_REPLACE='%F{9}<%F{1}REPLACE<%f'
MODE_INDICATOR_SEARCH='%F{13}<%F{5}SEARCH<%f'
MODE_INDICATOR_VISUAL='%F{12}<%F{4}VISUAL<%f'
MODE_INDICATOR_VLINE='%F{12}<%F{4}V-LINE<%f'

# Make it work with your existing RPS1 if it is set. Note the single quotes
setopt PROMPT_SUBST
RPS1='${MODE_INDICATOR_PROMPT} ${vcs_info_msg_0_}'

# configuration for zsh-auto-notify
export AUTO_NOTIFY_THRESHOLD=20


#######################################################################
#                         fzf configurations                          #
#######################################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

export PATH="$HOME/.fzf/bin:$PATH"
#######################################################################
#                        Environment variables                        #
#######################################################################

# -M: verbose mode
# -N: show line number
# -s: squeeze blank lines to single blank line
export LESS='-RMs'
export PAGER=less
export VISUAL=vi
export LC_COLLATE='C'
export LC_ALL="en_US.UTF-8"
export LANG=en_US.UTF-8
export KEYTIMEOUT=30

if [ -d $HOME/tools/anaconda ]; then
    CONDA_NAME="anaconda"
fi

if [ -d $HOME/tools/miniconda ]; then
    CONDA_NAME="miniconda"
fi

if [-z "$LD_LIBRARY_PATH"]; then
  export LD_LIBRARY_PATH="$HOME/tools/$CONDA_NAME/lib"
else
  export LD_LIBRARY_PATH="$HOME/tools/$CONDA_NAME/lib:$LD_LIBRARY_PATH"
fi
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"

export PATH="$HOME/tools/$CONDA_NAME/bin:$PATH"
export PATH="$HOME/tools/ctags/bin:$PATH"
export PATH="$HOME/tools/nvim/bin:$PATH"
export PATH="$HOME/tools/ripgrep:$PATH"
export PATH="$HOME/tools/fd:$PATH"
export PATH="$HOME/local/bin:$PATH"

# use nvim as man pager
if [[ "$(command -v nvim)" ]]; then
    export EDITOR='nvim'
    export MANPAGER='nvim +Man!'
    export MANWIDTH=999
fi

setopt noclobber  # Do not overwrite existing files by default
setopt autocd  # cd to a directory if only name is provided
setopt correct_all  # correct misspelled command

export HISTFILE=~/.histfile
export HISTSIZE=1000000
export SAVEHIST=1000000

setopt HIST_IGNORE_ALL_DUPS  # do not put duplicated command into history list
setopt HIST_SAVE_NO_DUPS  # do not save duplicated command
setopt HIST_REDUCE_BLANKS  # remove unnecessary blanks
setopt INC_APPEND_HISTORY_TIME  # append command to history file immediately after execution
setopt EXTENDED_HISTORY  # record command start time

alias history="fc -l 1"
# below alias taken from https://github.com/zimfw/history/blob/master/init.zsh
alias history-stat="fc -ln 0 | awk '{print \$1}' | sort | uniq -c | sort -nr | head"

#######################################################################
#                            custom alias                             #
#######################################################################
alias zshconfig="nvim ~/.zshrc"
alias grep="grep -E -n --color=auto"
alias ls='ls -F --color=auto'
alias less="less -m"
alias hexdump='hexdump -C'
alias ll="ls -l --color=auto"
alias ldot='ls -d .??*'
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias cls="clear"

#######################################################################
#                        key binding settings                         #
#######################################################################
# Use vim key binding instead of the default emacs key binding
# bindkey -v

# For terminal which can not understand home and end key on zsh shell
# https://anjia0532.github.io/2017/09/10/zsh-home-end-keypad-not-work/
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

#######################################################################
#                          custom functions                           #
#######################################################################

mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}

# Note that we need to use compinit command after we add new completions to
# some command or update the completion behavior. Instead of running the
# command multiple times, running it at the end of the zshrc seems okay.
compinit
