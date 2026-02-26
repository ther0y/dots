return {
  "nvim-telescope/telescope.nvim",
  opts = {
    defaults = {
      -- Pass --hidden to ripgrep so live_grep searches inside .config/ etc.
      vimgrep_arguments = {
        "rg",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
        "--hidden",
        "--glob=!.git/",
      },
    },
    pickers = {
      find_files = {
        -- Pass --hidden to fd so find_files traverses .config/ etc.
        find_command = { "fd", "--type", "f", "--hidden", "--exclude", ".git" },
      },
    },
  },
}
