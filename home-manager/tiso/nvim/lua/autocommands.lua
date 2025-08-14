-- Autoresize base version
-- TODO: current version is super simple, need upgrade
-- 1. Store window ratio and change it by hands
-- 2. Plot windows according to this ratio (mb add some freeze)
vim.api.nvim_command('autocmd VimResized * wincmd =')

vim.api.nvim_create_autocmd("CmdlineLeave", {
  callback = function()
    local cmd_type = vim.fn.getcmdtype()
    if cmd_type == ":" then          -- Only trigger for actual Ex commands
      vim.defer_fn(function()
        if vim.fn.mode() == "n" then -- Ensure you're back in normal mode
          vim.cmd("echo ''")
        end
      end, 10000) -- 10 seconds
    end
  end
})

-- Fix docker compose lsp bad filetype
vim.api.nvim_create_autocmd({ "BufReadPost", "BufNewFile" }, {
  pattern = { '{docker-compose,compose}.{yml,yaml}', '*.compose.{yaml,yml}' },
  desc = "Fix the issue where the LSP does not start with docker-compose.",
  callback = function()
    vim.opt.filetype = "yaml.docker-compose"
  end
})

-- Autocmds placed somewhere else
-- 1. Add auto fromatting on save into lsp_config.lua
