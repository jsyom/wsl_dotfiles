# History control
# don't use duplicate lines or lines starting with space
HISTCONTROL=ignoreboth
HISTSIZE=1000
HISTFILESIZE=2000
# append to the history file instead of overwrite
shopt -s histappend

# Vim for life
# Personal binaries
export PATH=${PATH}:~/bin:~/.local/bin:~/etc/scripts
export EDITOR=/usr/bin/vim
# Color prompt
export TERM=xterm-256color
# export PATH=$HOME/bin:$PATH
export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad
export LS_COLORS="ow=1;34:di=1;34"
export MYVIMRC=$HOME/.vimrc
export DOTFILES=$HOME/.dotfiles
export LANG='en_US.UTF-8';
export LC_ALL='en_US.UTF-8';
export WINUSER=john.yom.CORP
export WINPATH="/mnt/c/Users/$WINUSER"
export DISPLAY=localhost:0.0

# Aliases
alias winhome="cd $WINPATH"
alias dot="cd ~/.dotfiles"
alias refresh="source ~/.bashrc"
alias cl="clear"
alias cp='cp -rv'
alias ls='ls --color=auto -ACF'
alias ll='ls --color=auto -alF'
alias l="ls -aHF"
alias grep='grep --color=auto'
alias mkdir='mkdir -pv'
alias mv='mv -v'
alias wget='wget -c'
alias v="vim"
# Copy ssh
alias copyssh="clip.exe < ~/.ssh/id_rsa.pub | echo '=> Public key copied to pasteboard.'"
# Easier navigation: .., ..., ...., ....., ~ and -
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias -- -="cd -"

# tmux aliases
alias ta='tmux attach'
alias tls='tmux ls'
alias tat='tmux attach -t'
alias tns='tmux new-session -s'
alias tks='tmux kill-session -t'
alias tka="tmux ls | grep : | cut -d. -f1 | awk '{print substr($1, 0, length($1)-1)}' | xargs kill"
alias ip="dig +short myip.opendns.com @resolver1.opendns.com"
alias localip="ipconfig getifaddr en0"
alias ips="ifconfig -a | grep -o 'inet6\? \(addr:\)\?\s\?\(\(\([0-9]\+\.\)\{3\}[0-9]\+\)\|[a-fA-F0-9:]\+\)' | awk '{ sub(/inet6? (addr:)? ?/, \"\"); print }'"
alias soenv="source venv/bin/activate"

# Show contents of dir after action
# function cd () {
#     builtin cd "$1"
#     ls -ACF
# }

source ~/.git-completion.bash

# 'Safe' version of __git_ps1 to avoid errors on systems that don't have it
function gitPrompt {
  command -v __git_ps1 > /dev/null && __git_ps1 " (%s)"
}

# Colours have names too. Stolen from @tomnomnom who stole it from Arch wiki
txtblk='\[\e[0;30m\]' # Black - Regular
txtred='\[\e[0;31m\]' # Red
txtgrn='\[\e[0;32m\]' # Green
txtylw='\[\e[0;93m\]' # Yellow
txtblu='\[\e[0;34m\]' # Blue
txtpur='\[\e[0;35m\]' # Purple
txtcyn='\[\e[0;96m\]' # Cyan
txtwht='\[\e[0;37m\]' # White
bldblk='\[\e[1;30m\]' # Black - Bold
bldred='\[\e[1;31m\]' # Red
bldgrn='\[\e[1;32m\]' # Green
bldylw='\[\e[1;33m\]' # Yellow
bldblu='\[\e[1;34m\]' # Blue
bldpur='\[\e[1;35m\]' # Purple
bldcyn='\[\e[1;36m\]' # Cyan
bldwht='\[\e[1;37m\]' # White
unkblk='\[\e[4;30m\]' # Black - Underline
undred='\[\e[4;31m\]' # Red
undgrn='\[\e[4;32m\]' # Green
undylw='\[\e[4;33m\]' # Yellow
undblu='\[\e[4;34m\]' # Blue
undpur='\[\e[4;35m\]' # Purple
undcyn='\[\e[4;36m\]' # Cyan
undwht='\[\e[4;37m\]' # White
bakblk='\[\e[40m\]'   # Black - Background
bakred='\[\e[41m\]'   # Red
badgrn='\[\e[42m\]'   # Green
bakylw='\[\e[43m\]'   # Yellow
bakblu='\[\e[44m\]'   # Blue
bakpur='\[\e[45m\]'   # Purple
bakcyn='\[\e[46m\]'   # Cyan
bakwht='\[\e[47m\]'   # White
txtrst='\[\e[0m\]'    # Text Reset

# Prompt colours
atC="${txtpur}"
nameC="${txtblu}"
hostC="${txtpur}"
pathC="${txtcyn}"
gitC="${txtpur}"
pointerC="${txtwht}"
normalC="${txtrst}"

# Red pointer for root
if [ "${UID}" -eq "0" ]; then
    pointerC="${txtred}"
fi

gitBranch() {
    git branch 2> /dev/null | sed -e '/^[^*]/d' -e 's/* \(.*\)/(\1)/'
}

# Patent Pending Prompt
# export PS1="${pathC}\w ${gitC}\$(gitPrompt)${pointerC}▶${normalC} "

export PS1="${pathC}\w ${gitC}\$(gitBranch) ${pointerC}\$${normalC} "

