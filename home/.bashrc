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

# fake user firefox on links
alias links-ff='links -http.fake-user-agent "Mozilla/5.0 (X11; Linux x86_64) Gecko Firefox/120.0"'

# add asdf shims and bin to PATH
export PATH="$HOME/.asdf/shims:$HOME/.asdf/bin:$PATH"
