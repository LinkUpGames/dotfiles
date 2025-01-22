if true then
  return {}
end

return {
  "echasnovski/mini.files",
  version = false,
  opts = {
    mappings = {
      reveal_cwd = "_",
    },
    windows = {
      preview = true,
    },
  },
  keys = {
    {
      "<leader>e",
      function()
        local files = require("mini.files")

        if not files.close() then
          files.open(vim.api.nvim_buf_get_name(0))
        end
      end,
      mode = { "n" },
      desc = "Open currnt directory",
    },
  },
}
