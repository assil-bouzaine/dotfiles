return {
  'vyfor/cord.nvim',
  event = 'VeryLazy', -- Load when needed
  enabled = true, -- Ensure plugin is active
  opts = {
    -- Basic presence settings
    client_id = '1157438221865717891', -- Default Neovim client ID
    neovim_cord = true, -- Show as "Neovim" in Discord
    
    -- Display options
    logo = {
      file_path = vim.fn.stdpath('config')..'/neovim-logo.png', -- Optional custom logo
      hover_text = "Editing in Neovim", -- Tooltip text
    },
    
    -- What to show in Discord
    rich_presence = {
      show_file = true, -- Current filename
      show_line = true, -- Current line number
      show_workspace = true, -- Project folder name
    },
    
    -- Filetype icons (requires Nerd Font)
    filetypes = {
      lua = '',
      python = '',
      javascript = '',
      typescript = '',
      -- Add more from https://www.nerdfonts.com/cheat-sheet
    },
    
    -- Don't show for these buffers
    blacklist = { 'NvimTree', 'TelescopePrompt', 'dashboard' },
  },
  config = function(_, opts)
    require('cord').setup(opts)
    
    -- Manual refresh command (optional)
    vim.api.nvim_create_user_command('DiscordPresence', function()
      require('cord').update_presence()
      vim.notify('Discord presence updated!')
    end, {})
  end
}