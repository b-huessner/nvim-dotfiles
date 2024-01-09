-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys

  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.siltens ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

if vim.lsp.inlay_hint then
  vim.keymap.set("n", "<leader>uh", function()
    vim.lsp.inlay_hint(0, nil)
  end, { desc = "Toggle Inlay Hints" })
end

map("n", "<C-q>", "<cmd>BufferLineCyclePrev<cr>", { desc = "Prev buffer" })
map("n", "<C-e>", "<cmd>BufferLineCycleNext<cr>", { desc = "Next buffer" })
