-- 今使っているターミナルのフォルダの git ブランチを出す（変更があれば "*" を付ける）。
-- ターミナル（Ghostty か WezTerm）が前面にないとき、またはフォルダが git の中でないときは隠す。
--
-- 旧設定は WezTerm 専用で、WezTerm に今のペインのフォルダを聞いていた。Ghostty にはそれを聞く方法がないので、
-- tmux に聞く: Nix 側と旧環境の両方の tmux から、いちばん最近使ったクライアントの今のペインのフォルダを使う
-- （ターミナルは常に tmux の中で使う前提。tmux の外のシェルでは、最後に使った tmux のフォルダになる）
local git_branch = SBAR.add("item", "git_branch", {
  position = "right",
  drawing = false,
  updates = true, -- see items/docker/docker.lua for why this is needed
  icon = { string = ICONS.git_branch, color = COLORS.yellow },
  label = { string = "" },
  update_freq = 5,
})

local GIT_BRANCH_CMD = [[
CWD=$(for SOCK in "$TMPDIR/tmux-$(id -u)/default" "/tmp/tmux-$(id -u)/default"; do
  tmux -S "$SOCK" list-clients -F '#{client_activity} #{pane_current_path}' 2>/dev/null
done | sort -rn | head -1 | cut -d' ' -f2-)

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
  if env and env.INFO and env.INFO ~= "Ghostty" and env.INFO ~= "WezTerm" then
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
  SBAR.exec("open -a Ghostty")
end)
