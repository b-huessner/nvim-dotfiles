local lazy_dir = vim.fn.stdpath("data") .. "/lazy"

return {
  {
    "mfussenegger/nvim-dap",
    dependencies = {
      {
        "mxsdev/nvim-dap-vscode-js",
        opts = {
          debugger_path = string.format("%s/vscode-js-debug/", lazy_dir),
          adapters = { "pwa-node" }
        }
      },
      { "theHamsta/nvim-dap-virtual-text", config = true },
      {
        "rcarriga/nvim-dap-ui",
        keys = {
          { "<leader>du", function() require("dapui").toggle({ }) end, desc = "Dap UI" },
          { "<leader>de", function() require("dapui").eval() end, desc = "Eval", mode = {"n", "v"} },
        },
        config = function(_, opts)
          local dap = require("dap")
          local dapui = require("dapui")
          dapui.setup(opts)
          dap.listeners.after.event_initialized["dapui_config"] = function()
            dapui.open({})
          end
          dap.listeners.before.event_terminated["dapui_config"] = function()
            dapui.close({})
          end
          dap.listeners.before.event_exited["dapui_config"] = function()
            dapui.close({})
          end
        end,
      },
      {
        "microsoft/vscode-js-debug",
        build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out"
      }
    },
    config = function()
      local dap = require "dap"

      dap.configurations.typescript = {
        {
          type = "pwa-node",
          request = "attach",
          name = "Attach to Localhost",
          port = 9229,
          sourceMaps = true,
          address = "0.0.0.0",
          cwd = vim.fn.getcwd() .. "/be",
          localRoot = "${workspaceFolder}/be",
          remoteRoot = "/home/cloud/app",
          skipFiles = { "<node_internals>/**", "**/node_modules/**" },
          resolveSourceMapLocations = { "${workspaceFolder}/be/dist/**/*.js", "${workspaceFolder}/be/**", "!**/node_modules/**" },
        },
      }
    end,
    keys = {
      { "<leader>dB", function() reqgire("dap").set_breakpoint(vim.fn.input('Breakpoint condition: ')) end, desc = "Breakpoint Condition" },
      { "<leader>db", function() require("dap").toggle_breakpoint() end, desc = "Toggle Breakpoint" },
      { "<leader>dc", function() require("dap").continue() end, desc = "Continue" },
      { "<leader>dC", function() require("dap").run_to_cursor() end, desc = "Run to Cursor" },
      { "<leader>dg", function() require("dap").goto_() end, desc = "Go to line (no execute)" },
      { "<leader>di", function() require("dap").step_into() end, desc = "Step Into" },
      { "<leader>dj", function() require("dap").down() end, desc = "Down" },
      { "<leader>dk", function() require("dap").up() end, desc = "Up" },
      { "<leader>dl", function() require("dap").run_last() end, desc = "Run Last" },
      { "<leader>do", function() require("dap").step_out() end, desc = "Step Out" },
      { "<leader>dO", function() require("dap").step_over() end, desc = "Step Over" },
      { "<leader>dp", function() require("dap").pause() end, desc = "Pause" },
      { "<leader>dr", function() require("dap").repl.toggle() end, desc = "Toggle REPL" },
      { "<leader>ds", function() require("dap").session() end, desc = "Session" },
      { "<leader>dt", function() require("dap").terminate() end, desc = "Terminate" },
      { "<leader>dw", function() require("dap.ui.widgets").hover() end, desc = "Widgets" },
    },
  },
  {
    "folke/which-key.nvim",
    optional = true,
    opts = {
      defaults = {
        ["<leader>d"] = { name = "+debug" },
        ["<leader>da"] = { name = "+adapters" },
      },
    },
  }
}
