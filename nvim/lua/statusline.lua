-- ステータスライン（lualine）。旧設定（~/.config/nvim/lua/ui/lualine.lua）と同じ作り・余白・並びで、色だけ palette.nix のもの
-- 左: モード | ブランチ | 変更行数 | ファイル名 | 診断　　右: ファイルの種類 | 位置（%）| 行:列
-- 旧設定から外したのは Copilot の表示だけ（計画どおり）
local p = require("palette")

-- 旧設定の色の名前（C.dark など）はそのまま使い、値を palette.nix の色にする
local C = {
  base = p.bg1,
  dark = p.bg0,
  highdark = p.bg3,
  middark = p.bg4,
  ice = p.fg1,
  fog = p.comment,
  steel = p.fg3,
  ocean = p.bg4,
  text = p.bg0, -- モードの色の地に載せる濃い文字
}

-- モードごとの地の色（\22 は矩形選択の Ctrl-V）
local mode_colors = {
  n = p.fg3,
  i = p.cyan,
  v = p.magenta,
  V = p.magenta,
  ["\22"] = p.magenta,
  c = p.yellow,
  R = p.red,
}

-- モードの横の三角の色。旧設定と同じく、地より少し明るい色にする
-- 旧設定の値を調べると、色のあるモードは地の色を白に約4割寄せた色、ノーマルモードは1段明るい灰色だった
local function lighten(hex, amount)
  local r, g, b = tonumber(hex:sub(2, 3), 16), tonumber(hex:sub(4, 5), 16), tonumber(hex:sub(6, 7), 16)
  local function mix(c)
    return math.floor(c + (255 - c) * amount + 0.5)
  end
  return string.format("#%02x%02x%02x", mix(r), mix(g), mix(b))
end
local mode_sep_colors = {
  n = p.comment,
  i = p.cyan_light, -- lighten(p.cyan, 0.4) と同じ色（palette.nix に定義）
  v = lighten(p.magenta, 0.4),
  V = lighten(p.magenta, 0.4),
  ["\22"] = lighten(p.magenta, 0.4),
  c = lighten(p.yellow, 0.4),
  R = lighten(p.red, 0.4),
}

-- モードの名前。モードが変わっても幅が変わらないよう、3文字にそろえる（アイコンと頭文字から変えた。幅は同じ）
local mode_name_map = {
  n = "NOR",
  i = "INS",
  v = "VIS",
  V = "VLN", -- 行の選択
  ["\22"] = "VBL", -- 矩形の選択
  c = "CMD",
  R = "REP",
  t = "TER",
}

local function current_mode()
  return vim.fn.mode()
end

local function mode_bg()
  local m = current_mode()
  return mode_colors[m] or mode_colors.n
end

local function mode_sep_color()
  local m = current_mode()
  return mode_sep_colors[m] or mode_sep_colors.n
end

local function mode_label()
  return (" %s "):format(mode_name_map[current_mode()] or "NOR")
end

local function seg_dynamic(comp, bold, right)
  return {
    comp,
    color = function()
      return {
        fg = C.text,
        bg = mode_bg(),
        gui = bold and "bold" or nil,
      }
    end,
    padding = { left = 1, right = right or 1 },
  }
end

local function seg_right(bg, fg, comp, bold)
  return {
    comp,
    color = { fg = fg, bg = bg, gui = bold and "bold" or nil },
    padding = { left = 1, right = 1 },
  }
end

local function seg_right_3(bg, fg, comp, bold)
  local t = type(comp) == "table" and vim.deepcopy(comp) or { comp }
  t.color = { fg = fg, bg = bg, gui = bold and "bold" or nil }
  t.padding = { left = 1, right = 1 }
  return t
end

local function seg_left(fg, bg, comp, bold)
  return {
    comp,
    color = { fg = bg, bg = fg, gui = bold and "bold" or nil },
    padding = { left = 1, right = 1 },
  }
end

local function sep_left(fg, bg)
  return {
    function()
      return "\u{e0b2}"
    end,
    color = { fg = fg, bg = bg },
    padding = { left = 0, right = 0 },
  }
end

local function sep_right_mode(next_bg)
  return {
    function()
      return "\u{e0b0}"
    end,
    color = function()
      return {
        fg = mode_sep_color(),
        bg = next_bg or C.base,
      }
    end,
    padding = { left = 0, right = 0 },
  }
end

local function sep_left_mode(next_bg)
  return {
    function()
      return "\u{e0b2}"
    end,
    color = function()
      return {
        bg = next_bg or C.base,
        fg = mode_sep_color(),
      }
    end,
    padding = { left = 0, right = 0 },
  }
end

local function sep_right_thin(sep_fg, sep_bg)
  return {
    function()
      return "\u{e0b1}"
    end,
    color = { fg = sep_fg, bg = sep_bg },
    padding = { left = 0, right = 0 },
  }
end

local function sep_left_thin(sep_fg, sep_bg)
  return {
    function()
      return "\u{e0b3}"
    end,
    color = { fg = sep_fg, bg = sep_bg },
    padding = { left = 0, right = 0 },
  }
end

-- 部品のない真ん中の部分（と、ほかのウィンドウのステータスライン）の色。両側の部品と同じ暗い色にして、1本のバーに見せる
-- 旧設定は theme = "auto" だった。Catppuccin はここを両側と同じ暗い色にしていたが、Gruvbox は明るめの色にするので指定する
local fill = { fg = C.fog, bg = C.dark }
local theme = {
  normal = { a = fill, b = fill, c = fill },
  inactive = { a = fill, b = fill, c = fill },
}

require("lualine").setup({
  options = {
    theme = theme,
    component_separators = "",
    section_separators = "",
    globalstatus = false,
    -- ツリーと no-neck-pain の余白の下には出さない
    disabled_filetypes = {
      statusline = { "NvimTree", "no-neck-pain" },
    },
  },

  sections = {
    lualine_a = {
      seg_dynamic(mode_label, true),
      sep_right_mode(C.dark),
    },

    lualine_b = {
      seg_right(C.dark, C.fog, "branch", true),
      sep_right_thin(C.fog, C.dark),
      seg_right_3(C.dark, C.fog, {
        "diff",
        symbols = {
          added = "\u{f0fe} ",
          modified = "\u{f14b} ",
          removed = "\u{f146} ",
        },
        colored = true,
        always_visible = false,
      }, true),
      sep_right_thin(C.fog, C.dark),
      seg_right(C.dark, C.fog, "filename", true),
      sep_right_thin(C.fog, C.dark),
    },

    lualine_c = {
      seg_right(C.dark, C.fog, "diagnostics", true),
    },

    lualine_x = {
      sep_left_thin(C.fog, C.dark),
      seg_left(C.dark, C.fog, "filetype", true),
    },

    lualine_y = {
      sep_left(C.dark, C.dark),
      sep_left_thin(C.fog, C.dark),
    },

    lualine_z = {
      seg_left(C.dark, C.fog, "progress", true),
      sep_left_mode(C.dark),
      -- 右の空きは1マス少なくする（画面の右端では、Ghostty の余白も同じ色で塗られて右だけ長く見える）
      seg_dynamic("location", true, 0),
    },
  },
})

-- ツリーのウィンドウは、lualine の代わりに出る標準のステータスラインも空にする（旧設定と同じ）
vim.api.nvim_create_autocmd("FileType", {
  pattern = "NvimTree",
  callback = function()
    vim.wo.statusline = " "
  end,
})
-- lualine が描かない部分（分割の線の真下の1マスと、ツリーの下の帯）も、ほかのステータスラインと同じ暗い色にする
-- 決めないと標準のステータスラインの色が見える（GitHub テーマでは青）。ツリーの下は lualine が lualine_transparent の色で塗る
local function fill_statusline()
  local names = { "StatusLine", "StatusLineNC", "NvimTreeStatusLine", "NvimTreeStatusLineNC", "lualine_transparent" }
  for _, name in ipairs(names) do
    vim.api.nvim_set_hl(0, name, fill)
  end
end
fill_statusline()
vim.api.nvim_create_autocmd("ColorScheme", { callback = vim.schedule_wrap(fill_statusline) })
