-- File: ~/.config/nvim/lua/specs/bashls.lua
-- TODO: Is this used?
return {
	"neovim/nvim-lspconfig",
	ft = { "sh" }, -- optional: load only when opening shell scripts
	config = function()
		local lspconfig = require("lspconfig")

		local capabilities = vim.lsp.protocol.make_client_capabilities()
		local has_cmp, cmp_lsp = pcall(require, "cmp_nvim_lsp")
		if has_cmp then
			capabilities = vim.tbl_deep_extend("force", capabilities, cmp_lsp.default_capabilities())
		end

		lspconfig.bashls.setup({
			cmd = { "bash-language-server", "start" },
			filetypes = { "sh" },
			capabilities = capabilities,
		})

		vim.api.nvim_create_autocmd("LspAttach", {
			group = vim.api.nvim_create_augroup("user-lsp-bashls", { clear = true }),
			callback = function(event)
				--        local map = function(keys, func, desc)
				--          vim.keymap.set('n', keys, func, { buffer = event.buf, desc = 'LSP: ' .. desc })
				--        end
				--        map('gd', vim.lsp.buf.definition, 'Goto Definition')
				--        map('gr', vim.lsp.buf.references, 'Goto References')
				--        map('<leader>rn', vim.lsp.buf.rename, 'Rename')
				--        map('<leader>ca', vim.lsp.buf.code_action, 'Code Action')
			end,
		})
	end,
}
