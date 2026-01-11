function kl() {
  kubectl get pods | grep "$1" | awk '{print $1}' | xargs kubectl logs -f
}

function g-sd() {
  git stash drop stash@{"${1:-0}"}
}

# zsh-vi-mode hook (keybindings must be set here to survive zsh-vi-mode init)
function zvm_after_init() {
  bindkey '^ ' autosuggest-accept
}

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}