return {
  {
    "nvim-treesitter/nvim-treesitter",
    main = "nvim-treesitter.configs",
    build = ":TSUpdate",
    -- https://github.com/folke/lazy.nvim/discussions/889
    event = { "BufReadPre", "BufNewFile" },
    init = function()
      vim.wo.foldmethod = 'expr'
      vim.wo.foldexpr = 'v:lua.vim.treesitter.foldexpr()'

      vim.filetype.add({
        pattern = { [".*/hypr/.*%.conf"] = "hyprlang" },
      })
    end,
    opts = {
      ensure_installed = {
        "bash",
        "fish",
        "lua",
        "go",
        "python",
        "c",
        "cpp",
        "make",
        "cmake",
        "sql",

        "nix",
        "html",
        "css",
        "javascript",
        "typescript",

        "nginx",
        -- Non language
        "toml",
        "yaml",
        "json",
        "json5",
        "hyprlang",
        "dockerfile",
        "gitignore",
        "gitcommit",
        "git_rebase",
        "git_config",
        "gitattributes",
        "markdown",
        "markdown_inline",
      },
      highlight = {
        enable = true,
      },
      indent = {
        enable = true,
        -- HTML lsp ignore <head> indentation, but treesitter one no
        disable = { "python", "html" },
      },
      incremental_selection = {
        enable = true,
        keymaps = {
          init_selection = "<a-,>",
          node_incremental = "<a-m>",
          scope_incremental = "<a-,>",
          node_decremental = "<a-.>",
        }
      },
    },
  },

  -- Treesitter indentation fix
  -- Python
  { "Vimjas/vim-python-pep8-indent" },
}
