-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
--
-- testing autoread salama ddcdved

-- set autoread
vim.opt.autoread = true

-- Bounded root detection: never pick a root above the session start dir.
-- This keeps dotfiles subfolders scoped even if ~/dots is a git repo.
do
  local function normalize(path)
    if not path or path == "" then
      return nil
    end
    local uv = vim.uv or vim.loop
    return uv.fs_realpath(path) or path
  end

  local function is_within(path, root)
    if not path or not root then
      return false
    end
    if path == root then
      return true
    end
    return path:sub(1, #root + 1) == root .. "/"
  end

  vim.g.root_spec = {
    function(buf)
      local start = normalize(vim.g.start_dir or (vim.uv or vim.loop).cwd())
      if not start then
        return {}
      end

      local roots = {}
      local ok, root_util = pcall(require, "lazyvim.util.root")
      if ok and root_util and root_util.detectors then
        local spec = { "lsp", { ".git", "lua" }, "cwd" }
        for _, detector in ipairs(spec) do
          local fn
          if type(detector) == "function" then
            fn = detector
          elseif root_util.detectors[detector] then
            fn = root_util.detectors[detector]
          else
            fn = function(b)
              return root_util.detectors.pattern(b, detector)
            end
          end

          local paths = fn(buf)
          paths = type(paths) == "table" and paths or { paths }
          for _, p in ipairs(paths) do
            local np = normalize(p)
            if is_within(np, start) then
              table.insert(roots, np)
            end
          end

          if #roots > 0 then
            break
          end
        end
      end

      if #roots == 0 then
        roots = { start }
      end
      return roots
    end,
  }
end
