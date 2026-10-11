-- アプリ名 → アイコンの対応表。旧設定の sketchybar-app-font-bg ではなく、nixpkgs の sketchybar-app-font と
-- 同じパッケージの表を使う（home.nix が ~/.config-nix/sketchybar/icon_map.lua に置く。フォントと版が揃う）
local app_icons = dofile(os.getenv("HOME") .. "/.config-nix/sketchybar/icon_map.lua")

local greek_uppercase = { "Α", "B", "Γ", "Δ", "E", "Z", "H", "Θ", "I", "K", "Λ", "M", "N", "Ξ", "O", "Π", "P", "Σ", "T", "Y", "Φ", "X", "Ψ", "Ω" }
local greek_lowercase = { "α", "β", "γ", "δ", "ε", "ζ", "η", "θ", "ι", "κ", "λ", "μ", "ν", "ξ", "ο", "π", "ρ", "σ", "τ", "υ", "φ", "χ", "ψ", "ω" }

--- @class space_api
--- @field created_spaces table<string, SketchybarItem> key space_id, value SketchyBar space item instance
local space_api = {
  created_spaces = {},
}

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

  SBAR.animate("tanh", 10, function()
    self.created_spaces[space_id]:set({ label = icon_line })
  end)
end

return space_api
