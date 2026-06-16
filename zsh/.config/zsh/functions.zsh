function tm() {
  if tmux has-session -t main 2>/dev/null; then
    ta -t main
  else
    tn -s main
  fi
}

function kl() {
  [[ -z "$1" ]] && { kubectl get po; return; }
  local pods
  pods=$(kubectl get pods 2>&1) || { echo "Failed to get pods"; return 1; }
  local pod=$(echo "$pods" | grep "$1" | grep -v "\-migration\-" | awk '{print $1}' | head -1)
  if [[ -n "$pod" ]]; then
    kubectl logs -f "$pod"
  else
    echo "No pod found"
  fi
}

function klm() {
  [[ -z "$1" ]] && { echo "Usage: klm <pod-pattern>"; return 1; }
  local pods
  pods=$(kubectl get pods 2>&1) || { echo "Failed to get pods"; return 1; }
  local pod=$(echo "$pods" | grep "$1" | grep "\-migration\-" | awk '{print $1}' | head -1)
  if [[ -n "$pod" ]]; then
    kubectl logs -f "$pod"
  else
    echo "No migration pod found"
  fi
}

function g-sd() {
  git stash drop stash@{"${1:-0}"}
}

# codex
function cx() {
  codex --sandbox workspace-write "$@"
}

function cxs() {
  codex --sandbox read-only "$@"
}
