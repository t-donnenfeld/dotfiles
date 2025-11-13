vim.api.nvim_create_autocmd("LspAttach", {
	group = vim.api.nvim_create_augroup("UserLspConfig", {}),
	callback = function(args)
		local buf = args.buf
		local map = function(mode, lhs, rhs, desc)
			vim.keymap.set(mode, lhs, rhs, { buffer = buf, desc = desc })
		end

		-- === 🧭 NAVIGATION ===
		map("n", "gd", vim.lsp.buf.definition, "Go to Definition")
		map("n", "gD", vim.lsp.buf.declaration, "Go to Declaration")
		map("n", "gi", vim.lsp.buf.implementation, "Go to Implementation")
		map("n", "gr", vim.lsp.buf.references, "List References")
		map("n", "gt", vim.lsp.buf.type_definition, "Go to Type Definition")

		-- === 🧩 CODE INTELLIGENCE ===
		map("n", "<leader>cd", vim.lsp.buf.hover, "Hover Documentation")
		map("n", "<leader>cs", vim.lsp.buf.signature_help, "Show Signature Help")
		map("i", "<C-k>", vim.lsp.buf.signature_help, "Signature Help (insert)")
		map("n", "<leader>cr", vim.lsp.buf.rename, "Rename Symbol")
		map("n", "<leader>ca", vim.lsp.buf.code_action, "Code Action")

		-- === ⚙️ WORKSPACE MANAGEMENT ===
		map("n", "<leader>wa", vim.lsp.buf.add_workspace_folder, "Add Workspace Folder")
		map("n", "<leader>wr", vim.lsp.buf.remove_workspace_folder, "Remove Workspace Folder")
		map("n", "<leader>wl", function()
			print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
		end, "List Workspace Folders")

		-- === 🔍 SYMBOLS ===
		map("n", "<leader>co", vim.lsp.buf.document_symbol, "Document Symbols")
		map("n", "<leader>cw", vim.lsp.buf.workspace_symbol, "Workspace Symbols")

		-- === 🧱 DIAGNOSTICS ===
		map("n", "<leader><", vim.diagnostic.goto_prev, "Previous Diagnostic")
		map("n", "<leader>>", vim.diagnostic.goto_next, "Next Diagnostic")
		map("n", "<leader>cdd", vim.diagnostic.open_float, "Show Line Diagnostics")
		map("n", "<leader>cdq", vim.diagnostic.setloclist, "Open Quickfix List")
		map("n", "<leader>cdt", vim.diagnostic.setqflist, "Open Diagnostics (QF)")

		-- === 🪄 FORMATTING ===
		map("n", "<leader>cf", function()
			vim.lsp.buf.format({ async = true })
		end, "Format File")

		-- === 💡 INLAY HINTS ===
		map("n", "<leader>ch", function()
			local enabled = vim.lsp.inlay_hint.is_enabled({ bufnr = buf })
			vim.lsp.inlay_hint.enable(not enabled, { bufnr = buf })
		end, "Toggle Inlay Hints")
	end,
})

vim.api.nvim_create_autocmd("LspAttach", {
	callback = function(args)
		local client = vim.lsp.get_client_by_id(args.data.client_id)
		if not client then
			return
		end
		client.handlers["textDocument/signatureHelp"] = function(_, result, ctx, config) end
	end,
})
