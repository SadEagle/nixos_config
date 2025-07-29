-- Custom scripts
-- local functions = require("functions")

-- Main keymap module
vim.g.mapleader = " "
local map = vim.keymap.set


-- Reverse tab
map('i', '<s-tab>', '<C-D>', { desc = "Reverse tab", remap = true })
-- Clear highlight
map("n", "<a-n>", ":nohl<CR>", { desc = "Clear search highlights", silent = true })
-- Comment
map("n", "<leader>/", "gcc", { desc = "Comment toggle", remap = true })
map("v", "<leader>/", "gc", { desc = "Comment toggle", remap = true })

-- TODO: do i need it?
-- -- Next snippet
-- vim.keymap.set({ 'i', 's' }, '<Tab>', function()
--    if vim.snippet.active({ direction = 1 }) then
--      return '<Cmd>lua vim.snippet.jump(1)<CR>'
--    else
--      return '<Tab>'
--    end
--  end, { expr = true })

-- Windows
-- Switch windows
-- Split tab and C-i signals by setting both (more info :h C-i)
map("n", "<c-i>", "<C-i>")
-- Work with buffer
map("n", "<tab>", "<cmd>bnext<CR>", { desc = "Buffer goto next" })
map("n", "<s-tab>", "<cmd>bprev<CR>", { desc = "Buffer goto prev" })
-- Cursor navigation across windows
map("n", "<c-h>", "<C-w>h", { desc = "Switch window left" })
map("n", "<c-l>", "<C-w>l", { desc = "Switch window right" })
map("n", "<c-j>", "<C-w>j", { desc = "Switch window down" })
map("n", "<c-k>", "<C-w>k", { desc = "Switch window up" })
-- Resize window using <ctrl> arrow keys
map("n", "<c-up>", "<cmd>resize +2<cr>", { desc = "Increase Window Height" })
map("n", "<c-down>", "<cmd>resize -2<cr>", { desc = "Decrease Window Height" })
map("n", "<c-right>", "<cmd>vertical resize -2<cr>", { desc = "Decrease Window Width" })
map("n", "<c-left>", "<cmd>vertical resize +2<cr>", { desc = "Increase Window Width" })

-- TODO:
-- 1. decide how to manage multiple windows
-- 2. Need make auto resize multiple wiundows by ratio
-- -- Move windows
-- map("n", "<c-a-r>", "<c-w>r", { desc = "Rotate window left" })
-- map("n", "<c-a-r>", "<c-w>R", { desc = "Rotate window left" })
-- map("n", "<c-a-x>", "<c-w>x", { desc = "Rotate window left" })
-- map("n", "<c-a-h>", "<c-w>H", { desc = "Rotate window left" })
-- map("n", "<c-a-l>", "<c-w>L", { desc = "Rotate window right" })
-- map("n", "<c-a-j>", "<c-w>J", { desc = "iwitch window down" })
-- map("n", "<c-a-k>", "<c-w>K", { desc = "iwitch window up" })

-- Tabs
map("n", "<c-tab>", "<cmd>tabNext<CR>", { desc = "Buffer goto next" })
map("n", "<c-s-tab>", "<cmd>tabprevious<CR>", { desc = "Buffer goto prev" })

-- TODO: add tabulation keybinds
-- -- Tabs management
-- map("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
-- map("n", "<leader>tx", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
-- map("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- NOTE: add important default hotkeys
--

-- Basic reverse keybind
local esc_symbol = vim.api.nvim_replace_termcodes("<Esc>", true, true, true)
-- WARN: for now expect same size replace word, (return cursor)
local pair_vals = {
  ["true"] = "false", -- Bool
  ["false"] = "true",
  ["True"] = "False",
  ["False"] = "True",
  ["=="] = "!=", -- Equations
  ["!="] = "==",
  ["<="] = ">=",
  [">="] = "<=",
  ["<"] = ">",
  [">"] = "<",
}

local function toggle_value()
  -- TODO: if variable - make not variable

  local row, col = unpack(vim.api.nvim_win_get_cursor(0))

  -- vim.fn.expand also works for spaces before word. Skip this case
  local line = vim.api.nvim_get_current_line()
  local cur_symbol = line:sub(col + 1, col + 1)
  local key_word = nil
  if cur_symbol ~= " " then
    key_word = vim.fn.expand("<cword>")
  end
  if pair_vals[key_word] ~= nil then
    vim.api.nvim_feedkeys("ciw" .. pair_vals[key_word] .. esc_symbol, "n", true)
  end
end
vim.keymap.set('n', '<a-`>', toggle_value, { expr = true, desc = 'Toggle values' })
