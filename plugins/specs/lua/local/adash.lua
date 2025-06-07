-- lazy.nvim / packer / whatever
return {
	"mtkld/adash.nvim",
	config = function()
		require("adash").setup({
			base_dir = "/home/f/remote/matkalkyl.dev/adash", -- uncomment to override
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "postSwitchToProject",
			callback = function()
				require("adash").refresh()
			end,
		})
	end,
}
