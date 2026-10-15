-- アプリ名 → アイコンの対応表。旧設定の sketchybar-app-font-bg ではなく、nixpkgs の sketchybar-app-font と
-- 同じパッケージの表を使う（home.nix が ~/.config-nix/sketchybar/icon_map.lua に置く。フォントと版が揃う）
local app_icons = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

local greek_uppercase = { "Α", "B", "Γ", "Δ", "E", "Z", "H", "Θ", "I", "K", "Λ", "M", "N", "Ξ", "O", "Π", "P", "Σ", "T", "Y", "Φ", "X", "Ψ", "Ω" }
local greek_lowercase = { "α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ", "μ", "ν", "ξ", "ο", "π", "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω" }

--- @class space_api
--- @field created_spaces table<string, SketchybarItem> key space_id, value SketchyBar space item instance
local space_api = {
  created_spaces = {},
  -- 矢印の見た目で、スペースごとに足す項目（左の三角・番号とアイコンの間の三角・アイコン・右の三角）。キーは番号の項目の名前
  parts = {},
}

local PL = require("helpers.powerline")

-- 矢印の見た目のスペース。tmux のウィンドウ一覧と同じ形にする:
--   今いるスペース:   ▶ 番号 ▶ アイコン ▶   （番号は明るい区切り、アイコンは1段暗い区切り）
--   ほかのスペース:     番号 ❯ アイコン     （暗い帯の上。三角は帯と同じ色で見えない）
-- どの項目も space 型にして、同じスペースを受け持たせる。スペースが無いときは sketchybar がまとめて隠す
local function add_arrow_space(space_id, space_label)
  local function part(name, props)
    props.space = space_id
    return SBAR.add("space", "space." .. space_id .. "." .. name, props)
  end

  local left = part("l", PL.arrow(PL.R, COLORS.bg0, COLORS.bg0))
  local space = SBAR.add("space", "space." .. space_id, {
    space = space_id,
    padding_left = 0,
    padding_right = 0,
    icon = {
      string = space_label,
      padding_left = 6,
      padding_right = 6,
      color = COLORS.comment,
      highlight_color = COLORS.comment,
    },
    label = { drawing = false },
    background = PL.block(COLORS.bg0),
  })
  local mid = part("m", PL.arrow(PL.R_THIN, COLORS.comment, COLORS.bg0))
  local apps = part("apps", {
    padding_left = 0,
    padding_right = 0,
    icon = { drawing = false },
    label = {
      string = "—",
      padding_left = 6,
      padding_right = 8,
      color = COLORS.comment,
      highlight_color = COLORS.comment,
      font = "sketchybar-app-font:Regular:15.0",
      y_offset = -1,
    },
    background = PL.block(COLORS.bg0),
  })
  local right = part("r", PL.arrow(PL.R, COLORS.bg0, COLORS.bg0))

  space_api.parts[space.name] = { left = left, mid = mid, apps = apps, right = right }
  return space
end

-- create a sketchybar space item  and bracket
--- @param space_id string | number The ID of the space, for aerospace, this can be "1","2"..."A","B" etc.
--- @param idx number The index of the space, for example, 1 for first space
--- @return SketchybarItem the created space item
function space_api:add_space_item(space_id, idx)
  local space_label = space_id
  if SPACES.ID_STYLE == "greek_uppercase" then
    space_label = greek_uppercase[idx] or space_id
  elseif SPACES.ID_STYLE == "greek_lowercase" then
    space_label = greek_lowercase[idx] or space_id
  end

  if BAR_STYLE == "arrows" then
    local space = add_arrow_space(space_id, space_label)
    space_api.created_spaces[space_id] = space
    return space
  end

  local space = SBAR.add("space", "space." .. space_id, {
    space = space_id,
    icon = {
      string = space_label,
      padding_left = SPACES.ITEM_PADDING,
      padding_right = 8,
      color = COLORS.overlay0, -- most muted when not focused
      highlight_color = COLORS.subtext0, -- focused space number
    },
    label = {
      padding_right = SPACES.ITEM_PADDING,
      color = COLORS.overlay0, -- unfocused: matches the number's color
      highlight_color = COLORS.subtext0, -- focused: brighter than the border, so it doesn't blend in
      font = "sketchybar-app-font:Regular:15.0",
      y_offset = -1,
    },
    padding_right = GROUP_PADDINGS,
    padding_left = 1,
    background = {
      color = COLORS.transparent, -- unfocused: no fill (see highlight_focused_space)
      border_width = 2,
      height = 28,
      border_color = COLORS.surface1,
    },
  })
  space_api.created_spaces[space_id] = space
  return space
end

-- Highlight or unhighlight a space item based on focused
--- @param space_item SketchybarItem
--- @param is_selected boolean whether the space is focused
function space_api:highlight_focused_space(space_item, is_selected)
  local parts = self.parts[space_item.name]
  if parts then
    -- 色は tmux の window-status-current-format / window-status-format と同じ
    local num_bg = is_selected and COLORS.fg1 or COLORS.bg0
    local apps_bg = is_selected and COLORS.fg3 or COLORS.bg0
    local function arrow(item, glyph, fg, bg)
      item:set({ icon = { string = glyph, color = fg, highlight_color = fg }, background = { color = bg } })
    end
    arrow(parts.left, PL.R, COLORS.bg0, num_bg)
    space_item:set({
      icon = {
        color = is_selected and COLORS.fg3 or COLORS.comment,
        highlight_color = is_selected and COLORS.fg3 or COLORS.comment,
      },
      background = { color = num_bg },
    })
    if is_selected then
      arrow(parts.mid, PL.R, COLORS.fg0, apps_bg)
    else
      arrow(parts.mid, PL.R_THIN, COLORS.comment, apps_bg)
    end
    parts.apps:set({
      label = {
        color = is_selected and COLORS.fg0 or COLORS.comment,
        highlight_color = is_selected and COLORS.fg0 or COLORS.comment,
      },
      background = { color = apps_bg },
    })
    arrow(parts.right, PL.R, is_selected and COLORS.comment or COLORS.bg0, COLORS.bg0)
    return
  end

  space_item:set({
    icon = { highlight = is_selected },
    label = { highlight = is_selected },
    background = {
      -- Only the focused space keeps a solid fill -- it's the one
      -- exception to the bar-wide transparent background, acting as an
      -- anchor showing which desktop you're on. Unfocused spaces (and
      -- everything else) are transparent.
      color = is_selected and COLORS.surface0 or COLORS.transparent,
      border_color = is_selected and COLORS.overlay1 or COLORS.surface1,
    },
  })
end

--- @param space_id string | number The ID of the space to update
--- @param app_names string[] List of application names present in the space
function space_api:update_space(space_id, app_names)
  local icon_line = ""

  for _, name in ipairs(app_names) do
    if name and name ~= "" then
      -- この表には "default" がないので、見つからないアプリは :default: にする
      local icon = app_icons[name] or ":default:"
      -- Narrow no-break space between icons -- without it, this icon
      -- font's glyphs have ~zero advance width and overlap each other.
      icon_line = icon_line .. utf8.char(0x202F) .. icon
    end
  end

  icon_line = icon_line ~= "" and icon_line or "—"

  local space = self.created_spaces[space_id]
  local parts = space and self.parts[space.name]
  -- 矢印の見た目では、アイコンは番号とは別の項目に出す
  local target = parts and parts.apps or space
  if not target then
    return
  end
  SBAR.animate("tanh", 10, function()
    target:set({ label = icon_line })
  end)
end

return space_api
