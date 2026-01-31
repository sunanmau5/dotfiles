alias cc="clear"

# Git commands
alias g-s="git status"
alias g-c="git commit"
alias g-cm="git commit -m"
alias g-amend="git commit --amend"
alias g-p="git push"
alias g-pf="git pushfwl"
alias g-l="git pull"
alias g-b="git symbolic-ref --short -q HEAD"
alias g-bo="git for-each-ref --format='%(upstream:short)' \$(g-b)"
alias g-ba="git branch -a"
alias g-co="git checkout"
alias g-cc="g-co master && g-l"
alias g-dd="g-co develop && g-l"
alias g-main="g-co main && g-l"
alias g-cb="g-co -b"
alias g-pu="g-p -u origin \$(g-b)"
alias g-a="git add ."
alias g-f="git fetch"
alias g-r="git rebase"
alias g-rm="g-r master || g-r main"
alias g-rr="g-r rc"
alias g-local="git config user.email sunan.regi@gmail.com"
alias g-delete-origin="git push origin --delete"
alias g-rh="g-f origin && git reset --hard \$(g-bo)"
alias g-log="git log --oneline --graph"
alias g-re="git restore --staged"
alias g-ra="git restore ."
alias g-h="open \`git remote -v | grep git@github.com | grep fetch | head -1 | cut -f2 | cut -d' ' -f1 | sed -e's/:/\//' -e 's/git@/http:\/\//'\`"
alias g-st="git stash --include-untracked"
alias g-sm="git stash push --include-untracked -m"
alias g-sp="git stash pop"
alias g-sl="git stash list"
alias g-ss="git stash push -S"
# copy last commit message
alias g-clc="git log -1 --pretty=%B | perl -pe 'chomp if eof' | pbcopy"
# list recently committed branches
alias g-lb="git branch --sort=-committerdate | head -10"

alias rr="source $ZSH_CONFIG_PATH"
alias cat="bat"
alias vim="nvim"

alias zsh-config="$editor $ZSH_CONFIG_PATH"
alias alias-config="$editor $ALIAS_FILE_PATH"
alias vsc-config="$editor $VSCODE_SETTINGS_PATH"
alias alias:custom="cat $ALIAS_FILE_PATH"
alias vlt="$editor $VAULT_PATH"
alias ffd-config="$editor $FFD_PROFILE_PATH"

# marta
alias m-s="pnpm run dev:server"
alias m-e="pnpm run dev:employee"
alias m-clean="git clean -fxd && pnpm install && sh scripts/ux-sync.sh && pnpm run db:create"
alias m-v="pnpm run tsc && pnpm run test && pnpm run databuilder:tests"
alias m-recreate="bash ~/Developer/scripts/recreate-db.sh"
alias m-deps="bash ~/Developer/scripts/remove-add-dependency.sh"
alias rmods="find . -type dir -name node_modules | xargs rm -rf"
alias awks="aws eks update-kubeconfig --region eu-central-1 --name k8s-cluster && export KUBE_CONFIG_PATH=~/.kube/config"
alias arp="adb reverse tcp:4002 tcp:4002 && adb reverse tcp:9001 tcp:9001 && adb reverse tcp:9002 tcp:9002 && adb reverse tcp:9003 tcp:9003 && adb reverse tcp:9004 tcp:9004 && adb reverse tcp:9005 tcp:9005 && adb reverse tcp:9006 tcp:9006 && adb reverse tcp:9007 tcp:9007 && adb reverse tcp:9008 tcp:9008 && adb reverse tcp:9009 tcp:9009"

# tmux
alias t="tmux"
alias ta="t a"
alias tn="t new-session"
alias tl="t ls"
alias tk="t kill-session -t"
alias tq="t kill-server"
alias tr="t rename-session"

# corepack
# alias yarn="corepack yarn"
# alias yarnpkg="corepack yarnpkg"
# alias pnpm="corepack pnpm"
# alias pnpx="corepack pnpx"
# alias npm="corepack npm"

# npq
alias npm="npq-hero"
alias yarn="NPQ_PKG_MGR=yarn npq-hero"
alias pnpm="NPQ_PKG_MGR=pnpm npq-hero"

# wordpress
alias wplocal="cd /Applications/XAMPP/htdocs"

# lazygit
alias lg="lazygit"

# lazydocker
alias ld="lazydocker"

# network
alias ip="ipconfig getifaddr en0"

# obsidian
alias mnu="open \"obsidian://open?vault=cloud-storage&file=menu\""
alias ov="open \"obsidian://open?vault=vault\""

# eza
alias ls='eza -lh --group-directories-first --icons --hyperlink'
alias ll='ls -a'
alias lt='eza --tree --level=2 --long --icons --git'
alias lta='lt -a'

# util
alias uuid='uuidgen | tr "[:upper:]" "[:lower:]" | pbcopy'
alias passgen='openssl rand -base64 12'

# opencode
alias oc="opencode"

# fd
alias fd="fd $FD_OPTIONS"
