return {
	"mtkld/fixedspace.nvim",
	dependencies = {},
	config = function()
		require("fixedspace").setup({
			{
				width = 25, -- Width of the vertical split
				buf_name = "xfixedspacex",
				winfixwidth = true, -- Prevent resizing the window
				modifiable = true, -- Make buffer read-only
				buftype = "nofile", -- Make it a scratch buffer
				bufhidden = "wipe", -- Auto-remove buffer when closed
				swapfile = false, -- No swap file
				enterable = true, -- Prevent entering the window
				wrap = false,
			},
			{

				width = 35, -- Width of the vertical split
				buf_name = "xfixedspace2x",
				winfixwidth = true, -- Prevent resizing the window
				modifiable = true, -- Make buffer read-only
				buftype = "nofile", -- Make it a scratch buffer
				bufhidden = "wipe", -- Auto-remove buffer when closed
				swapfile = false, -- No swap file
				enterable = true, -- Prevent entering the window
				wrap = false,
			},
		})
		--    Let project manager start it,
		--    vim.defer_fn(function()
		--      require('fixedspace').toggle()
		--    end, 1)

		vim.api.nvim_create_autocmd("User", {
			pattern = "preSwitchToProject",
			callback = function()
				require("fixedspace").disable()
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "postSwitchToProject",
			callback = function()
				require("fixedspace").enable()
				require("mdtoc").start()
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPostLoaded",
			callback = function()
				require("fixedspace").enable()
			end,
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPreSessionSave",
			callback = function()
				require("fixedspace").disable()
			end,
		})

		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPostSessionSave",
			callback = function()
				require("fixedspace").enable()
			end,
		})
	end,
}
