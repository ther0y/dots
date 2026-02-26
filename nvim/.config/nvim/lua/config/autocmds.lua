-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
--
-- Add any additional autocmds here
-- with `vim.api.nvim_create_autocmd`
--
-- Or remove existing autocmds by their group name (which is prefixed with `lazyvim_` for the defaults)
-- e.g. vim.api.nvim_del_augroup_by_name("lazyvim_wrap_spell")

local function augroup(name)
  return vim.api.nvim_create_augroup("custom_" .. name, { clear = true })
end

-- Enhanced checktime that works better in terminal/tmux environments
vim.api.nvim_create_autocmd({ "FocusGained", "BufEnter", "TermClose", "TermLeave" }, {
  group = augroup("checktime"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- Additional autocmd for when entering a buffer (helps with tmux)
vim.api.nvim_create_autocmd("BufWinEnter", {
  group = augroup("checktime_bufwin"),
  callback = function()
    if vim.o.buftype ~= "nofile" then
      vim.cmd("checktime")
    end
  end,
})

-- cd into the directory passed on startup so root detection uses it as cwd fallback
vim.api.nvim_create_autocmd("VimEnter", {
  group = augroup("start_dir"),
  once = true,
  callback = function()
    local argv = vim.fn.argv()
    local target = argv[1]
    if not target or target == "" then
      return
    end
    local uv = vim.uv or vim.loop
    local stat = uv.fs_stat(target)
    if not stat then
      return
    end
    local dir = stat.type == "directory" and target or vim.fn.fnamemodify(target, ":h")
    vim.cmd.cd(dir)
  end,
})
