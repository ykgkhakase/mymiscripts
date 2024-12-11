# increse the number of history.
export HISTSIZE=100000
export HISTFILESIZE=100000
export PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"
shopt -u histappend

# Avoid ^C when pressing Ctrl+C
# and avoiding ssh errors about "stty"
# https://iww.hateblo.jp/entry/20130208/scp
[ -t 0 ] && stty -echoctl

# Unset SSH_ASKPASS to disable GUI-based password prompts and enforce terminal-based authentication. Useful for automation or non-interactive environments where GUI prompts are not available or needed.
unset SSH_ASKPASS