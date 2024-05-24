return {
  "mfussenegger/nvim-dap",
  dependencies = {
    "rcarriga/nvim-dap-ui",
    "nvim-neotest/nvim-nio",
    "leoluz/nvim-dap-go"
  },
  config = function ()
    local dap = require("dap")
    local dapui = require("dapui")

    require("dapui").setup({
      layouts = {
        {
          elements = {
            -- Elements can be strings or table with id and size keys.
            { id = "scopes", size = 0.25 },
            "breakpoints",
            "stacks",
            "watches"
          },
          size = 40, -- 40 columns
          position = "left" -- Can be "left" or "right"
        },
        {
          elements = {
            "repl",
            -- "console"
          },
          size = 0.25, -- 25% of total lines
          position = "bottom" -- Can be "bottom" or "top"
        }
      },
      floating = {
        max_height = nil, -- These can be integers or a float between 0 and 1.
        max_width = nil, -- Floats will be treated as percentage of your screen.
        border = "single", -- Border style. Can be "single", "double" or "rounded"
        mappings = {
          close = { "q", "<Esc>" }
        }
      },
      windows = { indent = 1 },
      render = {
        max_type_length = nil -- Can be integer or nil.
      }
    })
    require("dap-go").setup()

    dap.listeners.before.attach.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.launch.dapui_config = function()
      dapui.open()
    end
    dap.listeners.before.event_terminated.dapui_config = function()
      dapui.close()
    end
    dap.listeners.before.event_exited.dapui_config = function()
      dapui.close()
    end

    vim.keymap.set("n", "gb", dap.toggle_breakpoint, {})
    vim.keymap.set("n", "gr", dap.continue, {})
    vim.keymap.set("n", "gf", dap.step_over, {})
  end
}
