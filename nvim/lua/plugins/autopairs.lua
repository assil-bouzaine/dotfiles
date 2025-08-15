return {
  'windwp/nvim-autopairs',
  event = 'InsertEnter',  -- Load when entering insert mode
  dependencies = {
    'hrsh7th/nvim-cmp',  -- Needed for completion integration
  },
  opts = {
    -- Enable fast wrap (matching pair jumps outside when cursor is inside)
    fast_wrap = {
      map = '<M-e>',      -- Alt+e to jump outside pairs
      chars = { '{', '[', '(', '"', "'" },  -- Characters to wrap
      pattern = [=[[%'%"%>%]%)%}%,]]=],     -- Pattern to detect pairs
      end_key = '$',      -- Key to jump to end
      keys = 'qwertyuiopzxcvbnmasdfghjkl', -- Keys for fast wrap positions
      check_comma = true, -- Don't add pair when comma is present
      highlight = 'Search', -- Highlight group for wrap targets
      highlight_grey = 'Comment', -- Highlight for other positions
    },
    -- Disable autopairs when cursor is after a $ (for LaTeX)
    disable_filetype = { 'TelescopePrompt', 'spectre_panel', 'tex' },
    -- Ignore these patterns (like alphanumeric characters)
    ignored_next_char = '[%w%.]',
    -- Enable after quote (don't pair if previous char is \)
    enable_afterquote = true,
    -- Enable check bracket (don't add closing bracket if line already has one)
    enable_check_bracket_line = true,
    -- Enable treesitter integration (uses treesitter to check if pair is valid)
    enable_treesitter = true,
    -- Break undo sequence when pairs are added
    break_undo = true,
  },
  config = function(_, opts)
    require('nvim-autopairs').setup(opts)

    -- Setup cmp integration
    local cmp_autopairs = require('nvim-autopairs.completion.cmp')
    local cmp = require('cmp')
    cmp.event:on('confirm_done', cmp_autopairs.on_confirm_done())

    -- Keymaps
    local Rule = require('nvim-autopairs.rule')
    local npairs = require('nvim-autopairs')

    -- Basic pair rules (these are usually enabled by default)
    npairs.add_rules {
      Rule(' ', ' '):with_pair(function(opts)
        local pair = opts.line:sub(opts.col - 1, opts.col)
        return vim.tbl_contains({ '()', '[]', '{}' }, pair)
      end),
      Rule('( ', ' )'):with_pair(function() return false end):with_move(function(opts)
        return opts.prev_char:match('.%)') ~= nil
      end):use_key(')'),
      Rule('{ ', ' }'):with_pair(function() return false end):with_move(function(opts)
        return opts.prev_char:match('.%}') ~= nil
      end):use_key('}'),
      Rule('[ ', ' ]'):with_pair(function() return false end):with_move(function(opts)
        return opts.prev_char:match('.%]') ~= nil
      end):use_key(']'),
    }

    -- Custom rules
    -- Add spaces between parentheses
    npairs.add_rules {
      Rule('(', ')'):with_pair(function() return false end), -- Disable automatic pairing
      Rule('(', ' )'):with_pair(function() return false end),
      Rule('{', '}'):with_pair(function() return false end),
      Rule('{', ' }'):with_pair(function() return false end),
      Rule('[', ']'):with_pair(function() return false end),
      Rule('[', ' ]'):with_pair(function() return false end),
    }

    -- Arrow key on javascript
    npairs.add_rules {
      Rule('%(.*%)%s*%=>$', ' {  }', { 'typescript', 'typescriptreact', 'javascript' })
        :use_regex(true)
        :set_end_pair_length(2),
    }

    -- Keymaps for manual pairing
    vim.keymap.set('i', '<M-p>', function() require('nvim-autopairs').autopairs_cr() end, { noremap = true, desc = 'Auto-pair new line' })
    vim.keymap.set('i', '<M-P>', function() require('nvim-autopairs').autopairs_bs() end, { noremap = true, desc = 'Delete pair' })
    vim.keymap.set('i', '<M-s>', function() require('nvim-autopairs').smart_enter() end, { noremap = true, desc = 'Smart enter' })
  end,
}