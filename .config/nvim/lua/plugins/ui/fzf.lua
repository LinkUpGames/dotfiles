return {
  "ibhagwan/fzf-lua",
  opts = {
    "telescope",
    winopts = {
      info = "hidden",
    },
    files = {
      header = false,
      formatter = "path.filename_first",
    },
    grep = {
      header = false,
      formatter = "path.filename_first",
    },
    buffers = {
      formatter = "path.filename_first",
      header = false,
    },
  },
}
