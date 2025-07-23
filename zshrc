val "$(oh-my-posh init zsh --config /Users/darkesthj/dev/terminal/pure.omp.json)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
. /opt/homebrew/anaconda3/bin/activate && conda activate /opt/homebrew/anaconda3;
# <<< conda initialize <<<

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"

# Added by LM Studio CLI (lms)
export PATH="$PATH:/Users/darkesthj/.lmstudio/bin"
# The following lines have been added by Docker Desktop to enable Docker CLI completions.
fpath=(/Users/darkesthj/.docker/completions $fpath)
autoload -Uz compinit
compinit
# End of Docker CLI completions

# >>> Added by Spyder >>>
alias uninstall-spyder=/Users/darkesthj/Library/spyder-6/uninstall-spyder.sh
# <<< Added by Spyder <<<

# my aliases
alias eject='diskutil eject /Volumes/T7\ Shield'
alias monitor='python /Users/darkesthj/dev/monitor/monitor.py'
alias updatedb='python /Users/darkesthj/dev/monitor/update_db.py'
alias ping='ping google.com'

push(){
	git add . && git commit -am $1 && git push
}

