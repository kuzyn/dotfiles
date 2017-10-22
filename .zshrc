# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=1000
SAVEHIST=1000
setopt APPEND_HISTORY HIST_IGNORE_ALL_DUPS

bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/kuzyn/.zshrc'

autoload -Uz compinit
compinit
# End of lines added by compinstall

###
### kuzyn stuff
###

# Aliases
alias ls='ls -lh --color=auto'
alias vim='nvim'
alias stats='archey3'
alias lsa='ls -lah'
alias chrome='google-chrome-stable'
alias md='grip -b'
alias gl='git log --oneline -n10'
alias gb='git branch --all'
alias ws='sudo netctl stop-all'
alias ww='ws; sudo netctl start wlp3s0-LighthouseFibre'
alias wh='ws; sudo netctl start wlp3s0-mableybabelies'
alias sz='source ~/.zshrc'
alias ev='nvim ~/.config/nvim/init.vim'
alias ei3='nvim ~/.config/i3/config'
alias screen='xrandr --output VGA1 --right-of LVDS1 --auto --rotate left'
alias ez='nvim ~/.zshrc'
alias cat='pygmentize -g'

# Prompt
PS1='%B%F{210}%n(λ)%M%f%b%F{224}‡ %f%b'


# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; 
  then source '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; 
  then source '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi
