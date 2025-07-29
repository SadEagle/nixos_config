return {
  -- FIX: seems so trash and unnatural, bad switch with flash default line
  -- Current: Line_1 -> Line_default -> Line_2, should Line_1 -> Line_2
  "nvim-lualine/lualine.nvim",
  -- cond = false,
  init = function()
    vim.opt.laststatus = 3   -- which windows has statusline (2 - all; 3 - only last)
    vim.opt.showmode = false -- disable duplicate mode
  end,
  main = "lualine",
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = "auto",
    },
  },
}
