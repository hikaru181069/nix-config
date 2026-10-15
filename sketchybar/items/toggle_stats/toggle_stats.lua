-- 添加自定义事件
SBAR.exec("sketchybar --add event hide_stats")
SBAR.exec("sketchybar --add event show_stats")
SBAR.exec("sketchybar --add event toggle_stats")

-- Global flag other self-managing widgets (git_branch, docker) check
-- before deciding whether to show themselves -- see items/git/git.lua
-- and items/docker/docker.lua.
STATS_VISIBLE = true

-- Always shown/hidden directly; these have no visibility logic of their
-- own. git_branch/docker are handled separately below since forcing
-- their `drawing` here would fight their own conditional visibility.
local stats_items = {
  "widgets.cpu",
  "widgets.upload_speed",
  "widgets.download_speed",
  "widgets.ram",
}
-- 矢印の見た目の区切り（items/init.lua の right_gap）も一緒に隠す
if BAR_STYLE == "arrows" then
  table.insert(stats_items, "/rsep\\.stats\\..*/")
end

-- 创建 separator_right item
local separator = SBAR.add("item", "separator_right", {
  position = "right",
  icon = {
    string = ICONS.stats_toggle.show,
    color = COLORS.lavender,
  },
  label = { drawing = false },
  background = {
    padding_left = PADDINGS,
    padding_right = 10,
  },
})

-- 创建隐藏的 animator item 用于处理事件
local animator = SBAR.add("item", "animator", {
  position = "right",
  drawing = false,
  updates = true,
})

-- 隐藏 stats
local function hide_stats()
  STATS_VISIBLE = false
  for _, item_name in ipairs(stats_items) do
    SBAR.set(item_name, { drawing = false })
  end
  SBAR.set("git_branch", { drawing = false })
  if BAR_STYLE == "arrows" then
    SBAR.set("/rsep\\.git.*/", { drawing = false })
  end
  separator:set({ icon = { string = ICONS.stats_toggle.hide } })
end

-- 显示 stats
local function show_stats()
  STATS_VISIBLE = true
  for _, item_name in ipairs(stats_items) do
    SBAR.set(item_name, { drawing = true })
  end
  -- git_branch/docker decide their own visibility; nudge them to
  -- re-evaluate now that STATS_VISIBLE is true again.
  SBAR.trigger("forced")
  separator:set({ icon = { string = ICONS.stats_toggle.show } })
end

-- 切换 stats
local function toggle_stats()
  local current_icon = separator:query().icon.value

  if current_icon == ICONS.stats_toggle.hide then
    show_stats()
  else
    hide_stats()
  end
end

-- separator 点击事件
separator:subscribe("mouse.clicked", function()
  SBAR.trigger("toggle_stats")
end)

-- animator 订阅事件
animator:subscribe("hide_stats", hide_stats)
animator:subscribe("show_stats", show_stats)
animator:subscribe("toggle_stats", toggle_stats)
