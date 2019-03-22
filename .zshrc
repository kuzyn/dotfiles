# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

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

eval "$(dircolors ~/.dircolors)"

###########
# HELPERS #
###########

# adds a path to another
_append_to_path() {
        if [ -d $1 -a -z ${path[(r)$1]} ]; then
                path=($1 $path);
        fi
}

# Returns whether the given command is executable or aliased.
_has() {
        return $( whence $1 >/dev/null )
}

###########
###########
###########

# Overrides
alias diff='diff --color=auto'
alias ls='ls --color=auto'
alias lsa='ls -lha'
alias mkdir='mkdir -p'
alias ssh='TERM=xterm ssh'
alias vim='nvim'
alias vi='nvim'
alias grep='ag'
alias wifi-menu='ws; wifi-menu'

# Dotfiles
alias ei3='nvim ~/.config/i3/config'
alias ev='nvim ~/.config/nvim/init.vim'
alias ez='nvim ~/.zshrc'

# System helpers
alias br='sudo systemctl restart bluetooth'
alias cmus-reload-lib="dir ~/tammy/music/*/*.mp3 -R -1 --quoting-style=literal > ~/tammy/music/library.m3u"
alias fetch-music='rsync -avzuP samuelcousin.com:~/downloads/completed/ ~/tammy/music/; cmus-reload-lib'
alias rb='sudo systemctl restart bluetooth'
alias scan='bash ~/.config/scripts/scan.sh'
alias screen-rotate='xrandr --output VGA1 --auto --right-of LVDS1 --auto --rotate left'
alias stats='neofetch'
alias wd='sudo netctl stop-all; sudo systemctl start NetworkManager'
alias wh='ws; sudo netctl start wlp3s0-CHATEAU_BURLINGTON'
alias pulse-restart='pulseaudio -k; pulseaudio -D'
alias ws='sudo netctl stop-all; sudo systemctl stop NetworkManager; sudo ip link set dev wlp3s0 down'
alias ww='ws; sudo netctl start wlp3s0-SIGNAL_AP'
alias services='systemctl --type=service --no-pager'
alias service-enabled='systemctl list-unit-files | grep enabled'
alias service-running='systemctl list-units -t service --no-pager --no-legend | grep active'
alias lid-switch-disable='systemd-inhibit --what=handle-lid-switch sleep 1d'
alias battery-stats='upower -i $(upower -e | grep 'BAT')'
alias leases-dhcp="cat /var/lib/misc/dnsmasq.leases | awk '\$0 {print \$3,\$4,\$5}'"
alias ssid-scan="sudo iw dev wlp3s0 scan | grep SSID"
alias public-ip="wget -q -O - http://checkip.dyndns.org|sed s/[^0-9.]//g"
alias clean-yay-cache="yay -Sc"
alias clean-pacman-cache="paccache -rk1 && paccache -ruk0"
alias clean-logs="sudo journalctl --vacuum-time=1months"
alias clean-progs="sudo bleachbit system.* chromium.* firefox.* -c"
alias sz='source ~/.zshrc'
alias tag-music='beet import ~/tammy/music -qai'
alias network-share='smbclient \\\\192.168.100.1\\public'
alias backup-remote="rsync -avzuP ~/pictures ~/read ~/docs ~/work ~/write ~/org samuelcousin.com:~/backup/matebox --exclude='.git'"
alias night-mode='xcalib -invert -alter; xbacklight -set 1'

# Aliases
alias define='dict -d wn'
alias gb='git branch --all'
alias github-labels-copy='copy-github-labels'
alias gl='git log --oneline -n10'
alias gs='git status -s'
alias ga='git add .'
alias lists='nvim ~/write/lists/'
alias md='grip -b'
alias pdf-view='apvlv'
alias thesaurus='dict -d moby-thesaurus'
alias write='nvim ~/write/'
alias webcam='streamer -o ~/downloads/webcam-$(date +%s).jpeg'
alias projector='xrandr --output VGA1 --rotate normal --mode 1024x768 --output LVDS1 --mode 1024x768 --same-as VGA1'
alias editor='shotcut'

# Prompt
PS1='%B%F{210}%n(λ)%M%f%b%F{224}‡ %f%b'
PS_DEFAULT=$PS1

# vi mode prompt
function zle-line-init zle-keymap-select {
case ${KEYMAP} in
        (vicmd)      PROMPT='%B%F{110}%n(λ)%M%f%b%F{224}‡ %f%b' ;;
        (main|viins) PROMPT=$PS_DEFAULT ;;
        (*)          PROMPT=$PS_DEFAULT ;;
esac
zle reset-prompt
}

zle -N zle-line-init
zle -N zle-keymap-select

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/usr/local/bin/google-cloud-sdk/path.zsh.inc' ]; 
then source '/usr/local/bin/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/usr/local/bin/google-cloud-sdk/completion.zsh.inc' ]; 
then source '/usr/local/bin/google-cloud-sdk/completion.zsh.inc'; fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

# fzf via local installation
if [ -e ~/.fzf ]; then
        _append_to_path /usr/bin/fzf
        source /usr/share/fzf/key-bindings.zsh
        source /usr/share/fzf/completion.zsh
fi

# fzf + ag configuration
if _has fzf && _has ag; then
        export FZF_DEFAULT_COMMAND='ag --nocolor -g ""'
        export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_ALT_C_COMMAND="$FZF_DEFAULT_COMMAND"
        export FZF_DEFAULT_OPTS='
        --height 20% --border
        '
fi
