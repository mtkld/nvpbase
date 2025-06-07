return {
	"mtkld/dynkey.nvim",
	config = function()
		require("dynkey").setup()
		local plugin = require("dynkey")

		-- Setup the plugin
		plugin.setup({})

		--    -- Add a key group (not finalized yet)
		--    plugin.add_group('group1', '<leader>g')
		--
		--    -- Add keys to the group (stored in pending table)
		--    plugin.make_key('group1', 'key_id1', function()
		--      print 'First function'
		--    end)
		--    plugin.make_key('group1', 'key_id2', function()
		--      print 'Second function'
		--    end)
		--
		--    -- Finalize the group (assign keys and update shadow)
		--    plugin.finalize 'group1'
		--
		--    -- Trying to add more keys after finalizing will be denied
		--    plugin.make_key('group1', 'key_id3', function()
		--      print 'Third function'
		--    end)
	end,
}
