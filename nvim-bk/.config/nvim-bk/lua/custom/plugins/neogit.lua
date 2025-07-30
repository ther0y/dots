return {
  {
    'NeogitOrg/neogit',
    dependencies = {
      'nvim-lua/plenary.nvim',
      'sindrets/diffview.nvim',
    },
    config = true,
    keys = {
      { '<leader>gn', '<cmd>Neogit<cr>', desc = 'Open Neogit' },
      -- { '<leader>gs', '<cmd>Neogit<cr>', desc = 'Open Neogit', silent = true, noremap = true },
      { '<leader>gb', '<cmd>Telescope git_branches<cr>', desc = 'Open Neogit', silent = true, noremap = true },
      { '<leader>gp', '<cmd>Telescope git_branches<cr>', desc = 'Open Neogit', silent = true, noremap = true },
      { '<leader>gd', '<cmd>DiffviewOpen<cr>', desc = 'Open Neogit', silent = true, noremap = true },
    },
  },
}
