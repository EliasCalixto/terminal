eval "$(oh-my-posh init zsh --config /Users/darkesthj/dev/terminal/pure.omp.json)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
. /opt/homebrew/anaconda3/bin/activate && conda activate /opt/homebrew/anaconda3;
# <<< conda initialize <<<

# bun
export BUN_INSTALL="$HOME/Library/Application Support/reflex/bun"
export PATH="$BUN_INSTALL/bin:$PATH"
export PATH="/opt/homebrew/opt/node@20/bin:$PATH"
