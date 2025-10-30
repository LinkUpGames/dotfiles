return {
  "nvim-mini/mini.surround",
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      replace = "gsr",
      find = "",
      find_left = "",
      highlight = "",
    },
  },
  keys = {
    { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
    { "gsd", desc = "Delete Surrounding", mode = { "n" } },
    { "gsr", desc = "Replace Surrounding", mode = { "n" } },
  },
}
