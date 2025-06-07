--return {
--  'stevearc/conform.nvim',
--  config = function()
--    require('conform').setup {
--      debug = true,
--      formatters_by_ft = {
--			        lua = { 'stylua' },
--        sh = { 'shfmt' },
--        bash = { 'shfmt' },
--        zsh = { 'shfmt' },
--        javascript = { 'prettier' },
--        typescript = { 'prettier' },
--        html = { 'prettier' },
--        css = { 'prettier' },
--        json = { 'prettier' },
--        markdown = { 'prettier' },
--        yaml = { 'prettier' },
--      },
--    }
--  end,
--}

return {
	"stevearc/conform.nvim",
	config = function()
		require("conform").setup({
			debug = true,
			formatters_by_ft = {
				lua = { "stylua" },
				sh = { "shfmt" },
				bash = { "shfmt" },
				javascript = { "prettier" },
				typescript = { "prettier" },
				html = { "prettier" },
				css = { "prettier" },
				json = { "prettier" },
				markdown = { "prettier" },
				yaml = { "prettier" },
				c = { "clang_format" },
			},
			formatters = {
				clang_format = {
					command = "clang-format",
					args = {
						[[--style={
				BasedOnStyle: llvm,
				BreakBeforeBraces: Allman,
				AlignAfterOpenBracket: Align,
				AlignConsecutiveAssignments: true,
				AlignTrailingComments: true,
				IndentWidth: 6,
				SpacesInParentheses: true,
				SpacesInSquareBrackets: true
			}]],
					},
				},
			},
		})

		-- Add this block to enable format-on-save
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function(args)
				require("conform").format({ bufnr = args.buf })
			end,
		})
	end,
}
