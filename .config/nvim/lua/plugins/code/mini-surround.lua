return {
  "nvim-mini/mini.surround",
  opts = {
    mappings = {
      add = "gsa",
      delete = "gsd",
      replace = "gsr",
    },
  },
  keys = {
    { "gsa", desc = "Add Surrounding", mode = { "n", "v" } },
    { "gsd", desc = "Delete Surrounding", mode = { "n" } },
    { "gsr", desc = "Replace Surrounding", mode = { "n" } },
  },
}
