return {
  "neovim/nvim-lspconfig",

  config = function()
    -- LSP / Liters / Formatter
    -- Nix
    local nvim_lsp = require("lspconfig")
    nvim_lsp.nixd.setup({
      settings = {
        nixd = {
          formatting = {
            command = { "nixfmt" },
          },
        },
      },
    })

    vim.lsp.enable('nixd')
    vim.lsp.enable('nil')
    -- Python
    vim.lsp.enable('pyright')
    vim.lsp.enable('ruff')
    -- C/C++
    vim.lsp.enable('clangd')
    -- CMake
    -- vim.lsp.enable('cmake')
    -- Docker
    vim.lsp.enable('dockerls')
    -- Docker compose
    vim.lsp.enable('docker_compose_language_service')
    -- Lua
    vim.lsp.enable('lua_ls')
    -- Bash
    vim.lsp.enable('bashls')
    -- HTML/CSS/JS/JSON
    vim.lsp.enable("html")
    vim.lsp.enable("cssls")
    vim.lsp.enable('eslint')
    vim.lsp.enable('jsonls')

    -- Typescript
    vim.lsp.enable('ts_ls')

    -- Diagnostic insert mode
    vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(
      vim.lsp.diagnostic.on_publish_diagnostics, {
        -- delay update diagnostics
        update_in_insert = true,
      }
    )

    -- Lsp interaction
    -- NOTE: most lsp keys init into snacks.picker
    vim.api.nvim_create_autocmd("LspAttach", {
      callback = function(args)
        vim.keymap.set('n', '<leader>lR', "<cmd>lua vim.lsp.buf.rename()<cr>", { desc = 'Rename variable' })
        -- Mostly useless because of write autocmd below
        -- vim.keymap.set('n', '<F1>', '<cmd>lua vim.lsp.buf.format()<cr>', { desc = 'Format current file' })
      end,
      desc = 'LSP actions',
    })
    -- Use ty hover only
    -- https://docs.astral.sh/ruff/editors/setup/#neovim
    vim.api.nvim_create_autocmd("LspAttach", {
      group = vim.api.nvim_create_augroup('lsp_attach_disable_ruff_hover', { clear = true }),
      callback = function(args)
        local client = vim.lsp.get_client_by_id(args.data.client_id)
        if client == nil then
          return
        end
        if client.name == 'ruff' then
          -- Disable hover in favor of Pyright
          client.server_capabilities.hoverProvider = false
        end
      end,
      desc = 'LSP: Disable hover capability from Ruff',
    })

    -- Use Linter on save
    vim.api.nvim_create_autocmd("BufWritePre", {
      pattern = "*",
      callback = function()
        -- Formatter
        vim.lsp.buf.format({
          async = false, -- Ensure formatting happens before save
          filter = function(client)
            return client.supports_method("textDocument/formatting")
          end
        })
      end
    })

    vim.diagnostic.config {
      signs = false,
      underline = true,
      virtual_text = true,
      virtual_lines = false,
      update_in_insert = true,
      float = {
        -- source = 'always',
        header = false,
        border = 'rounded',
        focusable = false,
      },
    }
    -- Keybind
    -- Low res window show error
    vim.keymap.set("n", "<leader>e", "<cmd>lua vim.diagnostic.open_float(0, {scope='line'})<CR>",
      { desc = "Full diagnostic" })
  end,
}
