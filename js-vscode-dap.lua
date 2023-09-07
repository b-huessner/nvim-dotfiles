return {
  {
    "microsoft/vscode-js-debug",
    build = "npm install --legacy-peer-deps && npx gulp vsDebugServerBundle && mv dist out",
  },
  {
    "mxsdev/nvim-dap-vscode-js",
    opts = {
      debugger_path = vim.fn.stdpath "data" .. "/lazy/vscode-js-debug",
      adapters = { "pwa-node" },
    },
  }
}
