function kl() {
  kubectl get pods | grep "$1" | awk '{print $1}' | xargs kubectl logs -f
}

function g-sd() {
  git stash drop stash@{"${1:-0}"}
}