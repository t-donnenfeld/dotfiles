return {
  {
    "nickjvandyke/opencode.nvim",
    version = "*",
    dependencies = {
      {
        "folke/snacks.nvim",
        optional = true,
        opts = {
          input = {},
          picker = {
            actions = {
              opencode_send = function(...)
                return require("opencode").snacks_picker_send(...)
              end,
            },
            win = {
              input = {
                keys = {
                  ["<a-a>"] = { "opencode_send", mode = { "n", "i" } },
                },
              },
            },
          },
        },
      },
    },
    config = function()
      local function opencode_cmd()
        local cwd = vim.fn.getcwd()
        return "cd " .. cwd .. " && opencode --port"
      end

      vim.g.opencode_opts = {
        server = {
          start = function()
            require("snacks.terminal").open(opencode_cmd(), {
              win = {
                position = "right",
                enter = false,
                on_win = function(win)
                  require("opencode.terminal").setup(win.win)
                end,
              },
            })
          end,

          stop = function()
            require("snacks.terminal").get(opencode_cmd()):close()
          end,

          toggle = function()
            require("snacks.terminal").toggle(opencode_cmd())
          end,
        },

        lsp = {
          enabled = true, -- optional experimental LSP integration
        },
      }

      vim.o.autoread = true

      -- Ask AI
      vim.keymap.set({ "n", "x" }, "<leader>oa", function()
        require("opencode").ask("@this: ", { submit = true })
      end, { desc = "Opencode Ask" })

      -- Prompt selector
      vim.keymap.set({ "n", "x" }, "<leader>os", function()
        require("opencode").select()
      end, { desc = "Opencode Actions" })

      -- Toggle AI terminal
      vim.keymap.set({ "n", "t" }, "<leader>ot", function()
        require("opencode").toggle()
      end, { desc = "Toggle Opencode" })

      -- Add code range
      vim.keymap.set({ "n", "x" }, "go", function()
        return require("opencode").operator("@this ")
      end, { expr = true, desc = "Send code to Opencode" })

      vim.keymap.set("n", "goo", function()
        return require("opencode").operator("@this ") .. "_"
      end, { expr = true, desc = "Send line to Opencode" })

      vim.keymap.set("n", "K", function()
        return require("opencode").command("session.half.page.up")
      end, { expr = true, desc = "Scroll half page up" })

      vim.keymap.set("n", "J", function()
        return require("opencode").command("session.half.page.down")
      end, { expr = true, desc = "Scroll half page up" })

      vim.keymap.set("n", "<leader>ol", function()
        require("opencode").command("session.list")
      end, { desc = "Opencode list sessions" })

      vim.keymap.set("n", "<leader>os", function()
        require("opencode").command("session.select")
      end, { desc = "Opencode select session" })

      vim.keymap.set("n", "<leader>on", function()
        require("opencode").command("session.new")
      end, { desc = "Opencode new session" })
    end,
  },
}
