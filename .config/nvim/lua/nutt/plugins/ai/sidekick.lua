return {
  "folke/sidekick.nvim",
  opts = {
    cli = {
      win = {
        keys = {
          prompt = { "<c-p>", "<nop>" },
        },
      },
    },
  },
  keys = {
    {
      "<leader>aa",
      function()
        require("sidekick.cli").toggle({ name = "opencode", focus = true })
      end,
      desc = "Sidekick Toggle ClI",
    },
    {
      "<leader>ad",
      function()
        require("sidekick.cli").close()
      end,
      desc = "Sidekick Close CLI",
    },
  },
}
