return {
	priority = 1000,
	"mtkld/phxm.nvim",
	config = function()
		require("phxm").setup({})

		-- We put this here, to let project manager start it,
		-- if nvim is opened with file as arg, dont start it
		if vim.fn.argc() > 0 then
			return
		end
		-- why this defer is the case I do not know,
		-- but intuition tells me...
		-- If Treesitter hasn't fully parsed the Markdown/Lua buffer yet, ...?
		-- Chat 4o's answer:
		-- Why Even 1ms Delay Works
		--    1ms delay doesn’t mean "1ms after now"
		--    It means "run this after all other queued startup events finish."
		-- This seem to apply only when nvim is starting up, but after that, it works as a normal timer. Chat 4o's answer:
		-- 	Before Neovim is fully started → The function waits until startup is done.
		--	After startup → The function behaves like a normal timer (runs in ~1ms).
		--    vim.defer_fn(function()
		--      require('mdtoc').start()
		--      require('mdtoc').enable()
		--    end, 100)
		--
		--    vim.defer_fn(function()
		--      require('fixedspace').toggle()
		--    end, 1)
	end,
}
