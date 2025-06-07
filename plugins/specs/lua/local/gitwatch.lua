return {
	"mtkld/gitwatch.nvim",
	config = function()
		--		vim.api.nvim_create_user_command("SubmoduleCheck", require("gitwatch").check_current_file, {})

		-- create :SubmoduleCheck command on require
		vim.api.nvim_create_user_command("SubmoduleCheck", require("gitwatch").check_current_buffer, {})
		require("gitwatch").setup({ debug = false }) -- prints traversal trace

		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				require("gitwatch").check_current_buffer()
			end,
			desc = "Auto-check submodules on file open",
		})
	end,
}
