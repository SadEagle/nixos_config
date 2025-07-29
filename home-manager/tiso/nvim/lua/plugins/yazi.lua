return {
  "mikavilpas/yazi.nvim",
  init = function()
    -- Block netrw plugin load
    vim.g.loaded_netrw = 1
    vim.g.loaded_netrwPlugin = 1
  end,
  dependencies = { "folke/snacks.nvim" },
  event = "VeryLazy",
  opts = {
    open_for_directories = true,
    keys = {
      open_file_in_horizontal_split = "<c-s>",
      grep_in_directory = "<c-x>",
    }
  },
  keys = {
    { "<leader>du", "<cmd>Yazi<cr>",        desc = "Yazi open current file path" },
    { "<leader>di", "<cmd>Yazi cwd<cr>",    desc = "Yazi open nvim pwd" },
    { '<leader>do', "<cmd>Yazi toggle<cr>", desc = "Yazi resume last session" },
  },
}
