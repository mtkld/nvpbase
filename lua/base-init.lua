local lazy_bootstrap = require("lazy-bootstrap")
lazy_bootstrap.ensure()

local user_config = require("user-config")
vim.opt.rtp:append(user_config.paths.plugin_specs)

if user_config.is_dev then
	-- dev mode is true, so we need to ensure all our local plugin sources exist
	if not require("validate-plugin-specs-local")() then
		vim.notify(
			"Because is_dev=true, the sources of the local plugins must exist in ./plugins/sources/local/.",
			vim.log.levels.ERROR
		)
		vim.notify("Aborting.", vim.log.levels.ERROR)
		vim.fn.input("Press ENTER to exit...")
		os.exit(1)
	end
end

require("lazy").setup({
	{
		-- The is_dev causes the use of either the plugins as they exist in the local dev folder, or to treat the plugin specs as external plugins, instaling them as such.
		{ import = "local", dev = user_config.is_dev },
		{ import = "remote" },
	},
}, {
	lockfile = nil, -- prevent lazy from writing `lazy-lock.json`
	defaults = {
		version = false, -- avoid version checking
	},
	dev = {
		path = user_config.paths.plugin_sources_local, -- where your actual plugin folders are
		patterns = { user_config.gh_account_name }, -- only treat these plugins as local/dev
	},
})
