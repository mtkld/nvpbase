local userconf = require("user-config")

local function validate_plugin_specs_local()
	local specs_path = vim.fs.joinpath(userconf.paths.plugin_specs, "lua", "local")
	local sources_path = userconf.paths.plugin_sources_local

	local missing = {}

	for name, type in vim.fs.dir(specs_path) do
		if type == "file" and name:match("%.lua$") then
			local plugin = name:gsub("%.lua$", ".nvim")
			local full_path = vim.fs.joinpath(sources_path, plugin)

			if tonumber(vim.fn.isdirectory(full_path)) == 0 then
				table.insert(missing, plugin .. " (missing directory)")
			end
		end
	end

	if #missing > 0 then
		vim.notify(
			"📁 plugin_specs path:       "
				.. specs_path
				.. "\n"
				.. "📁 plugin_sources_local:    "
				.. sources_path
				.. "\n\n"
				.. "🚨 Missing plugin directories:\n"
				.. table.concat(missing, "\n")
				.. "\n\nRun:\n  git submodule update --init --recursive",
			vim.log.levels.ERROR
		)
		return false
	end

	return true
end

return validate_plugin_specs_local
