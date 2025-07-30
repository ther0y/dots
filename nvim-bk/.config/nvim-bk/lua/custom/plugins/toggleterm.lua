return {
  'akinsho/toggleterm.nvim',
  version = '*',
  opts = {
    open_mapping = [[<c-\>]],
    direction = 'float',
    float_opts = {
      border = 'curved',
      width = function()
        return math.floor(vim.o.columns * 0.8)
      end,
      height = function()
        return math.floor(vim.o.lines * 0.8)
      end,
    },
  },
  config = function(_, opts)
    require('toggleterm').setup(opts)

    -- Keybind for opening floating terminal
    vim.keymap.set('n', '<leader>tf', '<cmd>ToggleTerm direction=float<cr>', { desc = 'Toggle floating terminal' })
    vim.keymap.set('t', '<esc>', [[<C-\><C-n>]], { desc = 'Exit terminal mode' })

    -- Htop floating terminal
    local Terminal = require('toggleterm.terminal').Terminal
    local htop = Terminal:new({
      cmd = 'htop',
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = function()
          return math.floor(vim.o.columns * 0.9)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.9)
        end,
      },
    })

    vim.keymap.set('n', '<leader>th', function()
      htop:toggle()
    end, { desc = 'Toggle htop floating terminal' })

    -- Yazi floating terminal
    local yazi = Terminal:new({
      cmd = 'yazi',
      direction = 'float',
      float_opts = {
        border = 'curved',
        width = function()
          return math.floor(vim.o.columns * 0.95)
        end,
        height = function()
          return math.floor(vim.o.lines * 0.95)
        end,
      },
    })

    vim.keymap.set('n', '<leader>ty', function()
      yazi:toggle()
    end, { desc = 'Toggle yazi floating terminal' })
  end,
}