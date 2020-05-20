# Reset
Color_Off='\e[0m'       # Text Reset
# Prompt
export PS1="[\u@\h \W]\$ "

# Colorize ls
export LS_OPTIONS='--color=auto'
export LS_COLORS="$LS_COLORS:di=00;33"

export TERM=xterm

alias ls='ls $LS_OPTIONS'
alias ll='ls $LS_OPTIONS -la'
alias l='ls $LS_OPTIONS -lA'


