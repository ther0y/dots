return {
  'folke/snacks.nvim',
  priority = 1000,
  lazy = false,
  ---@type snacks.Config
  opts = {
    bigfile = { enabled = true },
    dashboard = { enabled = true },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = {
      enabled = true,
      timeout = 3000,
    },
    quickfile = { enabled = true },
    scroll = { enabled = false },
    statuscolumn = { enabled = true },
    words = { enabled = true },
    styles = {
      notification = {
        wo = { wrap = true }, -- Wrap notifications
      },
    },
  },
  keys = {
    {
      '<leader>un',
      function()
        Snacks.notifier.hide()
      end,
      desc = 'Dismiss All Notifications',
    },
    {
      '<leader>bd',
      function()
        Snacks.bufdelete()
      end,
      desc = 'Delete Buffer',
    },
    -- {
    --   '<leader>cR',
    --   function()
    --     Snacks.rename.rename_file()
    --   end,
    --   desc = 'Rename File',
    -- },
    {
      '<leader>gB',
      function()
        Snacks.gitbrowse()
      end,
      desc = 'Git Browse',
    },
    -- {
    --   '<leader>gb',
    --   function()
    --     Snacks.git.blame_line()
    --   end,
    --   desc = 'Git Blame Line',
    -- },
    -- {
    --   '<leader>gf',
    --   function()
    --     Snacks.lazygit.open_file()
    --   end,
    --   desc = 'Lazygit Current File',
    -- },
    -- {
    --   '<leader>gg',
    --   function()
    --     Snacks.lazygit()
    --   end,
    --   desc = 'Lazygit',
    -- },
    -- {
    --   '<leader>gd',
    --   function()
    --     Snacks.picker.diagnostics()
    --   end,
    --   desc = 'Diagnostics',
    -- },
    -- {
    --   '<leader>gr',
    --   function()
    --     Snacks.picker.recent()
    --   end,
    --   desc = 'Recent',
    -- },
    -- {
    --   '<leader>g,',
    --   function()
    --     Snacks.picker.buffers()
    --   end,
    --   desc = 'Buffers',
    -- },
    -- {
    --   '<leader>g/',
    --   function()
    --     Snacks.picker.grep()
    --   end,
    --   desc = 'Grep',
    -- },
    -- {
    --   '<leader>gf',
    --   function()
    --     Snacks.picker.files()
    --   end,
    --   desc = 'Files',
    -- },
    -- {
    --   '<leader>gF',
    --   function()
    --     Snacks.picker.files { cwd = vim.fn.getcwd() }
    --   end,
    --   desc = 'Files (cwd)',
    -- },
    -- {
    --   '<leader>go',
    --   function()
    --     Snacks.picker.oldfiles()
    --   end,
    --   desc = 'Recent',
    -- },
    -- {
    --   '<leader>gc',
    --   function()
    --     Snacks.picker.colors()
    --   end,
    --   desc = 'Colors',
    -- },
    -- {
    --   '<leader>gt',
    --   function()
    --     Snacks.picker.explorer()
    --   end,
    --   desc = 'File Explorer',
    -- },
    -- {
    --   '<leader>q',
    --   function()
    --     Snacks.picker.quickfix()
    --   end,
    --   desc = 'Quickfix List',
    -- },
    -- {
    --   '<leader>xl',
    --   function()
    --     Snacks.picker.lines()
    --   end,
    --   desc = 'Buffer Lines',
    -- },
    -- {
    --   '<leader>xL',
    --   function()
    --     Snacks.picker.lines { include_current = true }
    --   end,
    --   desc = 'Buffer Lines',
    -- },
  },
}
