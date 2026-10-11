local cpu = SBAR.add("graph", "widgets.cpu", 48, {
  position = "right",
  graph = { color = COLORS.peach },
  background = {
    height = 26,
    color = { alpha = 0 },
    border_color = { alpha = 0 },
    drawing = true,
  },
  icon = {
    string = ICONS.cpu,
    color = COLORS.peach,
    font = { size = 15.0 },
    padding_left = 6,
    padding_right = 6,
  },
  label = {
    string = "CPU ??%",
    font = { size = 12.0 },
    align = "right",
    padding_left = 4,
    padding_right = 0,
    width = 0,
    y_offset = 4,
  },
  padding_right = PADDINGS + 10,
})

cpu:subscribe({ "system_stats" }, function(env)
  GRAPH_UTILS.update_graph(env.CPU_USAGE, cpu, "CPU", COLORS.peach)
end)

cpu:subscribe("mouse.clicked", function(env)
  SBAR.exec("open -a 'Activity Monitor'")
end)
