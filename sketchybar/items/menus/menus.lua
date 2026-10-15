local menu_watcher = SBAR.add("item", {
  drawing = false,
  updates = false,
})
local space_menu_swap = SBAR.add("item", {
  drawing = false,
  updates = true,
})
SBAR.add("event", "swap_menus_and_spaces")

local max_items = 15
local menu_items = {}
for i = 1, max_items, 1 do
  local menu = SBAR.add("item", "menu." .. i, {
    padding_left = PADDINGS,
    padding_right = PADDINGS,
    drawing = false,
    icon = { drawing = false },
    label = {
      color = COLORS.subtext0, -- a shade below the Apple logo's pure text
      padding_left = 6,
      padding_right = 6,
    },
    click_script = "sketchybar-menus -s " .. i,
  })

  menu_items[i] = menu
end

-- 矢印の見た目では、メニューもスペースと同じ暗い帯に入れる（枠とすき間はなし）
if BAR_STYLE == "arrows" then
  local PL = require("helpers.powerline")
  for _, menu in ipairs(menu_items) do
    menu:set({ padding_left = 0, padding_right = 0, background = PL.block(COLORS.bg0) })
  end
else
  SBAR.add("bracket", { "/menu\\..*/" }, {
    background = { color = COLORS.transparent, border_color = COLORS.surface1 },
  })
end

local menu_padding = SBAR.add("item", "menu.padding", {
  drawing = false,
  width = BAR_STYLE == "arrows" and 0 or 5,
})

local function update_menus(env)
  SBAR.exec("sketchybar-menus -l", function(menus)
    SBAR.set("/menu\\..*/", { drawing = false })
    menu_padding:set({ drawing = true })
    local id = 1
    for menu in string.gmatch(menus, "[^\r\n]+") do
      if id < max_items then
        menu_items[id]:set({ label = menu, drawing = true })
      else
        break
      end
      id = id + 1
    end
  end)
end

menu_watcher:subscribe("front_app_switched", update_menus)

space_menu_swap:subscribe("swap_menus_and_spaces", function(env)
  local drawing = menu_items[1]:query().geometry.drawing == "on"
  if drawing then
    menu_watcher:set({ updates = false })
    SBAR.set("/menu\\..*/", { drawing = false })
    SBAR.set("/space\\..*/", { drawing = true })
    SBAR.set("front_app", { drawing = true })
  else
    menu_watcher:set({ updates = true })
    SBAR.set("/space\\..*/", { drawing = false })
    SBAR.set("front_app", { drawing = false })
    update_menus()
  end
end)

return menu_watcher
