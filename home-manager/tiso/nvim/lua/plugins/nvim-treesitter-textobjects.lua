return {
  "nvim-treesitter/nvim-treesitter-textobjects",
  dependencies = "nvim-treesitter/nvim-treesitter",
  main = "nvim-treesitter.configs",
  opts = {
    textobjects = {
      select = {
        enable = true,
        -- Automatically jump forward to textobj
        lookahead = true,

        keymaps = {
          -- Most standart
          ["af"] = { query = "@function.outer", desc = "Select outer function" },
          ["if"] = { query = "@function.inner", desc = "Select inner function" },
          ["ac"] = { query = "@class.outer", desc = "Select outer class" },
          ["ic"] = { query = "@class.inner", desc = "Select inner class" },
          -- Parameter block
          ["ap"] = { query = "@parameter.outer", desc = "Select outer parameter" },
          ["ip"] = { query = "@parameter.inner", desc = "Select inner parameter" },
          -- Select block
          ["ab"] = { query = "@block.outer", desc = "Select outer block" },
          ["ib"] = { query = "@block.inner", desc = "Select inner block" },
          -- Select comment
          ["a/"] = { query = "@comment.outer", desc = "Select outer comment" },
          ["i/"] = { query = "@comment.inner", desc = "Select inner comment" },
          -- Select return
          ["ar"] = { query = "@return.outer", desc = "Select outer return" },
          ["ir"] = { query = "@return.inner", desc = "Select inner return" },
          -- Select call
          ["aa"] = { query = "@call.outer", desc = "Select outer call" },
          ["ia"] = { query = "@call.inner", desc = "Select inner call" },

          -- Select loop
          ["al"] = { query = "@loop.outer", desc = "Select outer loop" },
          ["il"] = { query = "@loop.inner", desc = "Select inner loop" },
          -- Select conditional
          ["ad"] = { query = "@conditional.outer", desc = "Select outer conditional" },
          ["id"] = { query = "@conditional.inner", desc = "Select inner conditional" },
          -- Selectr scope
          ["as"] = { query = "@local.scope", query_group = "locals", desc = "Select language scope" },
        },
        -- selection_modes
        include_surrounding_whitespace = false, -- True broken (select extra non-empty lines)
      },

      -- Swap params
      swap = {
        enable = true,
        swap_next = {
          ["<a-k>"] = { query = "@parameter.inner", desc = "Swap with next param" }
        },
        swap_previous = {
          ["<a-j>"] = { query = "@parameter.inner", desc = "Swap with prev param" },
        },
      },
    },
  },
}
