# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi


### Added by Zinit's installer
if [[ ! -f $HOME/.zinit/bin/zinit.zsh ]]; then
    print -P "%F{33}▓▒░ %F{220}Installing %F{33}DHARMA%F{220} Initiative Plugin Manager (%F{33}zdharma/zinit%F{220})…%f"
    command mkdir -p "$HOME/.zinit" && command chmod g-rwX "$HOME/.zinit"
    command git clone https://github.com/zdharma/zinit "$HOME/.zinit/bin" && \
        print -P "%F{33}▓▒░ %F{34}Installation successful.%f%b" || \
        print -P "%F{160}▓▒░ The clone has failed.%f%b"
fi

source "$HOME/.zinit/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit

# Load a few important annexes, without Turbo
# (this is currently required for annexes)
zinit light-mode for \
    zinit-zsh/z-a-rust \
    zinit-zsh/z-a-as-monitor \
    zinit-zsh/z-a-patch-dl \
    zinit-zsh/z-a-bin-gem-node

### End of Zinit's installer chunk
zinit ice depth=1; zinit light romkatv/powerlevel10k
zinit light softmoth/zsh-vim-mode 

zinit light IngoMeyer441/zsh-easy-motion
bindkey -M vicmd ' ' vi-easy-motion

zinit ice lucid wait='0'
zinit snippet OMZ::plugins/git/git.plugin.zsh

zinit ice lucid wait='0'
zinit light zdharma/fast-syntax-highlighting

zinit ice lucid wait='0' atload='_zsh_autosuggest_start'
zinit light zsh-users/zsh-autosuggestions

zinit ice lucid wait='0'
zinit load agkozak/zsh-z

zinit ice from"gh-r" as"program"
zinit light junegunn/fzf

zinit ice lucid wait='0'
zinit light Aloxaf/fzf-tab

export NVM_DIR="$HOME/.nvm"
[ -s "/usr/local/opt/nvm/nvm.sh" ] && . "/usr/local/opt/nvm/nvm.sh"  # This loads nvm
[ -s "/usr/local/opt/nvm/etc/bash_completion.d/nvm" ] && . "/usr/local/opt/nvm/etc/bash_completion.d/nvm"  # This loads nvm bash_completion

export FZF_DEFAULT_OPTS='--height 40% --layout=reverse --border'

export EASY_MOTION_DIM="fg=242"
export EASY_MOTION_HIGHLIGHT="fg=196,bold"
export EASY_MOTION_HIGHLIGHT_2_FIRST="fg=#ffb400,bold"
export EASY_MOTION_HIGHLIGHT_2_SECOND="fg=#b98300,bold" 
export TS_POST_PROCESS_FILE="prettier --write"

export JAVA_HOME=$(/usr/libexec/java_home -v1.8.0)
# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
export PATH="$HOME/.emacs.d/bin:/usr/local/opt/sqlite/bin:$PATH"

alias git='LANG=en_US.UTF-8 git'
export PATH="/usr/local/opt/mysql-client/bin:$PATH"
export DOOMGITCONFIG=~/.gitconfig
