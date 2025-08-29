---Create the hightlight groups when a colorscheme is loaded
local create_highlights = function()
  ---Get hightlight group
  ---@param name string
  local h = function(name)
    return vim.api.nvim_get_hl(0, { name = name, link = false })
  end

  -- Hightlight groups
  vim.api.nvim_set_hl(0, "SymbolUsageRounding", { fg = h("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageContent", { bg = h("CursorLine").bg, fg = h("Comment").fg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageRef", { fg = h("Function").fg, bg = h("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageDef", { fg = h("Type").fg, bg = h("CursorLine").bg, italic = true })
  vim.api.nvim_set_hl(0, "SymbolUsageImpl", { fg = h("@keyword").fg, bg = h("CursorLine").bg, italic = true })
end

-- Load new highlights on colorscheme change
vim.api.nvim_create_autocmd({ "ColorScheme", "VimEnter" }, {
  callback = function()
    -- Make sure that we wait until the colorscheme is set
    vim.defer_fn(function()
      create_highlights()
    end, 100)
  end,
})

return {
  "Wansmer/symbol-usage.nvim",
  events = "LspAttach",
  opts = function()
    ---Format symbol to display nicely
    ---@param symbol {references: number, definition: number, implementation: number, stacked_count: number}
    local text_format = function(symbol)
      --- Icon, Color
      ---@type ([string, string])[]
      local res = {}

      local round_start = { "", "SymbolUsageRounding" }
      local round_end = { "", "SymbolUsageRounding" }

      -- Indicator that shows if there are any other symbols in the same line
      local stacked_functions_content = symbol.stacked_count > 0 and ("+%s"):format(symbol.stacked_count) or ""

      -- References
      if symbol.references then
        local usage = symbol.references <= 1 and "usage" or "usages"
        local num = symbol.references == 0 and "no" or symbol.references

        table.insert(res, round_start)
        table.insert(res, { " ", "SymbolUsageRef" })
        table.insert(res, { ("%s %s"):format(num, usage), "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      -- Definition
      if symbol.definition then
        -- Check if we are the first
        if #res > 0 then
          table.insert(res, { " ", "NonText" })
        end

        table.insert(res, round_start)
        table.insert(res, { "󰳽", "SymbolUsageDef" })
        table.insert(res, { symbol.definition .. " defs", "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      -- Implementation
      if symbol.implementation then
        if #res > 0 then
          table.insert(res, { " ", "NonText" })
        end

        table.insert(res, round_start)
        table.insert(res, { "󰡱", "SymbolUsageImpl" })
        table.insert(res, { symbol.implementation .. " impls", "SymbolUsageImpl" })
        table.insert(res, round_end)
      end

      if stacked_functions_content ~= "" then
        if #res > 0 then
          table.insert(res, { " ", "NonText" })
        end

        table.insert(res, round_start)
        table.insert(res, { "", "SymbolUsageImpl" })
        table.insert(res, { stacked_functions_content, "SymbolUsageContent" })
        table.insert(res, round_end)
      end

      return res
    end

    return {
      text_format = text_format,
    }
  end,
}
