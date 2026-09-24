---@module 'lazy'
---@type LazySpec[]
return {
  -- NOTE: Plugins can also be configured to run Lua code when they are loaded.
  --
  -- This is often very useful to both group configuration, as well as handle
  -- lazy loading plugins that don't need to be loaded immediately at startup.
  --
  -- For example, in the following configuration, we use:
  --  event = 'VimEnter'
  --
  -- which loads which-key before all the UI elements are loaded. Events can be
  -- normal autocommands events (`:help autocmd-events`).
  --
  -- Then, because we use the `opts` key (recommended), the configuration runs
  -- after the plugin has been loaded as `require(MODULE).setup(opts)`.

  { -- Useful plugin to show you pending keybinds.
    'folke/which-key.nvim',
    event = 'VimEnter',
    ---@module 'which-key'
    ---@type wk.Opts
    ---@diagnostic disable-next-line: missing-fields
    opts = {
      -- delay between pressing a key and opening which-key (milliseconds)
      delay = 0,
      icons = { mappings = vim.g.have_nerd_font },

      -- Document existing key chains
      spec = {
        { '<leader>s', group = '[S]earch', mode = { 'n', 'v' } },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } }, -- Enable gitsigns recommended keymaps first
        { 'gr', group = 'LSP Actions', mode = { 'n' } },
      },
    },
  },

  -- NOTE: Plugins can specify dependencies.
  --
  -- The dependencies are proper plugin specifications as well - anything
  -- you do for a plugin at the top level, you can do for a dependency.
  --
  -- Use the `dependencies` key to specify the dependencies of a particular plugin

  { -- Snacks: picker, explorer, and small workflow utilities.
    'folke/snacks.nvim',
    -- Snacks sets up a few global helpers/autocmds during startup, so load it early.
    priority = 1000,
    lazy = false,
    ---@module 'snacks'
    ---@type snacks.Config
    opts = {
      -- Keep this focused on the pieces used below. Snacks has many more modules,
      -- but enabling them one at a time makes it easier to tell what changed.
      explorer = { enabled = true },
      input = { enabled = true },
      lazygit = { enabled = true },
      picker = { enabled = true },
      quickfile = { enabled = true },
    },
    keys = {
      -- A few high-frequency shortcuts from the previous NVF/Snacks setup.
      { '<leader><space>', function() Snacks.picker.smart() end, desc = 'Smart Find Files' },
      { '<leader>,', function() Snacks.picker.buffers() end, desc = 'Buffers' },
      { '<leader>:', function() Snacks.picker.command_history() end, desc = 'Command History' },
      { '<leader>e', function() Snacks.explorer() end, desc = 'File Explorer' },
      { '<leader>gl', function() Snacks.lazygit() end, desc = 'LazyGit' },

      -- Preserve Kickstart's <leader>s search namespace, but back it with Snacks instead of Telescope.
      { '<leader>sh', function() Snacks.picker.help() end, desc = '[S]earch [H]elp' },
      { '<leader>sk', function() Snacks.picker.keymaps() end, desc = '[S]earch [K]eymaps' },
      { '<leader>sf', function() Snacks.picker.files() end, desc = '[S]earch [F]iles' },
      { '<leader>ss', function() Snacks.picker() end, desc = '[S]earch [S]elect Picker' },
      { '<leader>sw', function() Snacks.picker.grep_word() end, desc = '[S]earch current [W]ord', mode = { 'n', 'x' } },
      { '<leader>sg', function() Snacks.picker.grep() end, desc = '[S]earch by [G]rep' },
      { '<leader>sd', function() Snacks.picker.diagnostics() end, desc = '[S]earch [D]iagnostics' },
      { '<leader>sr', function() Snacks.picker.resume() end, desc = '[S]earch [R]esume' },
      { '<leader>s.', function() Snacks.picker.recent() end, desc = '[S]earch Recent Files ("." for repeat)' },
      { '<leader>sc', function() Snacks.picker.commands() end, desc = '[S]earch [C]ommands' },
      { '<leader><leader>', function() Snacks.picker.buffers() end, desc = '[ ] Find existing buffers' },
      { '<leader>/', function() Snacks.picker.lines() end, desc = '[/] Fuzzily search in current buffer' },
      { '<leader>s/', function() Snacks.picker.grep_buffers() end, desc = '[S]earch [/] in Open Files' },
      { '<leader>sn', function() Snacks.picker.files { cwd = vim.fn.stdpath 'config' } end, desc = '[S]earch [N]eovim files' },

      -- LSP navigation uses Snacks pickers so references/symbols stay searchable.
      { 'grr', function() Snacks.picker.lsp_references() end, desc = '[G]oto [R]eferences' },
      { 'gri', function() Snacks.picker.lsp_implementations() end, desc = '[G]oto [I]mplementation' },
      { 'grd', function() Snacks.picker.lsp_definitions() end, desc = '[G]oto [D]efinition' },
      { 'gO', function() Snacks.picker.lsp_symbols() end, desc = 'Open Document Symbols' },
      { 'gW', function() Snacks.picker.lsp_workspace_symbols() end, desc = 'Open Workspace Symbols' },
      { 'grt', function() Snacks.picker.lsp_type_definitions() end, desc = '[G]oto [T]ype Definition' },
    },
  },

  {
    'nvim-lualine/lualine.nvim',
    dependencies = {
      { 'nvim-tree/nvim-web-devicons', enabled = vim.g.have_nerd_font },
    },
    opts = function()
      local c = require 'nasapunk.palette'
      local trouble = require 'trouble'
      local symbols = trouble.statusline {
        mode = 'lsp_document_symbols',
        groups = {},
        title = false,
        filter = { range = true },
        format = '{kind_icon}{symbol.name:Normal}',
        hl_group = 'lualine_c_normal',
      }

      return {
        options = {
          theme = {
            normal = {
              a = { fg = c.canvas, bg = c.green, gui = 'bold' },
              b = { fg = c.text, bg = c.selected },
              c = { fg = c.text, bg = c.raised },
            },
            insert = { a = { fg = c.canvas, bg = c.bright_blue, gui = 'bold' } },
            visual = { a = { fg = c.canvas, bg = c.amber, gui = 'bold' } },
            replace = { a = { fg = c.canvas, bg = c.red, gui = 'bold' } },
            command = { a = { fg = c.canvas, bg = c.orange, gui = 'bold' } },
            inactive = {
              a = { fg = c.muted, bg = c.surface },
              b = { fg = c.muted, bg = c.surface },
              c = { fg = c.muted, bg = c.surface },
            },
          },
          icons_enabled = vim.g.have_nerd_font,
        },
        sections = {
          lualine_c = {
            'filename',
            { symbols.get, cond = symbols.has },
          },
          lualine_x = {
            'venv-selector',
            'lsp_status',
            'encoding',
            'fileformat',
            'filetype',
          },
        },
      }
    end,
  },

  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<cr>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xX', '<cmd>Trouble diagnostics toggle filter.buf=0<cr>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>cs', '<cmd>Trouble symbols toggle focus=false<cr>', desc = '[C]ode [S]ymbols (Trouble)' },
      { '<leader>cl', '<cmd>Trouble lsp toggle focus=false win.position=right<cr>', desc = '[C]ode [L]SP refs/defs (Trouble)' },
      { '<leader>xL', '<cmd>Trouble loclist toggle<cr>', desc = 'Location List (Trouble)' },
      { '<leader>xQ', '<cmd>Trouble qflist toggle<cr>', desc = 'Quickfix List (Trouble)' },
    },
    opts = {},
  },
}
