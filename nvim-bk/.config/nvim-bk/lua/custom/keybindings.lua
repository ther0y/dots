-- General keybindings
local function setup_keybindings()
  -- Insert mode escape mappings
  vim.keymap.set('i', 'jj', '<Esc>', { desc = 'Exit insert mode with jj' })
  vim.keymap.set('i', 'jk', '<Esc>', { desc = 'Exit insert mode with jk' })
end

return {
  setup = setup_keybindings,
}