# The following lines were added by compinstall
zstyle :compinstall filename '/home/nick/.zshrc'

autoload -Uz compinit
compinit

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
# End of lines added by compinstall

export PROMPT="
%{$fg[white]%}(%D %*) <%?> [%~] $program %{$fg[default]%}
%{$fg[cyan]%}%m %#%{$fg[default]%} "

HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=1000
setopt extendedglob
setopt auto_cd
bindkey -v
bindkey '^R' history-incremental-pattern-search-backward

fpath=(~/.zsh/completion $fpath)
autoload -Uz compinit && compinit -i

autoload -U up-line-or-beginning-search
autoload -U down-line-or-beginning-search

zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bindkey "^[[A" up-line-or-beginning-search # Up
bindkey "^[[B" down-line-or-beginning-search # Down


LS_COLORS=$LS_COLORS:'di=1;37'
export LS_COLORS

alias ls='ls -Gtr'
alias l='ls -Gtr'
alias la='ls -aGtr'

alias gs='git status'
alias gl="git log -n 10 --pretty=format:'  %C(bold red)%h  %Creset%<(50,trunc)%s  %C(bold green)%<(15,trunc)%cn  %C(bold blue)%cr%Creset'"
alias dag="git log --decorate --graph --oneline --all"
alias gca='git commit --amend'
alias gri='git rebase -i'
alias grc='git rebase --continue'

function rgs() {
	for dir in */; do
		cd $dir
    echo
		if gs | grep -e 'Changes not staged' -e 'Untracked' -e 'is ahead of'; then
		pwd
		  gs
		fi
		cd ..
	;done
}

alias cdw='cd ~/workplace'

# alias tmux='TERM=xterm-256color tmux'

alias dusort="du -shc * | sort -h -k1,1"

alias pydir="ssh -o ProxyCommand=none -NL 3030:localhost:3030 dev-dsk-nkryan-2c-293d080d.us-west-2.amazon.com"


[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

if command -v pyenv 1>/dev/null 2>&1; then
        eval "$(pyenv init -)"
fi

mw() {
  KEY_FILE="$HOME/.ssh/id_rsa-cert.pub"

  if [ -f $KEY_FILE ]; then
    CERT=$(ssh-keygen -Lf $KEY_FILE | awk 'NR==7{print $5}')
    DATE_NOW=$(date +"%Y-%m-%dT%T")

    if [[ "$DATE_NOW" > "$CERT" ]];
    then
      echo "Your midway has expired..."
      mwinit -s --fido2 
      store_keys
      push_mwinit_cookie
    fi
  else
    echo "Your midway has not been found..."
    mwinit -s --fido2
    store_keys
    push_mwinit_cookie
  fi
}

mwf() {
  rm -f "$HOME/.ssh/id_rsa-cert.pub"
  mw
}

store_keys() {
  ssh-add -D
  ssh-add --apple-use-keychain
}

push_mwinit_cookie() {
  scp ~/.midway/cookie dev-dsk-nkryan-2c-293d080d.us-west-2.amazon.com:~/.midway/cookie
}

path+=('/home/nick/maelstrom');
export path
export DISPLAY="$(hostname).local:0.0"
