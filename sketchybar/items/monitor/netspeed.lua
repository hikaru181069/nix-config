-- 通信量。1行に「↓受信 ↑送信」と並べる（前は小さい文字で上下2行に重ねていたが、読みにくいので
-- ほかの項目と同じ大きさにした）。通信していないときは暗い色にする
-- 右側の項目は右端から順に並ぶので、送信（右）を先に足す
local upload_speed = SBAR.add("item", "widgets.upload_speed", {
  position = "right",
  padding_left = 0,
  icon = {
    padding_right = 2,
    font = { size = 13.0 },
    string = ICONS.wifi.upload,
  },
  label = {
    font = { size = 13.0 },
    string = "??? KB/s",
  },
})

local download_speed = SBAR.add("item", "widgets.download_speed", {
  position = "right",
  icon = {
    padding_right = 2,
    font = { size = 13.0 },
    string = ICONS.wifi.download,
  },
  label = {
    font = { size = 13.0 },
    string = "??? KB/s",
  },
})

local function format_speed(speed_str)
  local speed = tonumber(speed_str)
  if speed < 1024 then
    return string.format("%d KB/s", speed)
  elseif speed < 1024 * 1024 then
    return string.format("%.1f MB/s", speed / 1024)
  else
    return string.format("%.1f GB/s", speed / (1024 * 1024))
  end
end

upload_speed:subscribe("system_stats", function(env)
  local up_color = (env.NETWORK_TX_en0 == "0") and COLORS.grey or COLORS.subtext0
  local down_color = (env.NETWORK_RX_en0 == "0") and COLORS.grey or COLORS.subtext0

  upload_speed:set({
    icon = { color = up_color },
    label = { string = format_speed(env.NETWORK_TX_en0), color = up_color },
  })
  download_speed:set({
    icon = { color = down_color },
    label = { string = format_speed(env.NETWORK_RX_en0), color = down_color },
  })
end)
