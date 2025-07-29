return {
  "mfussenegger/nvim-dap",
  config = function()
    -- Signs styles, cattpuccin highlights
    -- TODO: add background color
    vim.fn.sign_define("DapBreakpoint", { text = "⬤", texthl = "DapBreakpoint", linehl = "", numhl = "" })
    vim.fn.sign_define('DapStopped', { text = '', texthl = 'DapBreakpoint', linehl = '', numhl = '' })
    -- TODO: add break condition/log probably with custom menu fold
    vim.fn.sign_define("DapBreakpointCondition",
      { text = "⬤", texthl = "DapBreakpointCondition", linehl = "", numhl = "" })
    vim.fn.sign_define("DapLogPoint", { text = "◆", texthl = "DapLogPoint", linehl = "", numhl = "" })

    local dap = require 'dap'
    -- Python debug
    dap.adapters.python = function(cb, config)
      if config.request == 'attach' then
        ---@diagnostic disable-next-line: undefined-field
        local port = (config.connect or config).port
        ---@diagnostic disable-next-line: undefined-field
        local host = (config.connect or config).host or '127.0.0.1'
        cb({
          type = 'server',
          port = assert(port, '`connect.port` is required for a python `attach` configuration'),
          host = host,
          options = {
            source_filetype = 'python',
          },
        })
      else
        cb({
          type = 'executable',
          -- Global debugpy package
          command = '/usr/bin/python',
          args = { '-m', 'debugpy.adapter' },
          options = {
            source_filetype = 'python',
          },
        })
      end
    end
    dap.configurations.python = {
      {
        -- Nvim-dap options
        type = 'python',
        request = 'launch',
        name = "Launch file",

        -- Debugpy options
        program = "${file}", -- This configuration will launch the current file if used.
        pythonPath = function()
          local venv_var = os.getenv("VIRTUAL_ENV")
          if venv_var == nil then
            return "/usr/bin/python"
          else
            return venv_var .. "/bin/python"
          end
        end
      },
    }

    -- TODO: add lua debug
  end,
  keys = {
    -- :help dap-mapping
    -- Internally call run() if new
    { '<leader>wd', function() require 'dap'.continue() end,          desc = "Dap start/continue debug" },
    -- Set breakpoints
    { '<leader>wt', function() require 'dap'.toggle_breakpoint() end, desc = "Dap toggle break point" },
    -- TODO: add conditional/log breakpoint [ur](https://github.com/mfussenegger/nvim-dap/blob/7aade9e99bef5f0735cf966e715b3ce45515d786/doc/dap.txt#L789)

    { '<leader>wp', function() require 'dap'.run_last() end,          desc = "Dap return prev debug" },
    { '<leader>wR', function() require 'dap'.restart() end,           desc = "Dap restart last breakpoint" },
    { '<leader>wq', function() require 'dap'.disconnect() end,        desc = "Dap terminate" },
    -- Line by line operations
    { '<leader>wu', function() require 'dap'.step_out() end,          desc = "Dap step out" },
    { '<leader>wi', function() require 'dap'.step_into() end,         desc = "Dap step into" },
    { '<leader>wo', function() require 'dap'.step_over() end,         desc = "Dap step over" },
  }
}
