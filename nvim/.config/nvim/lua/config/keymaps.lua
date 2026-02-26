-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local M = {}

-- Helper function for creating keymaps (utility, not a binding)
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

M.setup_navigation = function()
  map("n", "<C-f>", "<cmd>silent !tmux neww tmux-sessionizer<CR>")
  map("n", "<M-h>", "<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>")
  map("n", "<M-t>", "<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>")
  map("n", "<M-n>", "<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>")
  map("n", "<M-s>", "<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>")

  map("i", "jj", "<esc>")
  map("i", "kk", "<esc>")
end

M.setup_window = function()
  map("n", "<M-w>", "<cmd>tabclose<CR>")
end

M.setup_editing = function()
  -- map('n', '<C-s>', '<cmd>w<CR>')
  -- map('n', '<C-q>', '<cmd>q<CR>')
end

M.setup_plugins = function()
  map("n", "<leader>gs", ":G<CR>")

  map("n", "<leader>gn", ":Gitsigns toggle_current_line_blame<CR>", {
    desc = "Toggle current line blame",
  })
end

M.setup_search = function()
  -- Center the line when navigating search results
  map("n", "n", "nzzzv", { desc = "Next search result and center" })
  map("n", "N", "Nzzzv", { desc = "Previous search result and center" })

  -- C-u and C-d are centered on the current line
  map("n", "<C-u>", "<C-u>zz", { desc = "Center around current line" })
  map("n", "<C-d>", "<C-d>zz", { desc = "Center around current line" })
end

M.setup = function()
  M.setup_navigation()
  M.setup_editing()
  M.setup_search()
  M.setup_plugins()
  M.setup_window()
end

M.setup()

return M
