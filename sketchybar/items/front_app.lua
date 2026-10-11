-- 今のアプリ（前面にあるアプリのアイコンと名前）
local colors = require("colors")
local island = require("items.island")
local icon_map = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

local front_app = sbar.add("item", "front_app", {
  icon = {
    font = { family = "sketchybar-app-font", style = "Regular", size = 15.0 },
    color = colors.cyan,
    padding_left = 10,
  },
  label = { color = colors.fg1, padding_right = 10 },
  updates = true,
})

front_app:subscribe("front_app_switched", function(env)
  front_app:set({
    icon = { string = icon_map[env.INFO] or ":default:" },
    label = { string = env.INFO },
  })
end)

island("front_app.island", { front_app.name })
