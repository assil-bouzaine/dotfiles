return { -- Plugin to prevent hard-to-recover mistakes by limiting certain actions.
    'm4xshen/hardtime.nvim',
    lazy = false,
    dependencies = { 'MunifTanjim/nui.nvim' },
    opts = {
      restriction_mode = 'block',
      max_count = 100,
    },
  }