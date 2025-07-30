-- Custom Keybindings Configuration
-- This file provides a centralized location for all custom key mappings
-- This is a template structure - add your actual keybindings as needed

local M = {}

-- Helper function for creating keymaps (utility, not a binding)
local function map(mode, lhs, rhs, opts)
  opts = opts or {}
  opts.noremap = opts.noremap == nil and true or opts.noremap
  opts.silent = opts.silent == nil and true or opts.silent
  vim.keymap.set(mode, lhs, rhs, opts)
end

-- Section placeholders for logical organization
-- Uncomment and implement these functions as needed

M.setup_navigation = function()
  -- Add navigation keybindings here
  map('n', '<C-f>', '<cmd>silent !tmux neww tmux-sessionizer<CR>')
  map('n', '<M-h>', '<cmd>silent !tmux neww tmux-sessionizer -s 0<CR>')
  map('n', '<M-t>', '<cmd>silent !tmux neww tmux-sessionizer -s 1<CR>')
  map('n', '<M-n>', '<cmd>silent !tmux neww tmux-sessionizer -s 2<CR>')
  map('n', '<M-s>', '<cmd>silent !tmux neww tmux-sessionizer -s 3<CR>')
end

M.setup_window = function()
  map('n', '<M-w>', '<cmd>tabclose<CR>')
end

M.setup_editing = function()
  -- Add editing keybindings here
  map('n', '<C-s>', '<cmd>w<CR>')
  map('n', '<C-q>', '<cmd>q<CR>')
end

M.setup_plugins = function()
  -- Add plugin-specific keybindings here
  map('n', '<leader>gs', ':G<CR>')
end

-- M.setup_terminal = function()
--   -- Add terminal keybindings here
-- end

-- M.setup_text = function()
--   -- Add text manipulation keybindings here
-- end

M.setup_search = function()
  -- Add search-related keybindings here
  -- Center the line when navigating search results
  map('n', 'n', 'nzzzv', { desc = 'Next search result and center' })
  map('n', 'N', 'Nzzzv', { desc = 'Previous search result and center' })
  
  -- Telescope examples (commented out)
  -- map('n', '<leader>ff', '<cmd>Telescope find_files<CR>')
  -- map('n', '<leader>fg', '<cmd>Telescope live_grep<CR>')
end

M.setup = function()
  -- Initialize all keybinding sections
  M.setup_navigation()
  M.setup_editing()
  M.setup_search()
  M.setup_plugins()
  -- M.setup_terminal()
  -- M.setup_text()
  M.setup_window()
end

return M
