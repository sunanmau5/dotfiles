function kl() {
  kubectl get pods | grep "$1" | grep -v "\-migration\-" | awk '{print $1}' | xargs kubectl logs -f
}

function g-sd() {
  git stash drop stash@{"${1:-0}"}
}

# AI commit message generator (ctrl+g)
function gcm-ai() {
  git rev-parse --is-inside-work-tree &>/dev/null || { echo "Not a git repository"; return 1; }

  local diff=$(git diff --cached)
  [[ -z "$diff" ]] && diff=$(git diff)
  [[ -z "$diff" ]] && { echo "No changes to commit"; return 1; }

  local prompt='You are an expert at writing Git commits. Your job is to write a short clear commit message that summarizes the changes.

If you can accurately express the change in just the subject line, don'\''t include anything in the message body. Only use the body when it is providing *useful* information.

Don'\''t repeat information from the subject line in the message body.

Only return the commit message in your response. Do not include any additional meta-commentary about the task. Do not include the raw diff output in the commit message.

Follow Angular commit convention and good Git style:

- Start with a type prefix: feat, fix, docs, style, refactor, test, chore
- If the branch name contains a ticket number (e.g. MP-1234), include it in parentheses after the type: feat(MP-1234):
- Use lowercase for the subject line after the prefix
- Separate the subject from the body with a blank line
- Try to limit the subject line to 72 characters
- Do not end the subject line with any punctuation
- Use the imperative mood in the subject line
- Wrap the body at 72 characters
- Keep the body short and concise (omit it entirely if not useful)

Branch: '"$(git branch --show-current)"'

Recent commits:
'"$(git log --oneline -10 2>/dev/null)"'

Status:
'"$(git status -s)"'

Diff:
'"$diff"

  local start=$SECONDS
  echo -n "Generating..."
  local msg=$(echo "$prompt" | agent -p 2>/dev/null | tr '\n' ' ' | sed 's/  */ /g; s/^[[:space:]]*//; s/[[:space:]]*$//')
  local elapsed=$((SECONDS - start))
  echo "\r\033[KGenerated in ${elapsed}s"

  [[ -z "$msg" ]] && { echo "Failed to generate message"; return 1; }

  print -z "g-cm \"$msg\""
}

# zsh-vi-mode config (runs before plugin init)
function zvm_config() {
  ZVM_VI_COPY_TO_SYSTEM_CLIPBOARD=true
}

# zsh-vi-mode hook (keybindings must be set here to survive zsh-vi-mode init)
function zvm_after_init() {
  bindkey '^e' autosuggest-accept
  bindkey -s '^f' 'tmux-sessionizer\n'
  bindkey -s '^g' 'gcm-ai\n'
}

# jira ready to release tickets
function jira-release() {
  local keys=$(jira sprint list --current -s"Ready to Release" --plain --columns key --no-headers 2>/dev/null)
  [[ -z "$keys" ]] && { echo "No tickets found"; return 1; }

  while IFS= read -r key; do
    [[ -z "$key" ]] && continue
    jira issue view "$key" --raw 2>/dev/null | jq -r '
def marks: (.marks // []) | map(.type) | if index("strong") then "**" elif index("em") then "*" else "" end;
def m: marks as $m | "\($m)\(.text)\($m)";
def adf:
  if type != "object" then ""
  elif .type == "doc" then [.content[]? | adf] | join("\n\n")
  elif .type == "panel" then
    (if .attrs.panelType == "error" then "> [!CAUTION]\n"
     elif .attrs.panelType == "warning" then "> [!WARNING]\n"
     elif .attrs.panelType == "success" then "> [!TIP]\n"
     else "> [!NOTE]\n" end) + ([.content[]? | adf] | join("\n") | split("\n") | map("> " + .) | join("\n"))
  elif .type == "paragraph" then [.content[]? | adf] | join("")
  elif .type == "text" then m
  elif .type == "heading" then ("#" * (.attrs.level // 1)) + " " + ([.content[]? | adf] | join(""))
  elif .type == "orderedList" then [.content | to_entries[] | "\(.key + 1). \(.value | adf)"] | join("\n")
  elif .type == "bulletList" then [.content[]? | "- " + adf] | join("\n")
  elif .type == "listItem" then [.content[]? | adf] | join("")
  else [.content[]? | adf] | join("")
  end;
"## [\(.key)] \(.fields.summary)\nType: \(.fields.issuetype.name)\n\n\((.fields.description // {}) | adf)\n"'
  done <<< "$keys" | cat -s | pbcopy

  echo "Copied to clipboard" >&2
}

# yazi
function y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ -n "$cwd" ] && [ "$cwd" != "$PWD" ] && builtin cd -- "$cwd"
	rm -f -- "$tmp"
}