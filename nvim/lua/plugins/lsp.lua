return {
  -- Main LSP Configuration
  'neovim/nvim-lspconfig',
  dependencies = {
    -- Automatically install LSPs and related tools to stdpath for Neovim
    { 'mason-org/mason.nvim', opts = {} }, -- Mason for managing LSP servers
    { 'mason-org/mason-lspconfig.nvim' }, -- Bridges Mason and lspconfig
    { 'WhoIsSethDaniel/mason-tool-installer.nvim' }, -- Installs additional tools

    -- Useful status updates for LSP (shows progress in the bottom-right)
    { 'j-hui/fidget.nvim', opts = {} },

    -- Lua LSP for Neovim config, runtime, and plugins
    {
      'folke/lazydev.nvim',
      ft = 'lua',
      opts = {
        library = {
          -- Load luvit types when `vim.uv` is found
          { path = '${3rd}/luv/library', words = { 'vim%.uv' } },
        },
      },
    },

    -- Provides extra capabilities for LSP (used for completion)
    { 'saghen/blink.cmp' },
  },
  config = function()
    -- Brief aside: **What is LSP?**
    --
    -- LSP (Language Server Protocol) enables features like go-to-definition,
    -- autocompletion, and diagnostics by connecting Neovim to external language
    -- servers (e.g., lua_ls for Lua, ts_ls for JavaScript/TypeScript).
    --
    -- This configuration sets up LSP servers for Lua and JavaScript/TypeScript,
    -- integrates with Mason for automatic installation, and defines keymaps
    -- for common LSP actions. See `:help lsp` and `:help lspconfig` for details.

    -- Define keymaps when an LSP attaches to a buffer
    vim.api.nvim_create_autocmd('LspAttach', {
      group = vim.api.nvim_create_augroup('kickstart-lsp-attach', { clear = true }),
      callback = function(event)
        -- Helper function to set LSP keymaps with descriptions
        local map = function(keys, func, desc, mode)
          mode = mode or 'n'
          vim.keymap.set(mode, keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
        end

        -- Rename variable under cursor (works across files if supported)
        map('grn', vim.lsp.buf.rename, '[R]e[n]ame')

        -- Execute code actions (e.g., fix errors or refactor)
        map('gra', vim.lsp.buf.code_action, '[G]oto Code [A]ction', { 'n', 'x' })

        -- Find references for the word under cursor
        map('grr', require('telescope.builtin').lsp_references, '[G]oto [R]eferences')

        -- Jump to implementation (useful for interfaces or abstract types)
        map('gri', require('telescope.builtin').lsp_implementations, '[G]oto [I]mplementation')

        -- Jump to definition (where a symbol is defined)
        map('grd', require('telescope.builtin').lsp_definitions, '[G]oto [D]efinition')

        -- Jump to declaration (e.g., header files in C)
        map('grD', vim.lsp.buf.declaration, '[G]oto [D]eclaration')

        -- Fuzzy find symbols in the current document
        map('gO', require('telescope.builtin').lsp_document_symbols, 'Open Document Symbols')

        -- Fuzzy find symbols in the entire workspace
        map('gW', require('telescope.builtin').lsp_dynamic_workspace_symbols, 'Open Workspace Symbols')

        -- Jump to type definition
        map('grt', require('telescope.builtin').lsp_type_definitions, '[G]oto [T]ype Definition')

        -- Compatibility function for Neovim 0.10 and 0.11
        local function client_supports_method(client, method, bufnr)
          if vim.fn.has 'nvim-0.11' == 1 then
            return client:supports_method(method, bufnr)
          else
            return client.supports_method(method, { bufnr = bufnr })
          end
        end

        -- Highlight references under cursor on hold
        local client = vim.lsp.get_client_by_id(event.data.client_id)
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_documentHighlight, event.buf) then
          local highlight_augroup = vim.api.nvim_create_augroup('kickstart-lsp-highlight', { clear = false })
          vim.api.nvim_create_autocmd({ 'CursorHold', 'CursorHoldI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.document_highlight,
          })
          vim.api.nvim_create_autocmd({ 'CursorMoved', 'CursorMovedI' }, {
            buffer = event.buf,
            group = highlight_augroup,
            callback = vim.lsp.buf.clear_references,
          })
          vim.api.nvim_create_autocmd('LspDetach', {
            group = vim.api.nvim_create_augroup('kickstart-lsp-detach', { clear = true }),
            callback = function(event2)
              vim.lsp.buf.clear_references()
              vim.api.nvim_clear_autocmds { group = 'kickstart-lsp-highlight', buffer = event2.buf }
            end,
          })
        end

        -- Toggle inlay hints if supported by the LSP
        if client and client_supports_method(client, vim.lsp.protocol.Methods.textDocument_inlayHint, event.buf) then
          map('<leader>th', function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled { bufnr = event.buf })
          end, '[T]oggle Inlay [H]ints')
        end
      end,
    })

    -- Configure diagnostics display
    vim.diagnostic.config {
      severity_sort = true, -- Sort diagnostics by severity
      float = { border = 'rounded', source = 'if_many' }, -- Rounded borders for floating windows
      underline = { severity = vim.diagnostic.severity.ERROR }, -- Underline errors
      signs = vim.g.have_nerd_font and {
        text = {
          [vim.diagnostic.severity.ERROR] = '󰅚 ',
          [vim.diagnostic.severity.WARN] = '󰀪 ',
          [vim.diagnostic.severity.INFO] = '󰋽 ',
          [vim.diagnostic.severity.HINT] = '󰌶 ',
        },
      } or {},
      virtual_text = {
        source = 'if_many',
        spacing = 2,
        format = function(diagnostic)
          local diagnostic_message = {
            [vim.diagnostic.severity.ERROR] = diagnostic.message,
            [vim.diagnostic.severity.WARN] = diagnostic.message,
            [vim.diagnostic.severity.INFO] = diagnostic.message,
            [vim.diagnostic.severity.HINT] = diagnostic.message,
          }
          return diagnostic_message[diagnostic.severity]
        end,
      },
    }

    -- Get LSP capabilities from blink.cmp
    local capabilities = require('blink.cmp').get_lsp_capabilities()

    -- Define LSP servers for Lua and JavaScript/TypeScript
    local servers = {
      lua_ls = {
        settings = {
          Lua = {
            completion = { callSnippet = 'Replace' },
            diagnostics = {
              -- Recognize Neovim globals
              globals = { 'vim' },
              -- Optionally disable noisy warnings
              -- disable = { 'missing-fields' },
            },
            workspace = {
              checkThirdParty = false, -- Avoid prompts for third-party libraries
            },
            telemetry = { enable = false }, -- Disable telemetry
          },
        },
      },
      ts_ls = {
        filetypes = { 'javascript', 'javascriptreact', 'typescript', 'typescriptreact' },
        settings = {
          typescript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
          javascript = {
            inlayHints = {
              includeInlayParameterNameHints = 'all',
              includeInlayParameterNameHintsWhenArgumentMatchesName = false,
              includeInlayFunctionParameterTypeHints = true,
              includeInlayVariableTypeHints = true,
              includeInlayPropertyDeclarationTypeHints = true,
              includeInlayFunctionLikeReturnTypeHints = true,
              includeInlayEnumMemberValueHints = true,
            },
          },
        },
      },
    }

    -- Ensure servers and tools are installed via Mason
    local ensure_installed = vim.tbl_keys(servers or {})
    vim.list_extend(ensure_installed, {
      'stylua', -- Formatter for Lua
      'prettier', -- Formatter for JavaScript/TypeScript
    })
    require('mason-tool-installer').setup { ensure_installed = ensure_installed }

    -- Setup Mason and lspconfig integration
    require('mason-lspconfig').setup {
      ensure_installed = {}, -- Explicitly empty; mason-tool-installer handles installs
      automatic_installation = false,
      handlers = {
        function(server_name)
          local server = servers[server_name] or {}
          server.capabilities = vim.tbl_deep_extend('force', {}, capabilities, server.capabilities or {})
          require('lspconfig')[server_name].setup(server)
        end,
      },
    }
  end,
}