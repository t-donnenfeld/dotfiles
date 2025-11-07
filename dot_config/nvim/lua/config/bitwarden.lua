local M = {}

M.item_query = "OpenAI API Key"
M.session = nil
M.token_lines = {}

-- Helper: run a shell command and get stdout
local function cmd_output(cmd)
  local handle = io.popen(cmd)
  if not handle then return nil end
  local result = handle:read("*a")
  handle:close()
  return (result:gsub("%s+$", ""))
end

-- Retrieve the OpenAI key after unlock
local function load_openai_key(session)
  local key = cmd_output("bw get password " .. M.item_query .. " --session " .. session)
  if not key or #key == 0 then
    vim.notify("⚠️ Could not retrieve API key from Bitwarden.", vim.log.levels.ERROR)
    return
  end
  vim.env.AVANTE_OPENAI_API_KEY = key
  vim.notify("🤖 AVANTE_OPENAI_API_KEY loaded successfully.")
  local ok, lazy = pcall(require, "lazy")
  if ok then
    lazy.load({ plugins = { "avante.nvim" } }) -- ensures Avante is loaded once key is ready
  end
end

-- Handle process exit
local function on_term_exit(_, code, _)
  if code == 0 and M.token_lines and #M.token_lines > 0 then
    local token = M.token_lines[#M.token_lines]
    if token and token:match("%w") then
      M.session = token
      vim.env.BW_SESSION = token
      vim.notify("🔐 Bitwarden unlocked.")
      load_openai_key(token)
    else
      vim.notify("⚠️ Failed to capture BW session token.", vim.log.levels.ERROR)
    end
  else
    vim.notify("❌ Bitwarden unlock canceled or failed.", vim.log.levels.WARN)
  end
  M.token_lines = {}
end

-- Handle process stdout (collect potential token lines)
local function on_term_stdout(_, data, _)
  for _, line in ipairs(data or {}) do
    if line and line:match("[%w%-]+") then
      table.insert(M.token_lines, line)
    end
  end
end

-- Open floating terminal for unlock
function M.unlock()
  local term_buf = vim.api.nvim_create_buf(false, true)
  M.token_lines = {}

  local width = math.floor(vim.o.columns * 0.6)
  local height = 10
  local opts = {
    relative = "editor",
    width = width,
    height = height,
    col = math.floor((vim.o.columns - width) / 2),
    row = math.floor((vim.o.lines - height) / 2),
    style = "minimal",
    border = "rounded",
  }

  local term_win = vim.api.nvim_open_win(term_buf, true, opts)

  vim.fn.termopen("bw unlock --raw", {
    on_stdout = on_term_stdout,
    on_exit = on_term_exit,
  })

  vim.cmd.startinsert()
end

vim.keymap.set("n", "<leader>ae", function()
  M.unlock()
end, { desc = "Unlock Bitwarden (terminal) + load OpenAI key" })

return M
