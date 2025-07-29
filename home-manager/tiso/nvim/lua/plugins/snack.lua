return {
  "folke/snacks.nvim",
  priority = 1000,
  lazy = false,
  opts = {
    -- Prevent treesitter and lsp attach to bigfile
    bigfile = {
      size = 15 * 1024 * 1024, -- 15 MB
    },
    -- Delete big files without disrupt layout
    -- WARN: clean buffer dont stay empty, it became
    -- bufdelete = {},

    dashboard = {
      sections = {
        { section = "header" },
        { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
        { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
        { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
        { section = "startup" },
      },
    },
    gitbrowse = {},

    lazygit = {
      win = {
        height = 0.9,
        width = 0.9,
      },
    },
    -- TODO: add scroll preview window
    picker = {
      prompt = "❭ ",
      sources = {
        explorer = {
          layout = {
            auto_hide = { "input" }
          }
        }
      },
      win = {
        input = {
          keys = {
            ["<Tab>"] = { "list_down", mode = { "i", "n" } },
            ["<S-Tab>"] = { "list_up", mode = { "i", "n" } },
            ["<A-CR>"] = { "select_and_next", mode = { "i", "n" } },
            ["<S-CR>"] = { "select_and_prev", mode = { "i", "n" } },
            ["<c-k>"] = { "preview_scroll_up", mode = { "i", "n" } },
            ["<c-j>"] = { "preview_scroll_down", mode = { "i", "n" } },
          },
        },
        list = {
          keys = {
            ["<Tab>"] = "list_down",
            ["<S-Tab>"] = "list_up",
            ["<A-Enter>"] = "select_and_next",
            ["<S-Enter>"] = "select_and_prev",
            ["<c-k>"] = "preview_scroll_up",
            ["<c-j>"] = "preview_scroll_down",
          },
        },
      },
    },
    rename = {},

    -- TODO: decide do i need to change treesitter scope to this
    -- scope = {
    -- },

    terminal = {
      enabled = true,
      win = {
        -- height = 0.3,
        style = "normal",
        position = "float",
      },
      keys = {
        gf = false,
      }
    },
    quickfile = {},
  },
  keys = {
    -- Lazygit
    { "<leader>dd", function() Snacks.lazygit() end,                                              desc = "Lazygit open" },
    { "<leader>ds", function() Snacks.lazygit.log_file() end,                                     desc = "Lazygit open current file log" },
    { "<leader>da", function() Snacks.lazygit.log() end,                                          desc = "Lazygit open log" },

    -- Picker
    { "<leader>r",  function() Snacks.picker.resume() end,                                        desc = "Resume last picker" },
    -- Find
    { "<leader>fc", function() Snacks.picker.files({ cwd = vim.fn.stdpath("config") }) end,       desc = "Find NeoVim Config File" },
    { "<leader>fC", function() Snacks.picker.files({ cwd = vim.fn.expand("$HOME/.config") }) end, desc = "Find Config File" },
    { "<leader>fb", function() Snacks.picker.buffers() end,                                       desc = "Buffers" },
    { "<leader>ff", function() Snacks.picker.files() end,                                         desc = "Find Files" },
    { "<leader>fg", function() Snacks.picker.git_files() end,                                     desc = "Find Git Files" },
    { "<leader>fr", function() Snacks.picker.recent() end,                                        desc = "Recent" },
    { "<leader>fp", function() Snacks.picker.projects() end,                                      desc = "Projects" },

    -- Search
    { '<leader>s"', function() Snacks.picker.registers() end,                                     desc = "Registers" },
    { "<leader>s:", function() Snacks.picker.command_history() end,                               desc = "Command History" },
    { "<leader>s/", function() Snacks.picker.search_history() end,                                desc = "Search History" },
    { "<leader>sc", function() Snacks.picker.commands() end,                                      desc = "Commands" },
    { "<leader>sg", function() Snacks.picker.grep() end,                                          desc = "LiveGrep" },
    { "<leader>sh", function() Snacks.picker.help() end,                                          desc = "Help Pages" },
    { "<leader>sj", function() Snacks.picker.jumps() end,                                         desc = "Jumps" },
    { "<leader>sM", function() Snacks.picker.man() end,                                           desc = "Man Pages" },
    { "<leader>sm", function() Snacks.picker.marks() end,                                         desc = "Marks" },
    { "<leader>su", function() Snacks.picker.undo() end,                                          desc = "Undo History" },

    -- LSP
    { "<leader>lx", function() Snacks.picker.diagnostics() end,                                   desc = "Diagnostics" },
    { "<leader>lX", function() Snacks.picker.diagnostics_buffer() end,                            desc = "Diagnostics buffer" },
    { "<leader>ld", function() Snacks.picker.lsp_definitions() end,                               desc = "Goto Definition" },
    { "<leader>lr", function() Snacks.picker.lsp_references() end,                                desc = "References" },
    { "<leader>li", function() Snacks.picker.lsp_implementations() end,                           desc = "Goto Implementation" },
    { "<leader>ly", function() Snacks.picker.lsp_type_definitions() end,                          desc = "Goto T[y]pe Definition" },
    { "<leader>ls", function() Snacks.picker.lsp_symbols() end,                                   desc = "LSP Symbols" },
    -- Rename LSP
    { "<leader>lf", function() Snacks.rename.rename_file() end,                                   desc = "Rename file lsp" },

    -- Git
    { "<leader>gb", function() Snacks.picker.git_branches() end,                                  desc = "Git Branches" },
    { "<leader>gl", function() Snacks.picker.git_log() end,                                       desc = "Git Log" },
    { "<leader>gL", function() Snacks.picker.git_log_line() end,                                  desc = "Git Log Line" },
    { "<leader>gs", function() Snacks.picker.git_status() end,                                    desc = "Git Status" },
    { "<leader>gS", function() Snacks.picker.git_stash() end,                                     desc = "Git Stash" },
    { "<leader>gd", function() Snacks.picker.git_diff() end,                                      desc = "Git Diff (Hunks)" },
    { "<leader>gf", function() Snacks.picker.git_log_file() end,                                  desc = "Git Log File" },
    -- Gitbrowse
    { "<leader>gg", function() Snacks.gitbrowse() end,                                            desc = "Gitbrowse repo" },

    -- Terminal
    { "<leader>dm", function() Snacks.terminal.open() end,                                        desc = "Terminal open" },
    { "<leader>d,", function() Snacks.terminal.toggle() end,                                      desc = "Terminal toggle" },
  },
}
