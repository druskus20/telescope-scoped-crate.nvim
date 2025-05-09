local pickers = require "telescope.pickers"
local finders = require "telescope.finders"
local conf = require("telescope.config").values
local actions = require "telescope.actions"
local action_state = require "telescope.actions.state"
local make_entry = require "telescope.make_entry"
local Path = require "plenary.path"
local builtin = require "telescope.builtin"

local M = {}

---@brief Find files in the Rust crate containing the current buffer
M.scoped_crate_files = function(opts)
  opts = opts or {}

  local function find_nearest_cargo_toml()
    -- we use the path of the current buffer
    local buffer_path = vim.fn.expand("%:p")
    if buffer_path == "" then
      -- fall back to the current working directory
      buffer_path = vim.fn.getcwd()
    end

    local buffer_dir = vim.fn.fnamemodify(buffer_path, ":h")

    local cargo_toml = vim.fn.findfile("Cargo.toml", buffer_dir .. ";")
    if cargo_toml == "" then
      return nil
    else
      return Path:new(cargo_toml):parent()
    end
  end

  local crate_root = find_nearest_cargo_toml()
  if not crate_root then
    vim.notify("No Cargo.toml found in any parent directory", vim.log.levels.ERROR)
    return
  end

  local crate_root_path = crate_root:absolute()

  local find_opts = vim.tbl_extend("force", opts, {
    cwd = crate_root_path,
    prompt_title = "Rust Crate Files",
    hidden = false,
    no_ignore = false,
  })

  builtin.find_files(find_opts)
end

return M
