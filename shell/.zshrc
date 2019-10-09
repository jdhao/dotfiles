#######################################################################
#                        zplug configurations                         #
#######################################################################
source "$HOME/.zplugin/bin/zplugin.zsh"
autoload -Uz _zplugin
(( ${+_comps} )) && _comps[zplugin]=_zplugin

# git.zsh is required by some omz plugins
# zplugin ice wait lucid
# zplugin snippet OMZ::lib/git.zsh

# Install a OMZ plugin with multiple files
# zplugin ice svn lucid
# zplugin snippet OMZ::plugins/pip

# pure theme
zplugin ice pick"async.zsh" src"pure.zsh"
zplugin light sindresorhus/pure

# zplugin load skywind3000/z.lua
zplugin load softmoth/zsh-vim-mode
zplugin load zsh-users/zsh-autosuggestions
zplugin load zdharma/fast-syntax-highlighting

#######################################################################
#                           Plugin settings                           #
#######################################################################

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

#######################################################################
#                         fzf configurations                          #
#######################################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

#######################################################################
#                        Environment variables                        #
#######################################################################

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# User specific environment and startup programs
export LC_ALL="en_US.UTF-8"

export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/tools/anaconda/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/tools/anaconda/bin:$PATH"
export PATH="$HOME/tools/ctags/bin:$PATH"
export PATH="$HOME/tools/nvim/bin:$PATH"
export PATH="$HOME/tools/ripgrep:$PATH"
export PATH="$HOME/local/bin:$PATH"

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

export KEYTIMEOUT=30

#######################################################################
#                            custom alias                             #
#######################################################################

alias zshconfig="nvim ~/.zshrc"
alias h="history"
alias r="fc -s"
alias grep="grep -E -n --color=auto"
alias ls='ls -F --color=auto'
alias less="less -m"
alias hexdump='hexdump -C'
alias ll="ls -l --color=auto"
alias ldot='ls -d .??*'
alias cp='nocorrect cp -i'
alias mv='nocorrect mv -i'
alias cls="clear"

#set the PERMISSIONS for newly-created files
umask 077

#######################################################################
#                        key binding settings                         #
#######################################################################
# use vim key binding instead of the default emacs key binding
# bindkey -v

# for terminal which can not understand home and end key on zsh shell
# https://anjia0532.github.io/2017/09/10/zsh-home-end-keypad-not-work/
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line
