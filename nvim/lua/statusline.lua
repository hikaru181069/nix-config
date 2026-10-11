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

-- モードの横の三角の色（地と同じ色）
local mode_sep_colors = mode_colors

-- Nerd Font のアイコン。見えない文字なので文字コードで書く
local mode_icon_map = {
  n = "\u{f0176}",
  i = "\u{f040}",
  v = "\u{f0208}",
  V = "\u{f0208}",
  ["\22"] = "\u{f0208}",
  c = "\u{f4b5}",
  R = "\u{f06d4}",
}

local mode_name_map = {
  n = "N",
  i = "I",
  v = "V",
  V = "V",
  ["\22"] = "V",
  c = "C",
  R = "R",
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
  local m = current_mode()
  local icon = mode_icon_map[m] or "\u{f36f}"
  local name = mode_name_map[m] or "N"
  return (" %s %s "):format(icon, name)
end

local function seg_dynamic(comp, bold)
  return {
    comp,
    color = function()
      return {
        fg = C.text,
        bg = mode_bg(),
        gui = bold and "bold" or nil,
      }
    end,
    padding = { left = 1, right = 1 },
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

require("lualine").setup({
  options = {
    theme = "auto",
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
      seg_dynamic("location", true),
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
