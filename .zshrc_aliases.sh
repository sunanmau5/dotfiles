# export variable $ALIAS_FILE_PATH on your `.zshrc` file that's pointing to the absolute path of this file

alias ll="ls -la"

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
alias g-sp="git stash pop"
alias g-sl="git stash list"
alias g-sd="git stash drop stash@{0}"

alias rr="source ~/.zshrc"
alias cat="bat"

export VSCODE_SETTINGS_PATH="/Users/mba/Library/'Application Support'/Code/User/settings.json"

alias zsh-config="code ~/.zshrc"
alias vsc-config="code $VSCODE_SETTINGS_PATH"
alias alias-config="code $ALIAS_FILE_PATH"

alias alias:custom="cat $ALIAS_FILE_PATH"
alias vsc-to-dotfiles="cat $VSCODE_SETTINGS_PATH >> $DOTFILES_PATH/.vscode/settings.json"
alias backup:vsc="vsc-to-dotfiles && $DOTFILES_PATH && git add .vscode && g-cm 'chore: backup vscode config' && g-pu"


# n
alias n="N_PREFIX=$HOME/.local n"

# marta
alias m-s="yarn run dev:server"
alias m-sj="AWS_PROFILE=default NODE_ENV=production yarn run dev:server"
alias m-ss="AWS_PROFILE=sunan NODE_ENV=production yarn run dev:server"
alias m-sh="AWS_PROFILE=heinz NODE_ENV=production yarn run dev:server"
alias m-sm="AWS_PROFILE=marta NODE_ENV=production yarn run dev:server"
alias m-e="yarn run dev:employee"
alias m-clean="git clean -fxd && yarn install && sh scripts/ux-sync.sh && yarn run db:create"
alias m-v="yarn run tsc && yarn run test && yarn run databuilder:tests"
alias m-recreate="bash ~/Developer/scripts/recreate-db.sh"
alias rmods="find . -type dir -name node_modules | xargs rm -rf"
alias m-deps="bash ~/Developer/scripts/remove-add-dependency.sh"
alias awks="aws eks update-kubeconfig --region eu-central-1 --name k8s-cluster && export KUBE_CONFIG_PATH=~/.kube/config"

# services
alias s-se="cd ~/Developer/marta/search-service"
alias s-tr="cd ~/Developer/marta/translation-service"

# wordpress
alias wplocal="cd /Applications/XAMPP/htdocs"

# corepack
alias yarn="corepack yarn"
alias yarnpkg="corepack yarnpkg"
alias pnpm="corepack pnpm"
alias pnpx="corepack pnpx"
alias npm="corepack npm"
alias npx="corepack npx"

# pnpm
alias p="pnpm"

# lazygit
alias lg="lazygit"

# network
alias ip="ipconfig getifaddr en0"