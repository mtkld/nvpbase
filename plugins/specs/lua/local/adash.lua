-- lazy.nvim / packer / whatever
return {
	"mtkld/adash.nvim",
	config = function()
		require("adash").setup({
			base_dir = "~/remote/matkalkyl.dev/adash", -- uncomment to override
		})
	end,
}
