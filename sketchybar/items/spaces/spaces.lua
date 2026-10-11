local window_manager
if WINDOW_MANAGER == "aerospace" then
  window_manager = require("items.spaces.window_managers.aerospace")
elseif WINDOW_MANAGER == "yabai" then
  window_manager = require("items.spaces.window_managers.yabai")
else
  window_manager = require("items.spaces.window_managers.macos_native")
end

window_manager:init()
window_manager:start_watcher()

-- 旧設定にあった、スペース番号とアプリのメニューを入れ替えるスイッチは外した。
-- 代わりに、今のアプリのアイコンを押すと入れ替わる（items/front_app/front_app.lua）
