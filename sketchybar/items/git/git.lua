-- Shows the git branch (with a "*" if dirty) of the active WezTerm pane's
-- working directory. Hidden when WezTerm isn't the frontmost app, or its
-- current directory isn't inside a git repo. WezTerm-specific: uses
-- `wezterm cli list` to find the active pane's cwd.
--
-- `wezterm cli list`'s cwd relies on OSC7, which tmux doesn't forward from
-- panes by default - so when the active pane is running tmux, that cwd is
-- stale (stuck at wherever the pane started). tmux itself always knows the
-- real per-pane cwd via the OS, so when the active WezTerm pane's tty has a
-- tmux client attached, we ask tmux for that client's current pane path
-- instead of trusting WezTerm's cwd.
local git_branch = SBAR.add("item", "git_branch", {
  position = "right",
  drawing = false,
  updates = true, -- see items/docker/docker.lua for why this is needed
  icon = { string = ICONS.git_branch, color = COLORS.yellow },
  label = { string = "" },
  update_freq = 5,
})

local GIT_BRANCH_CMD = [[
INFO=$(wezterm cli list --format json 2>/dev/null)
TTY=$(echo "$INFO" | jq -r '[.[] | select(.is_active)][0].tty_name // empty')
CWD=$(echo "$INFO" | jq -r '[.[] | select(.is_active)][0].cwd // empty' | sed -E 's#^file://[^/]*##')

if [ -n "$TTY" ]; then
  TMUX_SESSION=$(tmux list-clients -F '#{client_tty} #{client_session}' 2>/dev/null | awk -v t="$TTY" '$1==t{print $2; exit}')
  if [ -n "$TMUX_SESSION" ]; then
    TMUX_CWD=$(tmux display-message -p -t "$TMUX_SESSION" '#{pane_current_path}' 2>/dev/null)
    [ -n "$TMUX_CWD" ] && CWD="$TMUX_CWD"
  fi
fi

if [ -n "$CWD" ] && git -C "$CWD" rev-parse --is-inside-work-tree >/dev/null 2>&1; then
  BRANCH=$(git -C "$CWD" branch --show-current 2>/dev/null)
  if [ -n "$BRANCH" ] && [ -n "$(git -C "$CWD" status --porcelain 2>/dev/null)" ]; then
    echo "$BRANCH*"
  else
    echo "$BRANCH"
  fi
fi
]]

local function refresh_git_branch(env)
  if STATS_VISIBLE == false then
    git_branch:set({ drawing = false })
    return
  end
  if env and env.INFO and env.INFO ~= "WezTerm" then
    git_branch:set({ drawing = false })
    return
  end

  SBAR.exec(GIT_BRANCH_CMD, function(result)
    local branch = result:gsub("%s+$", "")
    git_branch:set({
      drawing = branch ~= "",
      label = branch,
    })
  end)
end

git_branch:subscribe({ "forced", "routine" }, refresh_git_branch)
git_branch:subscribe("front_app_switched", refresh_git_branch)

git_branch:subscribe("mouse.clicked", function()
  SBAR.exec("open -a WezTerm")
end)
