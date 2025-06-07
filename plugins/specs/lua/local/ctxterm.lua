return {
	"mtkld/ctxterm.nvim",
	dependencies = {
		"mtkld/phxm.nvim",
	},
	config = function()
		require("ctxterm").setup({
			shell = "fish",
			start_shell_with_cwd_cb = function()
				local project_path = require("phxm.properties").current_project.project_path
				return project_path
			end,
			current_context_cb = function()
				local project_name = require("phxm.properties").current_project.name
				return project_name
			end,
		})
	end,
}
