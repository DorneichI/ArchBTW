#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
alias grep='grep --color=auto'
PS1='[\u@\h \W]\$ '

# run fastfetch
command -v fastfetch >/dev/null 2>&1 && fastfetch

# force myself to use neovim
alias nano='nvim'
