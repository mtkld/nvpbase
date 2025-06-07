return {
	priority = 10000, -- Own convention, my own ordinary plugins don't load before 1000
	"mtkld/devenv.nvim",
	config = function()
		require("devenv").setup({})
	end,
}
