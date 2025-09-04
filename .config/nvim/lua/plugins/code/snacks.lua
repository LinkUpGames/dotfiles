return {
  "folke/snacks.nvim",
  opts = function() end,
  config = function(_, opts)
    require("snacks").setup(opts)

    -- Extra functionality
    -- Snack Options
    Snacks.toggle.option("relativenumber", { name = "Relative Number" }):map("<leader>uL")

    -- LazyGit
    local map = vim.keymap.set
    if vim.fn.executable("lazygit") == 1 then
      map("n", "<leader>gg", function()
        Snacks.lazygit({ cwd = LazyVim.root.git() })
      end, { desc = "Lazygit (Root Dir)" })
      map("n", "<leader>gG", function()
        Snacks.lazygit()
      end, { desc = "Lazygit (cwd)" })
      map("n", "<leader>gf", function()
        Snacks.picker.git_log_file()
      end, { desc = "Git Current File History" })
      map("n", "<leader>gl", function()
        Snacks.picker.git_log({ cwd = LazyVim.root.git() })
      end, { desc = "Git Log" })
      map("n", "<leader>gL", function()
        Snacks.picker.git_log()
      end, { desc = "Git Log (cwd)" })
    end

    -- Zen Mode
    Snacks.toggle.zoom():map("<leader>wm"):map("<leader>uZ")
    Snacks.toggle.zen():map("<leader>uz")
  end,
}
