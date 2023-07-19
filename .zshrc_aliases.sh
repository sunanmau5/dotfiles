# export variable $ALIAS_FILE_PATH on your `.zshrc` file that's pointing to the absolute path of this file

alias ll="ls -la"
alias gh-cpr="gh pr create -w"
alias gh-vpr="gh pr view -w"
alias gh-lpr="gh pr list"

# Git commands
alias g-s="git status"
alias g-c="git commit"
alias g-cm="git commit -m"
alias g-amend="git commit --amend"
alias g-p="git push"
alias g-pf="git pushfwl"
alias g-l="git pull"
alias g-b="git symbolic-ref --short -q HEAD"
alias g-ba="git branch -a"
alias g-co="git checkout"
alias g-cc="g-co master && g-l"
alias g-main="g-co main && g-l"
alias g-rc="g-co rc && g-l"
alias g-prod="g-co production && g-l"
alias g-cb="g-co -b"
alias g-pu="g-p -u origin \$(g-b)"
alias g-a="git add ."
alias g-f="git fetch"
alias g-r="git rebase"
alias g-rm="g-r master || g-r main"
alias g-rr="g-r rc"
alias g-local="git config user.email sunan.regi@gmail.com"
alias g-delete-origin="git push origin --delete"
alias g-rh="g-f origin && git reset --hard origin/master"
alias g-log="git log --oneline --graph"
alias g-re="git restore"
alias g-ra="git restore ."

alias cc="clear"
alias rr="source ~/.zshrc"

export VSCODE_SETTINGS_PATH="/Users/mba/Library/'Application Support'/Code/User/settings.json"

alias zsh-config="code ~/.zshrc"
alias vsc-config="code $VSCODE_SETTINGS_PATH"
alias alias-config="code $ALIAS_FILE_PATH"

alias alias:custom="cat $ALIAS_FILE_PATH"
alias vsc-to-dotfiles="cat $VSCODE_SETTINGS_PATH >> $DOTFILES_PATH/.vscode/settings.json"
alias backup:vsc="vsc-to-dotfiles && $DOTFILES_PATH && git add .vscode && g-cm 'chore: backup vscode config' && g-pu"

alias mono="cd ~/Documents/marta/mono"
alias marta-app="cd ~/Documents/marta/marta-app"
alias reagent="cd ~/Documents/htw/reagent/frontend-v2"
alias projex="cd ~/Documents/projects"
alias htw="cd ~/Documents/htw"
alias sublime="cd ~/Documents/sublime"
alias dotfiles="cd ~/dotfiles"
alias filtre="cd ~/Documents/projects/chrome-ext/filtre"
alias thesis="cd ~/Documents/htw/ba/ba-tex"

# homebrew
alias start-pg="brew services start postgresql"
alias stop-pg="brew services stop postgresql"
alias restart-pg="brew services restart postgresql"

# n
alias n="N_PREFIX=$HOME/.local n"

# marta
alias m-s="yarn run dev:server"
alias m-sj="AWS_PROFILE=default NODE_ENV=production yarn run dev:server"
alias m-ss="AWS_PROFILE=sunan NODE_ENV=production yarn run dev:server"
alias m-sh="AWS_PROFILE=heinz NODE_ENV=production yarn run dev:server"
alias m-sm="AWS_PROFILE=marta NODE_ENV=production yarn run dev:server"
alias m-e="yarn run dev:employee"
alias m-a="yarn run dev:app"
alias m-c="yarn run dev:caregiver"
alias m-i="yarn run dev:inquirer"
alias m-clean="git clean -fxd && yarn install && sh scripts/ux-sync.sh && yarn run db:create"
alias m-v="yarn run tsc && yarn run test && yarn run databuilder:tests"
alias m-recreate="sh /Users/mba/Documents/scripts/recreate-db.sh"

# services
alias s-se="cd ~/Documents/marta/search-service"
alias s-tr="cd ~/Documents/marta/translation-service"
