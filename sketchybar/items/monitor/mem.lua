local ram = SBAR.add("graph", "widgets.ram", 48, {
  position = "right",
  graph = { color = COLORS.red },
  background = {
    height = 26,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = {
    string = ICONS.ram,
    color = COLORS.red,
    font = { size = 15.0 },
    padding_left = 6,
    padding_right = 6,
  },
  label = {
    string = "RAM ??%",
    font = { size = 12.0 },
    align = "right",
    padding_left = 4,
    padding_right = 0,
    width = 0,
    y_offset = 4,
  },
  update_freq = 3,
  updates = "when_shown",
  padding_right = PADDINGS,
})

ram:subscribe({ "system_stats" }, function(env)
  GRAPH_UTILS.update_graph(env.RAM_USAGE, ram, "RAM", COLORS.red)
end)
