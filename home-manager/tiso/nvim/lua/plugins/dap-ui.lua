return {
  "rcarriga/nvim-dap-ui",
  dependencies = {
    "mfussenegger/nvim-dap",
    "nvim-neotest/nvim-nio"
  },
  main = "dapui",
  opts = {},
  keys = {
    { '<leader>wr', function() require 'dapui'.toggle() end, desc = "DapUI toggle" },
  }
}
