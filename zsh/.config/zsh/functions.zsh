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

# zsh-vi-mode config (runs before plugin init)
function zvm_config() {
  ZVM_SYSTEM_CLIPBOARD_ENABLED=true
}

# zsh-vi-mode hook (keybindings must be set here to survive zsh-vi-mode init)
function zvm_after_init() {
  bindkey '^e' autosuggest-accept
  bindkey -s '^g' 'gcm-ai\n'
  # workaround when using fzf and zvm - fzf Ctrl-r will be prioritized
  source <(fzf --zsh)

}

# codex
function cx() {
  codex --sandbox workspace-write "$@"
}

function cxs() {
  codex --sandbox read-only "$@"
}
