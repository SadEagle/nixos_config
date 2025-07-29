-- Check symbols before cursor
local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

return {
  'saghen/blink.cmp',
  version = '*',
  opts = {
    -- Disable cmdline
    cmdline = {
      enabled = false
    },
    completion = {
      -- Add autocompletion
      accept = { auto_brackets = { enabled = true } },
      -- Completion read only previous coursor
      keyword = { range = 'prefix' },
      menu = {
        auto_show = true,
      },
      documentation = { auto_show = true, auto_show_delay_ms = 120 },
    },

    keymap = {
      ['<A-w>'] = { 'show', 'show_documentation', 'hide_documentation', 'fallback' },
      ['<A-q>'] = { 'cancel', 'fallback' },
      ['<A-e>'] = { 'hide', 'show', 'fallback' },
      -- TODO: add 2nd option return to base
      ['<A-s>'] = { function(cmp) cmp.show({ providers = { 'snippets' } }) end, 'show', 'fallback' },

      -- TODO: add check if 1 variant then accept
      ['<Tab>'] = { 'snippet_forward', 'select_next', function(cmp) if has_words_before() then return cmp.show() else return end end, 'fallback' },
      ['<S-Tab>'] = { 'snippet_backward', 'select_prev', function(cmp) if has_words_before() then return cmp.show() else return end end, 'fallback' },
      -- FIX: signature dont appear when accept info
      ['<CR>'] = { 'select_and_accept', 'fallback' },
      -- WARN: little bit tricky because somehow <a-cr> equal to <cr>
      ['<A-CR>'] = { 'fallback' },

      ['<Up>'] = { 'select_prev', 'fallback' },
      ['<Down>'] = { 'select_next', 'fallback' },
      ['<A-u>'] = { 'scroll_documentation_up', 'fallback' },
      ['<A-d>'] = { 'scroll_documentation_down', 'fallback' },

      ['<A-k>'] = { 'show_signature', 'hide_signature', 'fallback' },
    },

    appearance = {
      use_nvim_cmp_as_default = true,
      nerd_font_variant = 'mono',
    },

    sources = {
      -- Select completion sources according file type or node
      -- FIX: dont work comment blocking
      default = function(ctx)
        local success, node = pcall(vim.treesitter.get_node)
        if success and node and vim.tbl_contains({ 'comment', 'line_comment', 'block_comment' }, node:type()) then
          return { 'buffer' }
        else
          return { 'lsp', 'path', 'snippets', 'buffer', 'markdown' }
        end
      end,
      providers = {
        markdown = {
          name = 'RenderMarkdown',
          module = 'render-markdown.integ.blink',
          fallbacks = { 'lsp' },
        },
      },
    },

    -- FIX: signature dont work with autobrackets
    signature = {
      enabled = true,
      window = {
        show_documentation = true,
      }
    },
  },
  -- allows extending the providers array elsewhere in your config
  -- without having to redefine it
  opts_extend = { "sources.default" },
}
