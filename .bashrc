# Check for an interactive session
[ -z "$PS1" ] && return


# Welcome message 
echo -ne "Good Morning,OESPIRIT!. It's "; date '+%A, %B %-d %Y'
uptime


SHELL_FILES=$HOME/dotfiles/shell
source $SHELL_FILES/alias.sh
source $SHELL_FILES/default.sh
source $SHELL_FILES/export.sh
source $SHELL_FILES/function.sh
source $SHELL_FILES/prompt.sh
