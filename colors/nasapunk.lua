-- A restrained workstation palette: neutrals first, signals by role.
vim.o.termguicolors = true
vim.o.background = 'dark'
vim.cmd 'highlight clear'
vim.g.colors_name = 'nasapunk'

local c = require 'nasapunk.palette'
local set = vim.api.nvim_set_hl
local groups = {
  Normal = { fg = c.text, bg = c.canvas },
  NormalNC = { fg = c.text, bg = c.canvas },
  NormalFloat = { fg = c.text, bg = c.raised },
  FloatBorder = { fg = c.line, bg = c.raised },
  FloatTitle = { fg = c.bright, bg = c.raised, bold = true },
  WinSeparator = { fg = c.line },
  CursorLine = { bg = c.surface },
  CursorColumn = { bg = c.surface },
  ColorColumn = { bg = c.surface },
  LineNr = { fg = c.muted },
  CursorLineNr = { fg = c.orange, bold = true },
  SignColumn = { bg = c.canvas },
  FoldColumn = { fg = c.muted, bg = c.canvas },
  Folded = { fg = c.muted, bg = c.surface },
  EndOfBuffer = { fg = c.canvas },
  NonText = { fg = c.line },
  Whitespace = { fg = c.line },
  SpecialKey = { fg = c.muted },
  Visual = { fg = c.bright, bg = c.selected },
  Search = { fg = c.canvas, bg = c.amber },
  IncSearch = { fg = c.canvas, bg = c.orange },
  CurSearch = { link = 'IncSearch' },
  Substitute = { link = 'IncSearch' },
  MatchParen = { fg = c.bright, bg = c.selected, bold = true },
  Pmenu = { fg = c.text, bg = c.raised },
  PmenuSel = { fg = c.bright, bg = c.selected, bold = true },
  PmenuKind = { fg = c.bright_blue, bg = c.raised },
  PmenuExtra = { fg = c.muted, bg = c.raised },
  PmenuSbar = { bg = c.raised },
  PmenuThumb = { bg = c.line },
  StatusLine = { fg = c.text, bg = c.raised },
  StatusLineNC = { fg = c.muted, bg = c.surface },
  TabLine = { fg = c.muted, bg = c.surface },
  TabLineSel = { fg = c.bright, bg = c.selected },
  TabLineFill = { bg = c.surface },
  WildMenu = { fg = c.bright, bg = c.selected },
  WinBar = { fg = c.text, bg = c.canvas },
  WinBarNC = { fg = c.muted, bg = c.canvas },
  Directory = { fg = c.green },
  Title = { fg = c.bright, bold = true },
  Question = { fg = c.green },
  MoreMsg = { fg = c.green },
  WarningMsg = { fg = c.amber },
  ErrorMsg = { fg = c.bright_red },
  ModeMsg = { fg = c.text },
  Conceal = { fg = c.muted },
  SpellBad = { undercurl = true, sp = c.red },
  SpellCap = { undercurl = true, sp = c.blue },
  SpellRare = { undercurl = true, sp = c.amber },
  DiffAdd = { fg = c.green, bg = c.surface },
  DiffChange = { fg = c.amber, bg = c.surface },
  DiffDelete = { fg = c.bright_red, bg = c.surface },
  DiffText = { fg = c.canvas, bg = c.amber },
  Added = { fg = c.green },
  Changed = { fg = c.amber },
  Removed = { fg = c.bright_red },
  DiagnosticError = { fg = c.bright_red },
  DiagnosticWarn = { fg = c.amber },
  DiagnosticInfo = { fg = c.bright_blue },
  DiagnosticHint = { fg = c.green },
  DiagnosticUnderlineError = { undercurl = true, sp = c.red },
  DiagnosticUnderlineWarn = { undercurl = true, sp = c.amber },
  DiagnosticUnderlineInfo = { undercurl = true, sp = c.blue },
  DiagnosticUnderlineHint = { undercurl = true, sp = c.green },
  LspReferenceText = { bg = c.raised },
  LspReferenceRead = { bg = c.raised },
  LspReferenceWrite = { bg = c.selected },
  Comment = { fg = c.muted },
  Constant = { fg = c.amber },
  String = { fg = c.green },
  Character = { link = 'String' },
  Number = { fg = c.amber },
  Boolean = { fg = c.amber },
  Identifier = { fg = c.text },
  Function = { fg = c.bright_blue },
  Statement = { fg = c.bright },
  Conditional = { fg = c.bright },
  Repeat = { fg = c.bright },
  Operator = { fg = c.muted },
  PreProc = { fg = c.amber },
  Type = { fg = c.green },
  Special = { fg = c.bright_blue },
  Delimiter = { fg = c.muted },
  Underlined = { fg = c.bright_blue, underline = true },
  Error = { fg = c.bright_red },
  Todo = { fg = c.canvas, bg = c.amber, bold = true },
  ['@variable'] = { fg = c.text },
  ['@variable.builtin'] = { fg = c.bright },
  ['@function'] = { link = 'Function' },
  ['@function.builtin'] = { fg = c.bright_blue },
  ['@keyword'] = { link = 'Statement' },
  ['@type'] = { link = 'Type' },
  ['@property'] = { fg = c.text },
  ['@module'] = { fg = c.bright_blue },
  ['@string'] = { link = 'String' },
  ['@comment'] = { link = 'Comment' },
  ['@markup.heading'] = { fg = c.bright, bold = true },
  ['@markup.link.url'] = { fg = c.bright_blue, underline = true },
  ['@markup.link.label'] = { fg = c.bright_blue },
  GitSignsAdd = { fg = c.green },
  GitSignsChange = { fg = c.amber },
  GitSignsDelete = { fg = c.bright_red },
  SnacksPickerMatch = { fg = c.green, bold = true },
  SnacksPickerCursorLine = { fg = c.bright, bg = c.selected },
  TroubleNormal = { fg = c.text, bg = c.canvas },
}

for name, opts in pairs(groups) do
  set(0, name, opts)
end

vim.g.terminal_color_0 = c.canvas
vim.g.terminal_color_1 = c.red
vim.g.terminal_color_2 = c.green
vim.g.terminal_color_3 = c.amber
vim.g.terminal_color_4 = c.blue
vim.g.terminal_color_5 = c.muted
vim.g.terminal_color_6 = c.bright_blue
vim.g.terminal_color_7 = c.text
vim.g.terminal_color_8 = c.line
vim.g.terminal_color_9 = c.bright_red
vim.g.terminal_color_10 = c.green
vim.g.terminal_color_11 = c.amber
vim.g.terminal_color_12 = c.bright_blue
vim.g.terminal_color_13 = c.muted
vim.g.terminal_color_14 = c.bright_blue
vim.g.terminal_color_15 = c.bright
