return {
	{
		"neovim/nvim-lspconfig",
		dependencies = {
			{ "williamboman/mason.nvim", config = true },
			"williamboman/mason-lspconfig.nvim",
			"stevanmilic/nvim-lspimport",
			"hrsh7th/cmp-nvim-lsp",
		},
		event = { "BufReadPre", "BufNewFile" },
		config = function()
			require("mason").setup()
			require("mason-lspconfig").setup({
				ensure_installed = {
					"lua_ls",
					"vimls",
					"pyright",
					"bashls",
					"ts_ls",
					"clangd",
					"ruff",
				},
				automatic_enable = true,
			})

			local capabilities = require("cmp_nvim_lsp").default_capabilities()
			vim.lsp.config("*", {
				capabilities = capabilities,
				root_markers = { ".git", "compile_commands.json" },
			})
      
      vim.lsp.config("pyright", {
      	settings = {
      		python = {
      			analysis = {
      				autoSearchPaths = true,
      				typeCheckingMode = "basic",
      				diagnosticMode = "workspace",
      				useLibraryCodeForTypes = true,
      				diagnosticSeverityOverrides = {
      					reportUnusedImport = "none",
      					reportUnusedVariable = "none",
      					reportUnusedFunction = "none",
      					reportUnusedClass = "none",
      				},
      			},
      		},
      	},
      })
      vim.lsp.config("ruff", {
      	on_attach = function(client)
      		-- Prefer Pyright for hover/type info; keep Ruff for linting only.
      		client.server_capabilities.hoverProvider = false
      		client.server_capabilities.documentFormattingProvider = false
      		client.server_capabilities.documentRangeFormattingProvider = false
      	end,
      })
      vim.lsp.config("lua_ls", {
        settings = {
          Lua = {
            runtime = { version = "LuaJIT" },
            diagnostics = { globals = { "vim" } },
            workspace = { checkThirdParty = false },
            telemetry = { enable = false },
          },
        },
      })
      vim.lsp.config("clangd", {
        settings = {
          {
            cmd = {
              "clangd",
              "--background-index",
              "--clang-tidy",
              "--completion-style=detailed",
              "--header-insertion=iwyu",
              "--header-insertion-decorators",
              "--function-arg-placeholders",
              "--fallback-style=LLVM",
            },
            filetypes = { "c", "cpp", "objc", "objcpp" },
          }
        },
      })
      
      vim.lsp.config("vimls", {
        cmd = { "vim-language-server", "--stdio" },
        filetypes = { "vim", "vimrc" },
        root_markers = { ".git/" },
      
        settings = {
          vim = {
            isNeovim = true,
            suggest = {
              fromVimruntime = true,
              fromRuntimepath = true,
            },
            diagnostics = {
              enable = true,
              globals = { "vim" },
            },
          },
        },
      })
		end,
	},
	{ "kmontocam/nvim-conda", dependencies = { "nvim-lua/plenary.nvim" } },
}
