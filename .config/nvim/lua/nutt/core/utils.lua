---@class Utilities
local M = {
  icons = {
    diagnostics = {
      error = " ",
      warn = " ",
      hint = " ",
      info = " ",
    },
    file = {
      modified = "[] ",
      readonly = "[󰌾] ",
      unnamed = "[No Name] ",
      newfile = "[] ",
    },
    directory = {
      folder = "󱉭 ",
    },
    diff = {
      added = " ",
      modified = " ",
      removed = " ",
    },
    components = {
      left = "",
      right = "",
      left_outline = "",
      right_outline = "",
    },
    status = {
      spider = "󱇪",
    },
  },
}

function M.get_root()
  local buf = 0

  -- Get current buffer path
  local path = vim.api.nvim_buf_get_name(buf)
  path = path ~= "" and vim.fs.dirname(path) or vim.uv.cwd() or ""

  -- Define some root patterns that we might use
  local root_patterns = {
    ".git",
    "lua",
    "package.json",
  }

  -- Check for root pattern
  local root = vim.fs.find(root_patterns, { upward = true, path = path })[1]

  if root then
    return vim.fs.dirname(root)
  end

  -- Check Lsp for root
  for _, client in pairs(vim.lsp.get_clients({ bufnr = buf })) do
    local workspace = client.config.root_dir

    if workspace and path:find(workspace, 1, true) then
      return workspace
    end
  end

  return vim.uv.cwd()
end

function M.root_dir()
  local dir = ""
  local root = M.get_root()

  if root then
    dir = vim.fs.basename(root)
  end

  return dir
end

return M
