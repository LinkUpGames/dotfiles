if true then
  return {}
end
return {
  {
    "sindrets/diffview.nvim",
    opts = {},
    keys = {
      {
        "<leader>gD",
        function()
          local lib = require("diffview.lib")

          if lib.get_current_view() then
            vim.cmd("DiffviewClose")
          else
            vim.cmd("DiffviewOpen")
          end
        end,
        mode = { "n" },
        desc = "Toggle Diff View",
      },
    },
  },
}
