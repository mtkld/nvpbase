return {
	-- TODO: Put the actual config here and remove it from the plugin itself. Let it just be a theme selector and applier.
	"mtkld/color-theme.nvim",
	config = function()
		require("color-theme").setup()
	end,
}
