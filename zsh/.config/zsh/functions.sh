function kl() {
  kubectl get pods | grep "$1" | awk '{print $1}' | xargs kubectl logs -f
}

function g-sd() {
  git stash drop stash@{"${1:-0}"}
}

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}