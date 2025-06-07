-- Helper function to create and show a float
return {
	"mtkld/keypoint.nvim",
	dependencies = {
		"fmc-sh/phxm.nvim",
	},
	--opts =
	config = function()
		-- Build the keys for project directories.
		if not require("phxm").opts.is_loaded then
			log("Keypoint Not Loaded: phxm not loaded")
			return
		end

		--    local project_key_name_list = require('phxm.project_keys').scan_project_dirs_for_keys(require('phxm.properties').root.root_path)
		--    local project_keys_config = {}
		--
		--    -- Iterate through the key-name pairs and create the key-action table
		--    for _, entry in ipairs(project_key_name_list) do
		--      project_keys_config[entry.key] = {
		--        desc = entry.name,
		--        action = function()
		--          require('phxm.project').external_plugin_call_switch_to_project(entry.path)
		--        end,
		--      }
		--    end
		local project_keys_config = require("phxm.project").get_subsequent_project_keys_for_keypoint_mapping()

		-- Example: Print out the project_keys_config to verify the keys
		require("keypoint").setup({

			-- NOTE: when not is_dynamic, then subsequent+keys must be set
			mode = {
				n = {
					select_project_keys = {
						["-"] = {
							desc = "Switch project keys",
							is_dynamic = false,
							key_span = "global",
							subsequent_keys = project_keys_config,
						},
					},
					-- TODO: Change this group name
					left_right_motions = {
						["<BS>"] = function()
							require("phxm.project").switch_to_previous_project()
						end,
						[","] = function()
							require("phxm.buffer").switch_to_previous_buffer()
						end,
						--['.'] = function() end,
						["<"] = function() end,
						-- Left-right motion group
						--TODO: Some day, add the callback local callback_is_selected = function(str)
						-- so the menu builder in keypoint can know if to select item
						["z"] = {
							is_dynamic = true,
							key_span = "buffer",
							desc = "Function jumping keys",
							desc_callback = function()
								return "Functoin jump | " .. vim.api.nvim_buf_get_name(0)
							end,
						},
						["="] = {
							is_dynamic = true,
							key_span = "project",
							desc = "Buffer switching keys",
							desc_callback = function()
								return "Buffer switching | " .. require("phxm.properties").current_project.name
							end,
						},
						[" "] = {
							desc = "phxm keys",
							desc_callback = function()
								return "Project commands | " .. require("phxm.properties").current_project.name
							end,
							key_span = "global",
							is_dynamic = false,
							subsequent_keys = {
								["p"] = {
									desc = "Toggle project selection permtermbuf",
									action = function()
										require("permtermbuf").phxmsel.toggle()
									end,
								},
								--['I'] = {
								--  desc = 'Terminal Open Project Dir',
								--  action = function()
								--    require('phxm.user_actions').open_terminal()
								--  end,
								--},
								["i"] = {
									desc = "Display Project Info",
									action = function()
										require("phxm.user_actions").displai_project_info()
									end,
								},
								["c"] = {
									desc = "Close all buffers",
									action = function()
										require("phxm.user_actions").close_all_buffers()
										require("phxm.buffer").re_bind_buffer_keys()
									end,
								},
								["a"] = {
									desc = "Add Dir To Project",
									action = function()
										require("permtermbuf").phxm_add_dir.toggle()
									end,
								},
								["l"] = {
									desc = "List Included Directories",
									action = function()
										require("phxm.user_actions").list_included_dirs()
									end,
								},

								["y"] = {
									desc = "Global Yank Buffer",
									action = function()
										require("phxm.user_actions").open_yank_buffer()
									end,
								},

								["d"] = {
									desc = "Jump to Function",
									action = function()
										require("phxm.user_actions").telescope_filter_function_definitions()
									end,
								},

								["D"] = {
									desc = "Jump to Function (Under Cursor)",
									action = function()
										require("phxm.user_actions").telescope_filter_function_definition_under_cursor()
									end,
								},

								["F"] = {

									-- TOOD: Not impl...
									desc = "File Search Include Paths (mem)",
									action = function()
										require("phxm.user_actions").search_in_project_include_remember_last_search()
									end,
								},

								["f"] = {
									desc = "File Search Include Paths",
									action = function()
										require("phxm.user_actions").search_in_project_include()
									end,
								},
								["o"] = {
									desc = "TODO Add",
									action = function()
										require("phxm.user_actions").todo_add()
									end,
								},
								["r"] = {
									desc = "Readme Edit",
									action = function()
										require("phxm.user_actions").open_readme()
									end,
								},
								["t"] = {
									desc = "TODO Open List",
									action = function()
										require("phxm.user_actions").todo_open_list()
									end,
								},
								["T"] = {
									desc = "Buffer Dir Tree",
									action = function()
										require("phxm.user_actions").open_dir_tree()
									end,
								},
								["B"] = {
									desc = "Buffer Switching History",
									action = function()
										require("phxm.buffer").open_buffer_switching_history()
									end,
								},

								["P"] = {
									desc = "Project Switching History",
									action = function()
										require("phxm.project").open_project_switching_history()
									end,
								},

								["G"] = {
									desc = "File Grep Include Paths (mem)",
									action = function()
										require("phxm.user_actions").grep_in_project_include_under_cursor()
									end,
								},
								["g"] = {
									desc = "File Grep Include Paths",
									action = function()
										require("phxm.user_actions").grep_in_project_include()
									end,
								},
								["s"] = {
									desc = "Switch Project via Telescope",
									action = function()
										require("phxm.user_actions").switch_project_via_telescope()
									end,
								},
								["k"] = {
									desc = "Assign key to project",
									action = function()
										require("phxm.user_actions").assign_key_to_current_project()
										local subsequent_keys =
											require("phxm.project").get_subsequent_project_keys_for_keypoint_mapping()
										require("keypoint").rebind_subsequent_key_for_static_key_prefix(
											"-",
											subsequent_keys
										)
									end,
								},
								["n"] = {
									desc = "Name current project",
									action = function()
										require("phxm.user_actions").name_current_project()
									end,
								},
								["m"] = {
									desc = "Name current buffer",
									action = function()
										require("phxm.user_actions").name_current_buffer()
									end,
								},
								["q"] = {
									desc = "Delete current buffer",
									action = function()
										-- Delete the current buffer without closing the window
										require("phxm.user_actions").delete_buffer()
									end,
								},
							},
						},

						-- ['0'] = 'l', -- Move cursor to the first character in the line (also: <Home> key)
						--['p'] = 'p', -- Move cursor to the first character in the line (also: <Home> key)

						-- it is possible to do this:
						--          ['px'] = function()
						--            print 'abc' -- Move cursor to the first character in the line (also: <Home> key)
						--          end,
						-- also this:
						--          ['p'] = "lua ...", or ['p'] = "p"
						-- and you can use muliple keys like "px" for the left side

						--          [';'] = 'q', -- Move cursor to the first character in the line (also: <Home> key)

						--          [' '] = function()
						--            -- Simulate showing available key options in the command-line preview area
						--            local available_keys = {
						--              { 'p', 'Execute "pp" action' },
						--              { 'q', 'Execute "pq" action' },
						--              { 'x', 'Some othjer action' },
						--            }
						--            available_keys = generate_test_keys(50)
						--
						--            show_key_hints(available_keys)
						--
						--            print 'printing test'
						--            -- Get the next key pressed after 'p'
						--            local next_key = vim.fn.getchar() -- Read the next input key
						--
						--            -- Convert the key code to a string if necessary
						--            next_key = vim.fn.nr2char(next_key)
						--
						--            -- Check the next key and execute the command
						--            if next_key == 'p' then
						--              print "Executing 'pp' command"
						--            elseif next_key == 'q' then
						--              print "Executing 'pq' command"
						--            -- You can bind more actions based on additional keys here
						--            -- For example: vim.cmd("normal! some_command")
						--            else
						--              print("No action defined for 'p" .. next_key .. "'")
						--            end
						--          end,
					},
				},
			},
		})
	end,
}
