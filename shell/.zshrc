# Path to your oh-my-zsh installation.
export ZSH="$HOME/.oh-my-zsh"

# Set name of the theme to load --- if set to "random", it will
# load a random theme each time oh-my-zsh is loaded, in which case,
# to know which specific one was loaded, run: echo $RANDOM_THEME
# See https://github.com/robbyrussell/oh-my-zsh/wiki/Themes

# to use random theme, enable the following option
ZSH_THEME="random"

# Set list of themes to pick from when loading at random
# Setting this variable when ZSH_THEME=random will cause zsh to load
# a theme from this variable instead of looking in ~/.oh-my-zsh/themes/
# If set to an empty array, this variable will have no effect.
ZSH_THEME_RANDOM_CANDIDATES=( "bira" "xiong-chiamiov" "crcandy"
    "dst" "strug" "steeef" "tjkirch" "amuse"
)

# Uncomment the following line to use case-sensitive completion.
# CASE_SENSITIVE="true"

# Uncomment the following line to use hyphen-insensitive completion.
# Case-sensitive completion must be off. _ and - will be interchangeable.
# HYPHEN_INSENSITIVE="true"

# Uncomment the following line to disable bi-weekly auto-update checks.
DISABLE_AUTO_UPDATE="true"

# Uncomment the following line to change how often to auto-update (in days).
export UPDATE_ZSH_DAYS=30

# Uncomment the following line to disable colors in ls.
# DISABLE_LS_COLORS="true"

# Uncomment the following line to disable auto-setting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment the following line to enable command auto-correction.
ENABLE_CORRECTION="true"

# Uncomment the following line to display red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"

# Uncomment the following line if you want to disable marking untracked files
# under VCS as dirty. This makes repository status check for large repositories
# much, much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Uncomment the following line if you want to change the command execution time
# stamp shown in the history command output.
# You can set one of the optional three formats:
# "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
# or set a custom format using the strftime function format specifications,
# see 'man strftime' for details.
# HIST_STAMPS="mm/dd/yyyy"

# Would you like to use another custom folder than $ZSH/custom?
# ZSH_CUSTOM=/path/to/new-custom-folder

#######################################################################
#                         fzf configurations                          #
#######################################################################

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

export FZF_BASE="$HOME/.fzf"
export FZF_DEFAULT_OPTS='--height 40% --reverse --border'

#######################################################################
#               oh-my-zsh builtin plugins configuration               #
#######################################################################

# Which plugins would you like to load?
# Standard plugins can be found in ~/.oh-my-zsh/plugins/*
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
# Add wisely, as too many plugins slow down shell startup.
plugins=(
  git pip fzf command-not-found cp colored-man-pages
)

source $ZSH/oh-my-zsh.sh

#######################################################################
#                        zplug configurations                         #
#######################################################################

source ~/.zplug/init.zsh

# zplug "supercrabtree/k"

# enhanced zsh vim mode
zplug "softmoth/zsh-vim-mode"

# smart jump to other directories
# zplug "skywind3000/z.lua"

# configuration for theme pure
# zplug "mafredri/zsh-async", from:github
# zplug "sindresorhus/pure", use:pure.zsh, from:github, as:theme

# command auto-suggestion based on history
zplug "zsh-users/zsh-autosuggestions"

# Syntax highlighting bundle, load it after other plugin
zplug "zdharma/fast-syntax-highlighting", defer:2

# automatch pairs
zplug "hlissner/zsh-autopair", defer:2

# turn screen to matrix
# zplug "amstrad/oh-my-matrix"

# Then, source plugins and add commands to $PATH
zplug load

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

# z.lua configuration
export _ZL_MATCH_MODE=1  # enhanced matching mode
export _ZL_ECHO=1  # echo the path after cd
export _ZL_ADD_ONCE=1  # only add path if the pwd is changed

# alias for z.lua
alias zi="z -i"  # interactive selection
alias zb="z -b"  # jump backward

#######################################################################
#                        custom configurations                        #
#######################################################################

# User configuration
#display welcome message
echo "Welcome! jdhao"
echo "Today is `date` "
echo
#system information
echo "System uptime:"; uptime
echo

# You may need to manually set your language environment
export LANG=en_US.UTF-8
# User specific environment and startup programs
export LC_ALL="en_US.UTF-8"
export WARP_CTC_PATH="$HOME/tools/warp-ctc/build"
export LD_LIBRARY_PATH="$HOME/local/lib:$LD_LIBRARY_PATH"
export LD_LIBRARY_PATH="$HOME/tools/anaconda3/lib:$LD_LIBRARY_PATH"
export PATH="$HOME/tools/nvim/bin:$PATH"
export PATH="$HOME/local/bin:$PATH"
export PATH="$HOME/tools/anaconda3/bin:$PATH"
export PATH="$HOME/tools/ripgrep-0.10.0-x86_64-unknown-linux-musl:$PATH"
export MYVIMRC=$HOME/.config/nvim/init.vim

export HISTSIZE=1000
export VISUAL=vi
export PAGER=less
export LC_COLLATE=C
export LESS='-RMs'

# Compilation flags
# export ARCHFLAGS="-arch x86_64"

# Set personal aliases, overriding those provided by oh-my-zsh libs,
# plugins, and themes. Aliases can be placed here, though oh-my-zsh
# users are encouraged to define aliases within the ZSH_CUSTOM folder.
# For a full list of active aliases, run `alias`.
#
alias zshconfig="nvim ~/.zshrc"
alias h="history"
alias r="fc -s"
alias grep="grep -E -n --color=auto"
alias ls='ls -F --color=auto'
alias less="less -m"
alias hexdump='hexdump -C'
alias ll="ls -l --color=auto"
alias ldot='ls -d .??*'
alias cp='cp -i'
alias mv='mv -i'
alias cls="clear"

#set the PERMISSIONS for newly-created files
umask 077

# this value can not be too low, or it will break the surround object of
# plugin zsh-vim-mode, see https://github.com/zsh-users/zsh-autosuggestions/issues/254
export KEYTIMEOUT=30

#######################################################################
#                        key binding settings                         #
#######################################################################
# use vim key binding instead of the default emacs key binding
# bindkey -v

# for terminal which can not understand home and end key on zsh shell
# https://anjia0532.github.io/2017/09/10/zsh-home-end-keypad-not-work/
bindkey '^[[H' beginning-of-line
bindkey '^[[F' end-of-line

#######################################################################
#                          custom functions                           #
#######################################################################
# create a directory and go to it
mkcd ()
{
    mkdir -p -- "$1" &&
      cd -P -- "$1"
}
