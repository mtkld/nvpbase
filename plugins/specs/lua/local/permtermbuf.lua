return {
	"mtkld/permtermbuf.nvim",
	dependencies = {
		"mtkld/phxm.nvim",
	},
	config = function()
		require("permtermbuf").setup({
			--      {
			--        name = 'phxmsel',
			--        cmd = 'nnn %nav_path% -S -p -',
			--        buffer_name = 'phxmsel',
			--        callback_pre_exec_cmd = function(cmd)
			--          -- Get the project base path
			--          local project_base_path = require('phxm.properties').current_project.project_path
			--
			--          -- Define the path to the '.latest-project-nav-path' file
			--          local latest_nav_path_file = project_base_path .. '/.latest_project_nav_path'
			--
			--          -- Check if the '.latest-project-nav-path' file exists, otherwise use the project base path
			--          local nav_path = project_base_path
			--          if vim.fn.filereadable(latest_nav_path_file) == 1 then
			--            local nav_path_content = vim.fn.readfile(latest_nav_path_file)
			--            if #nav_path_content > 0 then
			--              nav_path = nav_path_content[1] -- Use the first line in the file as the nav path
			--            end
			--          end
			--          -- Substitute %nav_path% with the determined nav_path
			--          return cmd:gsub('%%nav_path%%', nav_path)
			--        end,
			--        callback_on_exit = function(output)
			--          -- Concatenate output into a single string and split it into lines (file paths)
			--          local file_paths = vim.split(table.concat(output, '\n'), '\n', { trimempty = true })
			--
			--          -- If no paths were returned, do nothing
			--          if #file_paths == 0 then
			--            return
			--          end
			--
			--          -- We will just use the first path from the file_paths, assuming it's the selected one
			--          local selected_project = file_paths[1]
			--
			--          -- Call the switch_to_project function with the selected project
			--          if selected_project then
			--            require('phxm.project').external_plugin_call_switch_to_project(selected_project)
			--          else
			--            vim.notify('No valid project selected', vim.log.levels.WARN)
			--          end
			--        end,
			--      },
			{
				name = "phxmsel",
				cmd = "lf -config ~/.config/lf/pathselectionrc -print-last-dir %nav_path%",
				buffer_name = "phxmsel",
				callback_pre_exec_cmd = function(cmd)
					-- Get the project base path
					local root_path = require("phxm.properties").root.root_path

					-- Check if the '.latest-project-nav-path' file exists, otherwise use the project base path
					local nav_path = root_path
					-- Substitute %nav_path% with the determined nav_path
					return cmd:gsub("%%nav_path%%", nav_path)
				end,
				callback_on_exit = function(output)
					-- Concatenate output into a single string and split it into lines (file paths)
					-- LF returns the last directory as the first line but we are interested in the selected directory
					--local file_paths = vim.split(table.concat(output, '\n'), '\n', { trimempty = true })

					-- Read the file to open from /tmp/lf_selection_output
					local selection_file = "/tmp/lf_selection_output"
					if vim.fn.filereadable(selection_file) == 0 then
						vim.notify("No selection file found.", vim.log.levels.WARN)
						return
					end
					local file_paths = vim.fn.readfile(selection_file)

					-- Trim whitespace from each line
					for i, path in ipairs(file_paths) do
						file_paths[i] = vim.trim(path)
					end

					if #file_paths == 0 or file_paths[1] == "" then
						vim.notify("No files selected.", vim.log.levels.WARN)
						return
					end
					local selected_project = file_paths[1]

					-- Call the switch_to_project function with the selected project
					if selected_project then
						require("phxm.project").external_plugin_call_switch_to_project(selected_project)
					else
						vim.notify("No valid project selected", vim.log.levels.WARN)
					end
				end,
			},

			{
				name = "tt_setup",
				cmd = "tt-setup-once-then-ressurect",
				callback_post_exec_cmd = function()
					-- No spellcheck on terminal buffer
					vim.cmd("set nospell")
				end,
				buffer_name = "tmux",
			},
			{
				name = "adash",
				cmd = "adash ~/remote/matkalkyl.dev/adash",
				buffer_name = "adash-term",
			},
			{
				name = "neomutt",
				cmd = "aerc",
				buffer_name = "neomutt",
			},
			{
				name = "nntm",
				cmd = "nntm /tmp/nntm-stream",
				buffer_name = "nntmx",
				auto_start = true,

				-- NOTE: Didn't need this, permtermbuf not setting vim.cmd("stopinsert") caused trouble in toggling quickly
				-- Now permtermbuf does stopinsert when toggling away from the terminal
				--		setup_func = function()
				--			-- somewhere after permtermbuf has been `require`d and configured
				--			vim.api.nvim_create_autocmd("User", {
				--				pattern = "phxmPostLoaded",
				--				once = true, -- run only the first time the event fires
				--				callback = function()
				--					local perm = require("permtermbuf")
				--					perm.nntm.toggle() -- open
				--					perm.nntm.toggle() -- close (leaves job running, UI restored)
				--				end,
				--			})
				--		end,
			},

			{
				name = "lazygit",
				cmd = "lazygit --path %git_dir%",
				buffer_name = "lazygit",
				-- first_toggle_cmd = 'nnn -S -p - %cwd%',
				-- Version to traverse upwards till we find the git root directory
				--        callback_pre_exec_cmd = function(cmd)
				--          -- Find the current file's absolute directory path
				--          local current_file_dir = vim.fn.expand '%:p:h'
				--
				--          -- Traverse backward and stop at the .git directory
				--          local git_dir = vim.fn.finddir('.git', current_file_dir .. ';')
				--
				--          -- If no .git directory is found, print a message and return nil
				--          if git_dir == '' then
				--            print 'No .git directory found. Press Enter to continue.'
				--            vim.fn.input '' -- Wait for the user to press Enter
				--            return nil -- Return nil to indicate no git directory was found
				--          end
				--
				--          -- Go one step up (remove the trailing '/.git' from the path)
				--          local git_root_dir = vim.fn.fnamemodify(git_dir, ':h')
				--
				--          -- Substitute %git_dir% with the git root directory and return the updated command
				--          return cmd:gsub('%%git_dir%%', git_root_dir)
				--        end,
				callback_pre_exec_cmd = function(cmd)
					-- Get the current project path from phxm.properties
					local project_path = require("phxm.properties").current_project.project_path

					-- Ensure project_path ends with a '/'
					if not project_path:match("/$") then
						project_path = project_path .. "/"
					end

					-- Construct the path to the 'gitdir' file
					local gitdir_file = project_path .. "gitdir"

					-- Check if the 'gitdir' file exists and is a file (not a directory)
					if vim.fn.filereadable(gitdir_file) == 0 then
						print('The "gitdir" file does not exist or is not readable in the project directory.')
						return nil
					end

					-- Read the content of the 'gitdir' file to get the Git root directory
					local git_root_dir = vim.fn.readfile(gitdir_file)
					if #git_root_dir == 0 then
						print('The "gitdir" file is empty.')
						return nil
					end

					-- Trim any whitespace or newline characters from the Git root directory path
					git_root_dir = vim.trim(git_root_dir[1])

					-- Substitute `%git_dir%` with the Git root directory in the command
					return cmd:gsub("%%git_dir%%", git_root_dir)
				end,
			},

			{
				name = "filemanager",
				cmd = "lf -config ~/.config/lf/pathselectionrc -print-last-dir %cwd%",
				buffer_name = "filemanager",
				callback_pre_exec_cmd = function(cmd)
					-- Get the current project directory from phxm
					local project_dir = require("phxm.properties").current_project.project_path

					-- Path to the .filesystem_file_pick_open_file within the current project directory
					local latest_path_file = project_dir .. "/.filesystem_file_pick_open_file"

					-- We need delete it for new use
					local selection_file = "/tmp/lf_selection_output"
					if vim.fn.filereadable(selection_file) == 1 then
						vim.fn.delete(selection_file)
					end

					-- Determine the cwd based on the latest path file or fallback to project directory
					local cwd
					if vim.fn.filereadable(latest_path_file) == 1 then
						local latest_path = vim.fn.readfile(latest_path_file)
						if #latest_path > 0 then
							cwd = vim.trim(latest_path[1]) -- Use the first line as cwd if valid
						else
							cwd = project_dir -- Default to project directory if file is empty
						end
					else
						cwd = project_dir -- Default to project directory if file does not exist
					end

					-- Substitute %cwd% in the command
					return cmd:gsub("%%cwd%%", cwd)
				end,
				callback_on_exit = function(output)
					-- Save the directory returned in output[1] to .filesystem_file_pick_open_file
					local project_dir = require("phxm.properties").current_project.project_path
					local latest_path_file = project_dir .. "/.filesystem_file_pick_open_file"

					local selected_dir = output[1] or ""
					if selected_dir == "" then
						vim.notify("No directory selected.", vim.log.levels.WARN)
						return
					end
					-- We may get other thing as output from the executed program, filemanager, like 'only single file or directory is allowed'
					-- need check if its valid path

					if vim.fn.isdirectory(selected_dir) == 1 then
						-- Save the valid directory to the latest path file
						vim.fn.writefile({ selected_dir }, latest_path_file)
					else
						-- Handle invalid outputs gracefully
						vim.notify('Invalid output from lf: "' .. selected_dir .. '"', vim.log.levels.ERROR)
						return
					end

					-- Read the file to open from /tmp/lf_selection_output
					local selection_file = "/tmp/lf_selection_output"
					if vim.fn.filereadable(selection_file) == 0 then
						vim.notify("No selection file found.", vim.log.levels.WARN)
						return
					end

					local file_paths = vim.fn.readfile(selection_file)

					-- Trim whitespace from each line
					for i, path in ipairs(file_paths) do
						file_paths[i] = vim.trim(path)
					end

					if #file_paths == 0 or file_paths[1] == "" then
						vim.notify("No files selected.", vim.log.levels.WARN)
						return
					end

					local file_path = file_paths[1]
					-- Open the selected file if it exists
					if vim.fn.filereadable(file_path) == 1 then
						vim.cmd("edit " .. vim.fn.fnameescape(file_path))

						require("phxm.buffer").record_buffer_change()
						-- Trigger necessary autocommands manually to ensure features like treesitter work
						vim.cmd("doautocmd BufReadPost")
						vim.cmd("doautocmd FileType")
					else
						--vim.notify('The file does not exist: ' .. file_path, vim.log.levels.ERROR)
						vim.notify("The file does not exist: ", vim.log.levels.ERROR)
					end
				end,
			},
			--      {
			--        name = 'nnn',
			--        cmd = 'nnn %cwd% -s -p -',
			--        buffer_name = 'nnn',
			--        callback_pre_exec_cmd = function(cmd)
			--          -- get the current project directory from proman
			--          local project_dir = require('phxm.properties').current_project.project_path
			--
			--          -- path to the .nnn_file_pick_latest_path file within the current project directory
			--          local latest_path_file = project_dir .. '/.nnn_file_pick_latest_path'
			--
			--          -- check if .nnn_file_pick_latest_path exists, otherwise use the project directory
			--          local cwd
			--          if vim.fn.filereadable(latest_path_file) == 1 then
			--            -- read the latest path from the file
			--            local latest_path = vim.fn.readfile(latest_path_file)
			--            if #latest_path > 0 then
			--              cwd = latest_path[1] -- use the first line as the cwd
			--            else
			--              cwd = project_dir -- default to project directory if file is empty
			--            end
			--          else
			--            cwd = project_dir -- default to project directory if file does not exist
			--          end
			--
			--          -- substitute %cwd% with the determined directory
			--          return cmd:gsub('%%cwd%%', cwd)
			--        end,
			--        callback_on_exit = function(output)
			--          -- concatenate output into a single string and split it into lines (file paths)
			--          local file_path = table.concat(output, '\n'):gsub('\n', '') -- clean up the output
			--
			--          -- if no path was returned, do nothing
			--          if file_path == '' then
			--            return
			--          end
			--
			--          -- save the parent directory of the selected file to .nnn_file_pick_latest_path
			--          local selected_dir = vim.fn.fnamemodify(file_path, ':h') -- get the directory of the selected file
			--          local project_dir = require('phxm.properties').current_project.project_path
			--          local latest_path_file = project_dir .. '/.nnn_file_pick_latest_path'
			--
			--          vim.fn.writefile({ selected_dir }, latest_path_file)
			--
			--          -- open the selected file if it exists
			--          if vim.fn.filereadable(file_path) == 1 then
			--            vim.cmd('edit ' .. vim.fn.fnameescape(file_path))
			--
			--            -- trigger the necessary autocommands manually to ensure treesitter works
			--            vim.cmd 'doautocmd bufreadpost'
			--            vim.cmd 'doautocmd filetype'
			--          else
			--            -- notify if the file doesn't exist
			--            vim.notify('the file does not exist: ' .. file_path, vim.log.levels.error)
			--          end
			--        end,
			--      },

			{
				name = "phxm_add_dir",
				cmd = "lf -config ~/.config/lf/pathselectionrc -print-last-dir %cwd%",
				buffer_name = "phxm_add_dir",
				callback_pre_exec_cmd = function(cmd)
					-- Define the path to the latest path file
					local project_dir = require("phxm.properties").current_project.project_path
					local latest_path_file = project_dir .. "/.fs_file_pick_latest_path_for_add_dir"

					-- We need delete it for new use
					local selection_file = "/tmp/lf_selection_output"
					if vim.fn.filereadable(selection_file) == 1 then
						vim.fn.delete(selection_file)
					end

					-- Determine the cwd to use
					local cwd
					if vim.fn.filereadable(latest_path_file) == 1 then
						local file_content = vim.fn.readfile(latest_path_file)
						if #file_content > 0 then
							-- Trim whitespace from the first line
							local trimmed_path = vim.trim(file_content[1])
							if #trimmed_path > 0 then
								cwd = trimmed_path -- Use the trimmed path if it's valid
							end
						end
					end

					-- Fall back to the current working directory if no valid path was found
					cwd = cwd or vim.fn.getcwd()
					-- Substitute %cwd% in the command
					return cmd:gsub("%%cwd%%", cwd)
				end,
				callback_on_exit = function(output)
					-- Parse the last directory from the output
					--local last_dir = output[#output] or ''

					local last_dir = output[1] or ""

					-- Get the current project directory
					local project_dir = require("phxm.properties").current_project.project_path
					-- Define the path to the '.nnn_file_pick_latest_path' file
					local latest_path_file = project_dir .. "/.fs_file_pick_latest_path_for_add_dir"

					if last_dir ~= "" then
						-- Update the '.nnn_file_pick_latest_path' with the latest directory
						vim.fn.writefile({ last_dir }, latest_path_file)
					end

					-- Read file selections from /tmp/lf_selection_output
					local selection_file = "/tmp/lf_selection_output"
					if vim.fn.filereadable(selection_file) == 0 then
						return "No selection file found."
					end

					local file_paths = vim.fn.readfile(selection_file)

					-- If no paths were returned, do nothing
					if #file_paths == 0 then
						return "No files selected."
					end

					-- Define the path to the 'include' file
					local include_file_path = project_dir .. "/include"

					-- Read the contents of the 'include' file if it exists, otherwise create an empty list
					local include_file_content = {}
					if vim.fn.filereadable(include_file_path) == 1 then
						include_file_content = vim.fn.readfile(include_file_path)
					end

					-- Create a set of existing file paths for fast lookup
					local existing_paths = {}
					for _, line in ipairs(include_file_content) do
						existing_paths[line] = true
					end

					-- Add any new file paths to the 'include' file
					local new_paths_added = false
					for _, file_path in ipairs(file_paths) do
						if not existing_paths[file_path] then
							table.insert(include_file_content, file_path)
							new_paths_added = true
						end
					end

					-- Write the updated content back to the 'include' file if new paths were added
					if new_paths_added then
						vim.fn.writefile(include_file_content, include_file_path)
						require("phxm.project").redo_symlinks()
						return "New file paths added to include."
					else
						return "No new file paths to add."
					end
				end,
			},

			--      {
			--        name = 'phxm_add_dir',
			--        cmd = 'nnn %cwd% -S -p -',
			--        buffer_name = 'phxm_add_dir',
			--        callback_pre_exec_cmd = function(cmd)
			--          -- Get the current working directory and substitute %cwd% with it
			--          local cwd = vim.fn.getcwd()
			--          return cmd:gsub('%%cwd%%', cwd)
			--        end,
			--        callback_on_exit = function(output)
			--          -- Concatenate output into a single string and split it into lines (file paths)
			--          local file_paths = vim.split(table.concat(output, '\n'), '\n', { trimempty = true })
			--
			--          -- If no paths were returned, do nothing
			--          if #file_paths == 0 then
			--            return
			--          end
			--
			--          -- Get the current project directory
			--          local project_dir = require('phxm.properties').current_project.project_path
			--
			--          -- Define the path to the 'include' file
			--          local include_file_path = project_dir .. '/include'
			--
			--          -- Read the contents of the 'include' file if it exists, otherwise create an empty list
			--          local include_file_content = {}
			--          if vim.fn.filereadable(include_file_path) == 1 then
			--            include_file_content = vim.fn.readfile(include_file_path)
			--          end
			--
			--          -- Create a set of existing file paths for fast lookup
			--          local existing_paths = {}
			--          for _, line in ipairs(include_file_content) do
			--            existing_paths[line] = true
			--          end
			--
			--          -- Add any new file paths to the 'include' file
			--          local new_paths_added = false
			--          for _, file_path in ipairs(file_paths) do
			--            if not existing_paths[file_path] then
			--              table.insert(include_file_content, file_path)
			--              new_paths_added = true
			--            end
			--          end
			--
			--          -- Write the updated content back to the 'include' file if new paths were added
			--          if new_paths_added then
			--            vim.fn.writefile(include_file_content, include_file_path)
			--            require('phxm.project').redo_symlinks()
			--            return 'New file paths added to include.'
			--          else
			--            return 'No new file paths to add.'
			--          end
			--        end,
			--      },
		})
	end,
}
