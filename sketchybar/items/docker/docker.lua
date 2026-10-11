-- Shows the number of running Docker containers. Hidden when Docker isn't
-- running or nothing is running, so it doesn't clutter the bar otherwise.
local docker = SBAR.add("item", "docker", {
  position = "right",
  drawing = false,
  updates = true, -- override the global "when_shown" default: this item
                   -- starts hidden and needs its routine tick to run even
                   -- while hidden, or it could never reveal itself
  icon = { string = ICONS.docker, color = COLORS.green },
  label = { string = "0" },
  update_freq = 10,
  click_script = "open -a Docker",
})

docker:subscribe({ "forced", "routine" }, function()
  if STATS_VISIBLE == false then
    docker:set({ drawing = false })
    return
  end

  -- SketchyBar's exec PATH is /opt/homebrew/bin:/opt/homebrew/sbin:/usr/bin:
  -- /bin:/usr/sbin:/sbin -- docker (Docker Desktop's CLI) lives in
  -- /usr/local/bin, which isn't on it, so it needs the full path here.
  SBAR.exec("/usr/local/bin/docker ps -q 2>/dev/null | wc -l | tr -d ' '", function(result)
    local count = tonumber(result) or 0
    docker:set({
      drawing = count > 0,
      label = tostring(count),
    })
  end)
end)
