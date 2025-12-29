#
# ~/.bash_profile
#

[[ -f ~/.bashrc ]] && . ~/.bashrc

# source ~/.profile
[[ -f ~/.profile ]] && . ~/.profile

# start tmux automatically on login
command -v tmux >/dev/null 2>&1 && \
[ -z "$TMUX" ] && \
[ -z "$SSH_TTY" ] && \
exec tmux new -A -s main
