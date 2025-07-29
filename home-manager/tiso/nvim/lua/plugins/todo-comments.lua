return {
  "folke/todo-comments.nvim",
  dependencies = { "nvim-lua/plenary.nvim" },
  -- NOTE: by default dont load and wait keys
  lazy = false,
  main = "todo-comments",
  opts = {
    signs = false,
  },

  keys = {
    { "<leader>st", function() Snacks.picker.todo_comments() end,                                 desc = "Todo all" },
    { "<leader>sT", function() Snacks.picker.todo_comments({ keywords = { "TODO", "FIX" } }) end, desc = "Todo/Fix" },
  },
}
