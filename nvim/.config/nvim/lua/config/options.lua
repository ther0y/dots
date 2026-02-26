-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

vim.opt.autoread = true

-- Use LSP root if available, otherwise cwd. Avoids .git-climbing into ~/dots/
-- when editing stow packages (e.g. v ~/.config/hypr).
vim.g.root_spec = { "lsp", "cwd" }
