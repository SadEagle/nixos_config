return {
  'Xemptuous/sqlua.nvim',
  lazy = true,
  cmd = { 'SQLua', 'SQLuaEdit' },
  config = function() require('sqlua').setup() end
}
