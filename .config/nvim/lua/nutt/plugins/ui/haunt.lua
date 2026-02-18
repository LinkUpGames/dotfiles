if true then
  return {}
end

---@module "lazy"
---@type LazySpec
return {
  {
    "TheNoeTrevino/haunt.nvim",
    opts = {},
    keys = {
      {
        "<leader>ha",
        function()
          require("haunt.api").annotate()
        end,
        mode = "n",
        desc = "Annotate",
      },
      {
        "<leader>ht",
        function()
          require("haunt.api").toggle_annotation()
        end,
        mode = "n",
        desc = "Toggle Annotation",
      },
      {
        "<leader>hT",
        function()
          require("haunt.api").toggle_all_lines()
        end,
        mode = "n",
        desc = "Toggle All Annotations",
      },
      {
        "<leader>hD",
        function()
          require("haunt.api").clear_all()
        end,
        mode = "n",
        desc = "Delete All Annotations",
      },
      {
        "<leader>hd",
        function()
          require("haunt.api").delete()
        end,
        mode = "n",
        desc = "Delete Annotation",
      },
      {
        "<leader>hs",
        function()
          require("haunt.picker").show()
        end,
        mode = "n",
        desc = "Show Picker",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = function()
      local add = require("which-key").add

      add({
        {
          "<leader>h",
          group = "Haunt",
          icon = { icon = "", color = "purple", mode = "n" },
        },
      })
    end,
  },
}
