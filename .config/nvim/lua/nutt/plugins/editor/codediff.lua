---@module "lazy"
---@type LazySpec
return {
  "esmuellert/codediff.nvim",
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
  cmd = "CodeDiff",
  opts = function()
    -- Disable cursor line on diff mode and tabline
    vim.api.nvim_create_autocmd("User", {
      pattern = "CodeDiffOpen",
      callback = function()
        -- disable cursorline
        local wins = vim.api.nvim_tabpage_list_wins(0)

        for _, win in ipairs(wins) do
          vim.wo[win].cursorline = false
        end

        -- disable status bar
        vim.g.codediff_saved_showtabline = vim.o.showtabline
        vim.o.showtabline = 0
      end,
    })

    -- Enable tabline
    -- vim.api.nvim_create_autocmd("User", {
    --   pattern = "CodeDiffClose",
    --   callback = function()
    --     if vim.g.codediff_saved_showtabline then
    --       vim.o.showtabline = vim.g.codediff_saved_showtabline
    --       vim.g.codediff_saved_showtabline = nil
    --     end
    --   end,
    -- })

    return {
      explorer = {
        focus_on_select = true,
      },
      keymaps = {
        view = {
          toggle_explorer = "<leader>e",
          focus_explorer = "<leader>b",
        },
      },
    }
  end,
  keys = {
    {
      "<leader>gd",
      "<cmd>CodeDiff<cr>",
      desc = "Toggle Diff View",
    },
    {
      "<leader>gh",
      "<cmd>CodeDiff history %<cr>",
      desc = "Toggle File History",
    },
  },
}
