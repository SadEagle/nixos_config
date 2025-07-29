local opt = vim.opt

-- Colorscheme (correlate with theme)
opt.bg = "dark"

-- Default indent
opt.tabstop = 2       -- tab equal 4 spaces
opt.shiftwidth = 2    -- <<, >> symbols amount spaces
opt.expandtab = true  -- expand tab to spaces
opt.autoindent = true -- copy intend current line for next

-- Folding params
-- Current fold-type expr. With params set in treesitter plugin
opt.foldlevel = 7   -- Optimal folding level
opt.foldnestmax = 9 -- Limit level for code folding

-- Set numbers
opt.number = true
opt.relativenumber = true

-- Search
opt.hlsearch = true   -- hl search result
opt.ignorecase = true -- ignore case when searching
opt.smartcase = true  -- automatically became case-sensetive when exist both upper and lower cases

opt.scrolloff = 4     -- amount rows before cursor
opt.wrap = false      -- words are not split if more than expected
-- opt.whichwrap:=<,>,h,l,[,] -- go next line at the end current (default can't)

-- Hide tabline
opt.showtabline = 0

-- TODO: make hl to current buffer only. It's little bit annoy when see hl in notconnected windows
-- Need create own hl group. For a while dont know how to do it
-- https://github.com/neovim/neovim/issues/1824
-- vim.cmd("hi clear Search")
-- vim.cmd("hi clear IncSearc")
-- vim.cmd("setlocal winhl=Search:BufOnlyHl,IncSearch:BufOnlyHl")

-- backspace
opt.backspace = "indent,eol,start" -- allow backspace on indent, end of line or insert mode start position

-- clipboard
opt.clipboard = "unnamedplus" -- use system clipboard "+", primary selection clipboard as '*'

-- split windows
opt.splitright = true -- split vertical window to the right
opt.splitbelow = true -- split horizontal window to the bottom

-- Statusline custom, simple
-- opt.laststatus = 2 -- which windows has statusline (2 - all; 3 - only last)
-- vim.opt.statusline = '    %f'
-- opt.ruler = false -- Disable cursor position and position %
-- opt.showmode = false -- Disable neovim mode

-- Hard wrap
opt.wrap = true        -- Wrap by end of screen
opt.breakindent = true -- Breaked line continue with same indent
opt.linebreak = true   -- Break by word rather than character

-- Split right side every time
-- opt.splitright = true

-- vim.o.fillchars = "fold: "  -- Repeated symbol rightside folded line
-- Show fold line with highlight
-- https://github.com/neovim/neovim/pull/20750
-- Impossible to update line, like add comment
vim.o.foldtext = ''
-- Add highlight to folded lines
-- Good colors: #312244 #144552
vim.cmd("highlight Folded guibg=#1b3a4b guifg=#2c3b5c")
