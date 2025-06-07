return {
	"mtkld/mdtoc.nvim",
	dependencies = {},
	config = function()
		local colors = require("color-theme.themes.pastel1_own")
		local mdcolors = {
			h1 = colors.markup_heading_1,
			h2 = colors.markup_heading_2,
			h3 = colors.markup_heading_3,
			h4 = colors.markup_heading_4,
			h5 = colors.markup_heading_5,
			h6 = colors.markup_heading_6,
		}
		mdcolors = require("color-theme").shift_colors(mdcolors)
		require("mdtoc").setup({
			float_window = 20,
			-- Define highlight options for each heading level
			hl_groups = {
				h1 = { fg = mdcolors.h1 },
				h2 = { fg = mdcolors.h2 },
				h3 = { fg = mdcolors.h3 },
				h4 = { fg = mdcolors.h4 },
				h5 = { fg = mdcolors.h5 },
				h6 = { fg = mdcolors.h6 },
			},
		})
		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPostLoaded",
			callback = function()
				-- Only create user commands if phxm is loaded
				--        vim.api.nvim_create_autocmd('User', {
				--          pattern = 'preSwitchToProject',
				--          callback = function()
				--            require('mdtoc').disable()
				--          end,
				--        })
				-- Only if project is loaded, do we want to enable these
				vim.api.nvim_create_autocmd("User", {
					pattern = "postSwitchToProject",
					callback = function()
						require("mdtoc").update_scratch_buffer()
						require("mdtoc").highlight_active_toc_entry()
						require("mdtoc").attach_main_buf_autocmds()
						require("mdtoc").attach_toc_buf_autocmds()
						require("mdtoc").fix_statusline()
					end,
				})
				log("-------------- mdtoc: phxmPostLoaded")
				vim.defer_fn(function()
					require("mdtoc").start()
					require("mdtoc").update_scratch_buffer()
				end, 1)
			end,
		})

		--    -- When the plugin is loaded first time, start the plugin
		--    require('mdtoc').start()
		--
		--    -- why this defer is the case I do not know,
		--    -- but intuition tells me...
		--    -- If Treesitter hasn't fully parsed the Markdown/Lua buffer yet, ...?
		--    -- Chat 4o's answer:
		--    -- Why Even 1ms Delay Works
		--    --    1ms delay doesn’t mean "1ms after now"
		--    --    It means "run this after all other queued startup events finish."
		--    -- This seem to apply only when nvim is starting up, but after that, it works as a normal timer. Chat 4o's answer:
		--    -- 	Before Neovim is fully started → The function waits until startup is done.
		--    --	After startup → The function behaves like a normal timer (runs in ~1ms).
		--    vim.defer_fn(function()
		--      require('mdtoc').enable()
		--    end, 1)
	end,
}
