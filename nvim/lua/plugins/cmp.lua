return {
  -- Autocompletion plugin for Neovim
  'saadparwaiz1/blink.cmp', -- Note: The correct repo is 'saadparwaiz1/blink.cmp' (not 'saghen/blink.cmp')
  event = 'VimEnter',       -- Load on Vim startup
  version = '1.*',          -- Use the latest 1.x version
  dependencies = {
    -- Snippet engine for code templates
    {
      'L3MON4D3/LuaSnip',
      version = '2.*',
      build = (function()
        -- Skip build step on Windows or if 'make' is unavailable
        if vim.fn.has 'win32' == 1 or vim.fn.executable 'make' == 0 then
          return
        end
        return 'make install_jsregexp' -- Enable regex support for snippets
      end)(),
      dependencies = {
        -- Optional: Premade snippets for various languages
        -- Uncomment to enable
        -- {
        --   'rafamadriz/friendly-snippets',
        --   config = function()
        --     require('luasnip.loaders.from_vscode').lazy_load()
        --   end,
        -- },
      },
      opts = {},
    },
    -- Enhances Lua completions for Neovim APIs
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },
    -- Add nvim-cmp for autopairs integration
    'hrsh7th/nvim-cmp',
    'windwp/nvim-autopairs',
  },
  opts = {
    keymap = {
      preset = 'default',
    },
    appearance = {
      nerd_font_variant = 'mono',
    },
    completion = {
      documentation = { auto_show = false, auto_show_delay_ms = 500 },
    },
    sources = {
      default = { 'lsp', 'path', 'snippets', 'lazydev' },
      providers = {
        lazydev = { module = 'lazydev.integrations.blink', score_offset = 100 },
      },
    },
    snippets = {
      preset = 'luasnip',
    },
    fuzzy = {
      implementation = 'lua',
    },
    signature = {
      enabled = true,
    },
  },
  config = function(_, opts)
    -- Setup blink.cmp with provided options
    require('blink.cmp').setup(opts)

    -- Setup autopairs integration
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())
  end,
}
