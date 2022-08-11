require("nvim-tree").setup({
  sort_by = "case_insensitive",
  view = {
    adaptive_size = true,
    mappings = {
      list = {
        { key = "u", action = "dir_up" },
        { key = "s", action = "vsplit" }, 
        { key = "i", action = "split"},
        { key = "?", action = "toggle_help" },
        { key = "C", action = "cd" },
      },
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = true,
  },
   update_focused_file = {
    enable = true,
    update_cwd = true,
  },
})

vim.g.nvim_tree_respect_buf_cwd = 1
