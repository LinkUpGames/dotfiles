return {
  {
    "nvim-treesitter/nvim-treesitter-context",
    event = { "BufReadPre", "BufNewFile", "BufWritePre" },
    opts = {
      enable = true,
    },
    keys = {
      {
        "<leader>tc",
        "<cmd>TSContext toggle<cr>",
        desc = "Toggle Sticky Scroll",
        mode = "n",
      },
    },
  },
  {
    "folke/which-key.nvim",
    opts = {
      spec = {
        mode = { "n" },
        { "<leader>t", group = "Treesitter", icon = { icon = "", color = "orange" } },
      },
    },
  },
}
