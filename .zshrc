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
alias mkdir='mkdir -p'
alias ssh='TERM=xterm ssh'
alias vim='nvim'
alias vi='nvim'
alias wifi-menu='ws; wifi-menu'

# Dotfiles
alias ei3='nvim ~/.config/i3/config'
alias ev='nvim ~/.config/nvim/init.vim'
alias ez='nvim ~/.zshrc'
alias sz='source ~/.zshrc'

# music
alias cmus-reload-lib="dir ~/music/*/*.mp3 -R -1 --quoting-style=literal > ~/music/library.m3u"
alias fetch-music='rsync -avzuP --stats sweatbox:/home/kuzyn/caddy/completed/RED/ ~/music/ --exclude "seeding" && chmod 744 ~/music -R; cmus-reload-lib; tag-music'
alias tag-music='beet import ~/music -qai'

# system
alias service-enabled='systemctl list-unit-files | grep enabled'
alias service-running='systemctl list-units -t service --no-pager --no-legend | grep active'
alias screen-rotate='xrandr --output VGA1 --auto --right-of LVDS1 --auto --rotate left'
alias clean-yay-cache="yay -Sc"
alias clean-pacman-cache="paccache -rk1 && paccache -ruk0"
alias clean-logs="sudo journalctl --vacuum-time=1weeks"
alias battery-stats='upower -i $(upower -e | grep 'BAT')'
alias ts=' echo $(date --date=@$(xclip -o)) | while read TS; do notify-send "$TS"; done'

# network
alias public-ip="wget -q -O - http://checkip.dyndns.org|sed s/[^0-9.]//g"
alias wh='ws; sudo netctl start wlp3s0-CHATEAU_BURLINGTON_5G'
alias ws='sudo netctl stop-all; sudo systemctl stop NetworkManager; sudo ip link set dev wlp3s0 down'
alias ww='ws; sudo netctl start wlp3s0-SIGNAL_AP'
alias eth-dhcp='sudo bash /home/kuzyn/.config/scripts/eth-dhcp.sh'

# screen
alias projector-on='xrandr --output HDMI1 --rotate normal --mode 1280x720 --output LVDS1 --mode 1280x720 --same-as HDMI1'
alias projector-off='xrandr --output HDMI1 --off --output LVDS1 --auto' 
alias lid-switch-disable='systemd-inhibit --what=handle-lid-switch sleep 1d'
alias backup-remote="rsync -avzuP ~/pictures ~/read ~/docs ~/work ~/write ~/org oceanbox:~/backup/$HOST --exclude='.git' --exclude='node_modules'"

# picture/video
alias scan='bash ~/.config/scripts/scan.sh'
alias webcam='streamer -o ~/downloads/webcam-$(date +%s).jpeg'
alias video-editor='shotcut'

# git
alias gb='git branch --all'
alias gl='git log --oneline -n10'
alias gs='git status -s'
alias ga='git add .'

# writing
alias lists='nvim ~/write/lists/'
alias write='nvim ~/write/'
alias define='dict -d wn'
alias thesaurus='dict -d moby-thesaurus'

# Prompt
PS1='%B%F{210}%n(∴)%M%f%b%F{224}‡ %f%b'
PS_DEFAULT=$PS1

# vi mode prompt
function zle-line-init zle-keymap-select {
case ${KEYMAP} in
        (vicmd)      PROMPT='%B%F{110}%n(∵)%M%f%b%F{224}‡ %f%b' ;;
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

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
###-begin-pm2-completion-###
### credits to npm for the completion file model
#
# Installation: pm2 completion >> ~/.bashrc  (or ~/.zshrc)
#

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
COMP_WORDBREAKS=${COMP_WORDBREAKS/@/}
export COMP_WORDBREAKS

if type complete &>/dev/null; then
  _pm2_completion () {
    local si="$IFS"
    IFS=$'\n' COMPREPLY=($(COMP_CWORD="$COMP_CWORD" \
                           COMP_LINE="$COMP_LINE" \
                           COMP_POINT="$COMP_POINT" \
                           pm2 completion -- "${COMP_WORDS[@]}" \
                           2>/dev/null)) || return $?
    IFS="$si"
  }
  complete -o default -F _pm2_completion pm2
elif type compctl &>/dev/null; then
  _pm2_completion () {
    local cword line point words si
    read -Ac words
    read -cn cword
    let cword-=1
    read -l line
    read -ln point
    si="$IFS"
    IFS=$'\n' reply=($(COMP_CWORD="$cword" \
                       COMP_LINE="$line" \
                       COMP_POINT="$point" \
                       pm2 completion -- "${words[@]}" \
                       2>/dev/null)) || return $?
    IFS="$si"
  }
  compctl -K _pm2_completion + -f + pm2
fi
###-end-pm2-completion-###
