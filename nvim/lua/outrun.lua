-- Outrun（自作の配色。Night と Electric の2種類）。nvim/colors/outrun-night.lua・outrun-electric.lua から呼ぶ
-- 色は VS Code のテーマ「Outrun Night / Electric Meets Synthwave」（edevars/outrun-meets-synthwave の themes/*.json）を参考にした。
-- 元のテーマにはライセンスのファイルが無いので、ファイルは写さず、色の値だけを参考に Neovim の色分けへ当てはめて書いた
-- 2種類の違いは背景・バー・文字の色だけ（コードの色分けは同じ）。VS Code の決まり（scope）と Neovim の色分けの対応は、各行のコメントのとおり
local M = {}

M.variants = {
  ["outrun-night"] = { bg = "#161130", bg_dark = "#0c0a20", fg = "#ebecf8" }, -- Outrun Night（Outrun Dark）
  ["outrun-electric"] = { bg = "#0c0a20", bg_dark = "#090819", fg = "#f2f3f7" }, -- Outrun Electric（Outrun Contrast。もっと暗い）
}

function M.load(name)
  local variant = M.variants[name]
  vim.cmd("highlight clear")
  vim.g.colors_name = name
  vim.o.background = "dark"


  -- 元のテーマの色（VS Code の名前）
  local c = {
    bg = variant.bg, -- editor.background
    bg_dark = variant.bg_dark, -- sideBar.background・statusBar.background
    fg = variant.fg, -- editor.foreground
    white = "#ffffff",
    comment = "#546a90", -- comment
    line_nr = "#484f7d", -- editorLineNumber.foreground
    selection = "#484f7d", -- editor.selectionBackground
    border = "#763b8c", -- input.border
    cursor = "#ff2e97", -- editorCursor.foreground
    list_sel = "#d86bff", -- list.activeSelectionBackground
    string = "#7984d1", -- string
    number = "#ffd400", -- constant.numeric
    constant = "#df85ff", -- constant.language・constant.character・constant.other
    keyword = "#ff2afc", -- keyword
    storage = "#42c6ff", -- storage
    storage_type = "#ff2e97", -- storage.type
    class = "#a875ff", -- entity.name.class・entity.name.type
    inherited = "#ffd400", -- entity.other.inherited-class
    func = "#ff9b50", -- entity.name.function・support.function
    tag = "#42c6ff", -- entity.name.tag
    attr = "#ff2afc", -- entity.other.attribute-name
    support_const = "#a3d6e0", -- support.constant
    support_type = "#42c6ff", -- support.type・support.class
    invalid = "#cf433e", -- invalid
    namespace = "#1ea8fc", -- meta.use
    keyword_other = "#6494a9", -- keyword.other
    property_value = "#cccccc", -- meta.property-value
    json_key = "#d86bff", -- support.type.property-name.json
    heading = "#5dcdfd", -- entity.name.section.markdown
    markup_punct = "#1ea8fc", -- punctuation.definition.*.markdown
    template = "#b6ced8", -- meta.template.expression
    deleted = "#e61f44", -- markup.deleted
    inserted = "#a6e22e", -- markup.inserted
    changed = "#f7b83d", -- markup.changed
    git_add = "#a7da1e", -- markup.inserted.git_gutter
  }

  -- VS Code に無い色（計算）。a を b に t だけ寄せた色
  local function mix(a, b, t)
    local function ch(hex, i)
      return tonumber(hex:sub(i, i + 1), 16)
    end
    local out = "#"
    for i = 2, 6, 2 do
      out = out .. string.format("%02x", math.floor(ch(a, i) + (ch(b, i) - ch(a, i)) * t + 0.5))
    end
    return out
  end
  -- カーソル行（元のテーマは背景と同じで光らない）: 背景に文字の色を少し混ぜる
  local cursor_line = mix(c.bg, c.fg, 0.07)
  -- 差分の背景（ほかのテーマと同じ計算: 色を背景に混ぜる）
  local diff_add, diff_delete = mix(c.bg, c.git_add, 0.15), mix(c.bg, c.deleted, 0.15)
  local diff_change, diff_text = mix(c.bg, c.storage, 0.15), mix(c.bg, c.storage, 0.3)

  local groups = {
    -- 画面の部品
    Normal = { fg = c.fg, bg = c.bg },
    NormalNC = { fg = c.fg, bg = c.bg },
    NormalFloat = { fg = c.fg, bg = c.bg_dark },
    FloatBorder = { fg = c.border, bg = c.bg_dark },
    FloatTitle = { fg = c.list_sel, bg = c.bg_dark, bold = true },
    Cursor = { fg = c.bg, bg = c.cursor },
    CursorLine = { bg = cursor_line },
    CursorColumn = { bg = cursor_line },
    ColorColumn = { bg = cursor_line },
    CursorLineNr = { fg = c.cursor, bold = true },
    LineNr = { fg = c.line_nr },
    SignColumn = { bg = c.bg },
    FoldColumn = { fg = c.line_nr, bg = c.bg },
    Folded = { fg = c.comment, bg = cursor_line },
    Visual = { bg = c.selection },
    Search = { fg = c.white, bg = c.selection }, -- editor.findMatchBackground
    IncSearch = { fg = c.bg, bg = c.cursor },
    CurSearch = { fg = c.bg, bg = c.cursor },
    Substitute = { fg = c.bg, bg = c.number },
    MatchParen = { fg = c.number, bold = true },
    Pmenu = { fg = c.fg, bg = c.bg_dark },
    PmenuSel = { fg = c.white, bg = c.list_sel }, -- list.activeSelection
    PmenuSbar = { bg = c.bg_dark },
    PmenuThumb = { bg = c.selection },
    StatusLine = { fg = c.fg, bg = c.bg_dark },
    StatusLineNC = { fg = c.comment, bg = c.bg_dark },
    TabLine = { fg = c.comment, bg = c.bg_dark },
    TabLineFill = { bg = c.bg_dark },
    TabLineSel = { fg = c.white, bg = c.bg },
    WinSeparator = { fg = c.bg_dark },
    VertSplit = { fg = c.bg_dark },
    EndOfBuffer = { fg = c.bg },
    NonText = { fg = c.line_nr },
    Whitespace = { fg = c.line_nr },
    SpecialKey = { fg = c.line_nr },
    Directory = { fg = c.storage },
    Title = { fg = c.heading, bold = true },
    ErrorMsg = { fg = c.deleted },
    WarningMsg = { fg = c.changed },
    MoreMsg = { fg = c.storage },
    Question = { fg = c.storage },
    QuickFixLine = { bg = cursor_line },
    WildMenu = { fg = c.white, bg = c.list_sel },
    -- 差分
    DiffAdd = { bg = diff_add },
    DiffDelete = { bg = diff_delete },
    DiffChange = { bg = diff_change },
    DiffText = { bg = diff_text },
    Added = { fg = c.git_add },
    Removed = { fg = c.deleted },
    Changed = { fg = c.changed },
    GitSignsAdd = { fg = c.git_add }, -- markup.inserted.git_gutter
    GitSignsChange = { fg = c.changed },
    GitSignsDelete = { fg = c.deleted },
    -- 診断（エラーは diff.deleted、警告は diff.changed、情報は storage、ヒントは string の色）
    DiagnosticError = { fg = c.deleted },
    DiagnosticWarn = { fg = c.changed },
    DiagnosticInfo = { fg = c.storage },
    DiagnosticHint = { fg = c.string },
    DiagnosticOk = { fg = c.git_add },
    DiagnosticUnderlineError = { undercurl = true, sp = c.deleted },
    DiagnosticUnderlineWarn = { undercurl = true, sp = c.changed },
    DiagnosticUnderlineInfo = { undercurl = true, sp = c.storage },
    DiagnosticUnderlineHint = { undercurl = true, sp = c.string },

    -- コード（昔からの名前）
    Comment = { fg = c.comment, italic = true }, -- comment
    String = { fg = c.string }, -- string
    Character = { fg = c.constant }, -- constant.character
    Number = { fg = c.number }, -- constant.numeric
    Float = { fg = c.number },
    Boolean = { fg = c.constant }, -- constant.language
    Constant = { fg = c.constant }, -- constant.other
    Identifier = { fg = c.fg }, -- variable（色の指定なし）
    Function = { fg = c.func }, -- entity.name.function
    Statement = { fg = c.keyword }, -- keyword
    Keyword = { fg = c.keyword },
    Conditional = { fg = c.keyword },
    Repeat = { fg = c.keyword },
    Label = { fg = c.keyword },
    Exception = { fg = c.keyword },
    Operator = { fg = c.keyword }, -- keyword.operator
    PreProc = { fg = c.keyword },
    Include = { fg = c.keyword },
    Define = { fg = c.keyword },
    Macro = { fg = c.func },
    Type = { fg = c.class, italic = true }, -- entity.name.type
    StorageClass = { fg = c.storage }, -- storage
    Structure = { fg = c.storage_type },
    Typedef = { fg = c.storage_type },
    Special = { fg = c.template },
    SpecialChar = { fg = c.constant },
    Tag = { fg = c.tag },
    Delimiter = { fg = c.fg },
    Underlined = { fg = c.markup_punct, underline = true },
    Error = { fg = c.invalid }, -- invalid
    Todo = { fg = c.bg, bg = c.number, bold = true },

    -- コード（treesitter）
    ["@comment"] = { link = "Comment" },
    ["@variable"] = { fg = c.fg }, -- variable（色の指定なし）
    ["@variable.parameter"] = { fg = c.white }, -- variable.parameter
    ["@variable.builtin"] = { fg = c.storage, italic = true }, -- variable.language.this
    ["@variable.member"] = { fg = c.fg },
    ["@property"] = { fg = c.fg },
    ["@constant"] = { fg = c.constant }, -- constant.other
    ["@constant.builtin"] = { fg = c.constant }, -- constant.language
    ["@module"] = { fg = c.namespace }, -- meta.use・keyword.other.namespace
    ["@string"] = { fg = c.string },
    ["@string.escape"] = { fg = c.constant }, -- constant.character.escape
    ["@string.regexp"] = { fg = c.string },
    ["@string.special"] = { fg = c.template },
    ["@character"] = { fg = c.constant },
    ["@number"] = { fg = c.number },
    ["@number.float"] = { fg = c.number },
    ["@boolean"] = { fg = c.constant },
    ["@function"] = { fg = c.func }, -- entity.name.function
    ["@function.builtin"] = { fg = c.func }, -- support.function
    ["@function.call"] = { fg = c.fg }, -- 呼び出しは色を付けない（entity.name.function - meta.function-call）
    ["@function.method"] = { fg = c.func },
    ["@function.method.call"] = { fg = c.fg },
    ["@function.macro"] = { fg = c.func },
    ["@constructor"] = { fg = c.class }, -- entity.name.class
    ["@keyword"] = { fg = c.keyword }, -- keyword
    ["@keyword.function"] = { fg = c.storage_type }, -- storage.type（function など）
    ["@keyword.type"] = { fg = c.storage_type }, -- storage.type（class・interface など）
    ["@keyword.modifier"] = { fg = c.storage }, -- storage.modifier（const・static など）
    ["@keyword.import"] = { fg = c.keyword },
    ["@keyword.return"] = { fg = c.keyword },
    ["@keyword.operator"] = { fg = c.keyword },
    ["@keyword.exception"] = { fg = c.keyword },
    ["@operator"] = { fg = c.keyword },
    ["@type"] = { fg = c.class, italic = true }, -- entity.name.type
    ["@type.builtin"] = { fg = c.support_type, italic = true }, -- support.type
    ["@type.definition"] = { fg = c.class, italic = true },
    ["@attribute"] = { fg = c.attr },
    ["@tag"] = { fg = c.tag }, -- entity.name.tag
    ["@tag.attribute"] = { fg = c.attr }, -- entity.other.attribute-name
    ["@tag.delimiter"] = { fg = c.template },
    ["@punctuation"] = { fg = c.fg },
    ["@punctuation.special"] = { fg = c.template }, -- meta.template.expression（${}）
    ["@property.json"] = { fg = c.json_key }, -- support.type.property-name.json
    ["@markup.heading"] = { fg = c.heading, bold = true }, -- entity.name.section.markdown
    ["@markup.strong"] = { bold = true },
    ["@markup.italic"] = { italic = true },
    ["@markup.link"] = { fg = c.markup_punct }, -- markup.underline.link
    ["@markup.link.url"] = { fg = c.markup_punct, underline = true },
    ["@markup.raw"] = { fg = c.property_value }, -- markup.raw.inline
    ["@markup.list"] = { fg = c.markup_punct },
    ["@markup.quote"] = { fg = c.comment, italic = true },
    ["@diff.plus"] = { fg = c.inserted }, -- markup.inserted
    ["@diff.minus"] = { fg = c.deleted }, -- markup.deleted
    ["@diff.delta"] = { fg = c.changed }, -- markup.changed
  }

  for name, attrs in pairs(groups) do
    vim.api.nvim_set_hl(0, name, attrs)
  end

  -- ターミナルの16色（terminal.ansi*。緑は青系 #62a9cf のまま）
  local ansi = {
    "#283034", "#ff2e97", "#62a9cf", "#ffd400", "#42c6ff", "#ff2afc", "#42c6ff", "#d9e0e9",
    "#435056", "#ff2e97", "#add0e5", "#ffd400", "#42c6ff", "#ff2afc", "#42c6ff", "#f4f6f9",
  }
  for i, color in ipairs(ansi) do
    vim.g["terminal_color_" .. (i - 1)] = color
  end
end

return M
