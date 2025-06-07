return {
	"mtkld/bubblecol.nvim",
	dependencies = {},
	config = function()
		require("bubblecol").setup({
			storage_path_cb = function()
				return require("phxm").opts.root .. "/.bubblecol.json"
			end,
			updater_cb = function()
				vim.defer_fn(function()
					local buf_id = require("fixedspace").buf_id2
					if buf_id and vim.api.nvim_buf_is_valid(buf_id) then
						require("bubblecol").display_data(buf_id)
					else
						log("DEBUG: buf_id is not valid00000000000000000000000000000")
					end
				end, 1) -- defer 1ms to ensure buf_id2 is set and buffer is fully loaded

				--check if valid buffer
			end,

			line_formatter_1_cb = function(data)
				if not data or #data < 2 then
					return { text = "Invalid data", offsets = {}, color_seeds = {} }
				end

				local first_part = data[1]:match("^.*/([^/]+)$") or data[1] -- current_project
				local path = data[2]

				-- Extract the last two parts: the parent directory and the last segment
				local parent, last_part = path:match(".*/([^/]+)/([^/]+)$")

				-- If no match (e.g., very short path), return the original path
				local extracted_part = parent and last_part and (parent .. "/" .. last_part) or path

				-- Construct the final formatted text
				local formatted_text = first_part .. "\\" .. extracted_part

				-- Calculate positions
				local first_start = 1
				local first_end = #first_part
				local extracted_start = first_end + 2 --+ 4 -- Account for " \\ " (3 chars + 1 for Lua 1-based index)
				local extracted_end = extracted_start + #extracted_part - 1
				return {
					text = formatted_text,
					color_seeds = { data[1], data[2] }, -- Store without keys
					offsets = {
						{ start = first_start, end_ = first_end }, -- First part offset
						{ start = extracted_start, end_ = extracted_end }, -- Second part offset
					},
				}
			end,

			line_formatter_2_cb = function(data)
				-- Ensure valid data
				if not data or #data < 3 then
					return { text = "Invalid data", offsets = {}, color_seeds = {} }
				end

				-- Extract only the inserted text (previously stored in slot 2)
				local inserted_text = data[3]

				-- Ensure inserted text is valid
				if not inserted_text or inserted_text == "" then
					return { text = "No inserted text", offsets = {}, color_seeds = {} }
				end

				-- Construct the final formatted text (just the inserted text)
				local formatted_text = inserted_text

				-- Calculate positions (entire text is highlighted)
				local start_pos = 1
				local end_pos = #inserted_text

				return {
					text = formatted_text,
					color_seeds = { inserted_text }, -- Store as a simple list
					offsets = {
						{ start = start_pos, end_ = end_pos }, -- Highlight whole text
					},
				}
			end,

			line_formatter_3_cb = function(data)
				-- Ensure valid data
				if not data or #data < 3 then
					return { text = "Invalid data", offsets = {}, color_seeds = {} }
				end

				-- Extract stored text (previously saved in slot 3)
				local stored_text = data[3]

				-- Ensure stored text is valid
				if not stored_text or stored_text == "" then
					return { text = "No stored text", offsets = {}, color_seeds = {} }
				end

				-- Replace newlines with a literal '\n' and remove carriage returns
				local sanitized_text = stored_text:gsub("\n", "\\n"):gsub("\r", "")

				-- Trim leading and trailing whitespace
				sanitized_text = sanitized_text:match("^%s*(.-)%s*$") or ""

				-- Truncate text to 150 characters
				if #sanitized_text > 150 then
					sanitized_text = sanitized_text:sub(1, 150) .. "..."
				end

				-- Calculate highlight positions (entire text is highlighted)
				local start_pos = 1
				local end_pos = #sanitized_text

				return {
					text = sanitized_text,
					color_seeds = { stored_text }, -- Store as a simple list
					offsets = {
						{ start = start_pos, end_ = end_pos }, -- Highlight entire formatted text
					},
				}
			end,

			--      line_formatter_3_cb = function(data)
			--        if not data or #data < 3 then
			--          return { text = 'Invalid data', offsets = {}, color_seeds = {} }
			--        end
			--
			--        local project_name = data[1]:match '^.*/([^/]+)$' or data[1] -- current_project
			--        local header = data[3] -- data.header
			--
			--        -- Extract the last two parts of `header` (assumed to be a path)
			--        local parent, last_part = header:match '.*/([^/]+)/([^/]+)$'
			--
			--        -- If no match (e.g., very short path), fallback to `header` as is
			--        local extracted_part = parent and last_part and (parent .. '/' .. last_part) or header
			--
			--        -- Construct the final formatted text
			--        local formatted_text = project_name .. ' \\ ' .. extracted_part
			--
			--        -- Calculate positions
			--        local project_start = 1
			--        local project_end = #project_name
			--        local extracted_start = project_end + 4 -- " \\ " is 3 chars + 1 for Lua 1-based indexing
			--        local extracted_end = extracted_start + #extracted_part - 1
			--
			--        return {
			--          text = formatted_text,
			--          color_seeds = { data[1], data[3] }, -- Store as a simple list
			--          offsets = {
			--            { start = project_start, end_ = project_end }, -- Project name offset
			--            { start = extracted_start, end_ = extracted_end }, -- Extracted part offset
			--          },
			--        }
			--      end,
			-- ---------------------------------------------- --
			--        Actoins
			-- ---------------------------------------------- --
			--  slot_select_action_3_cb = function(char)
			--    --        local data = M.get_data_by_char(char)
			--    local data = require('bubblecol').get_data_by_char(char)
			--    if data then
			--      local project_name, path, header = unpack(data) -- Extract the triplet
			--      -- Now you can use project_name, path, and header as needed
			--      print('slot_select_action_3_cb', project_name, path, header)
			--      require('phxm.project').switch_to_project(project_name)
			--      require('phxm.buffer').switch_to_buffer_by_path(path)
			--      --          M.goto_header(header)
			--    end
			--  end,
			--

			-- ---------------------------------------------- --
			--        Actoins
			-- ---------------------------------------------- --
			slot_select_action_1_cb = function(char)
				--        local data = M.get_data_by_char(char)
				local data = require("bubblecol").get_data_by_char(char)
				if data then
					local project_name, path, header = unpack(data) -- Extract the triplet
					-- Now you can use project_name, path, and header as needed
					print("slot_select_action_3_cb", project_name, path)
					require("phxm.project").switch_to_project(project_name)
					require("phxm.buffer").switch_to_buffer_by_path(path)
					--          M.goto_header(header)
				end
			end,
			slot_select_action_2_cb = function(char)
				-- Get the stored data for the selected char
				local data = require("bubblecol").get_data_by_char(char)

				if data then
					local project_name, path, inserted_text = unpack(data) -- Extract the triplet

					-- Ensure we have valid text to insert
					if inserted_text and inserted_text:match("%S") then
						-- Get the current cursor position
						local cursor_pos = vim.api.nvim_win_get_cursor(0)
						local line_number = cursor_pos[1]
						local col_number = cursor_pos[2]

						-- Get the current line text
						local line_text = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1] or ""

						-- Insert text at cursor position
						local new_line_text = line_text:sub(1, col_number)
							.. inserted_text
							.. line_text:sub(col_number + 1)

						-- Update the buffer with the new text
						vim.api.nvim_buf_set_lines(0, line_number - 1, line_number, false, { new_line_text })

						-- Move the cursor after the inserted text
						vim.api.nvim_win_set_cursor(0, { line_number, col_number + #inserted_text })
					end
				end
			end,
			slot_select_action_3_cb = function(char)
				-- Get the stored data for the selected char
				local data = require("bubblecol").get_data_by_char(char)

				if data then
					local project_name, path, yanked_text = unpack(data) -- Extract the triplet

					-- Ensure we have valid text to insert
					if yanked_text and yanked_text:match("%S") then
						-- Get the current buffer and cursor position
						local bufnr = vim.api.nvim_get_current_buf()
						local cursor_pos = vim.api.nvim_win_get_cursor(0)
						local line_number = cursor_pos[1]
						local col_number = cursor_pos[2]

						-- Ensure buffer is modifiable
						if not vim.bo[bufnr].modifiable then
							vim.bo[bufnr].modifiable = true
						end

						-- Split text into a list of lines (preserve original newlines)
						local lines = vim.split(yanked_text, "\n", { plain = true })

						-- Get current line text
						local current_line = vim.api.nvim_buf_get_lines(bufnr, line_number - 1, line_number, false)[1]
							or ""

						-- Extract parts before and after cursor position
						local first_part = current_line:sub(1, col_number)
						local second_part = current_line:sub(col_number + 1)

						-- Insert first part into the first line of `lines`
						lines[1] = first_part .. lines[1]

						-- Append the second part of the current line to the last inserted line
						lines[#lines] = lines[#lines] .. second_part

						-- Replace the affected lines in the buffer
						vim.api.nvim_buf_set_lines(bufnr, line_number - 1, line_number, false, lines)

						-- Move the cursor correctly:
						if #lines == 1 then
							-- Single-line insertion (word insert mid-line): place cursor after inserted text
							local new_cursor_col = col_number + #yanked_text
							vim.api.nvim_win_set_cursor(0, { line_number, new_cursor_col })
						else
							-- Multi-line insertion: move cursor to the correct line & position
							local new_cursor_line = line_number + #lines - 1
							local new_cursor_col = #lines[#lines] - #second_part
							vim.api.nvim_win_set_cursor(0, { new_cursor_line, new_cursor_col })
						end
					end
				end
			end,
		})

		if not require("phxm").opts.is_loaded then
			return
		end
		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPostLoaded",
			callback = function()
				require("bubblecol").start()
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
		--    vim.api.nvim_create_autocmd('User', {
		--      pattern = 'mdtocStatuslineHeaderChanged',
		--      callback = function(event)
		--        --        if require('mdtoc').update_is_disabled then
		--        --          return
		--        --        end
		--        local data = event.data
		--        --local current_project = require('phxm.properties').current_project.name
		--        local buf_name = vim.api.nvim_buf_get_name(0)
		--        local project_path = require('phxm.properties').current_project.project_path
		--        --print('mdtocStatuslineHeaderChanged', current_project, buf_name, data.header, data.line)
		--        require('bubblecol').add(3, { project_path, buf_name, data.header }, { data.line })
		--        require('bubblecol').update_display()
		--      end,
		--    })
		local last_col = nil
		local last_text = ""

		-- Capture inserted text dynamically
		vim.api.nvim_create_autocmd("TextChangedI", {
			callback = function()
				-- Get buffer name and project path
				local buf_name = vim.api.nvim_buf_get_name(0)
				local project_path = require("phxm.properties").current_project.project_path

				-- Get cursor position
				local cursor_pos = vim.api.nvim_win_get_cursor(0)
				local line_number = cursor_pos[1]
				local col_number = cursor_pos[2]

				-- Get the full line of text
				local line_text = vim.api.nvim_buf_get_lines(0, line_number - 1, line_number, false)[1] or ""

				-- If first character is typed, initialize last_col
				if last_col == nil then
					last_col = col_number - 1 -- Start tracking from where the first character is inserted
				end

				-- Capture newly typed text (adjusting for first character)
				local new_text = ""
				if last_col < col_number then
					new_text = line_text:sub(last_col + 1, col_number)
				end

				-- Update last_col for next event
				last_col = col_number

				-- Append to last_text (handles multi-event inserts)
				last_text = last_text .. new_text
			end,
		})

		-- Submit inserted text when leaving insert mode
		vim.api.nvim_create_autocmd("InsertLeave", {
			callback = function()
				if last_text and last_text:match("%S") then
					local buf_name = vim.api.nvim_buf_get_name(0)
					local project_path = require("phxm.properties").current_project.project_path
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					local line_number = cursor_pos[1]

					-- Insert only the typed text into slot 2
					require("bubblecol").add(2, { project_path, buf_name, last_text }, { line_number })
					require("bubblecol").update_display()
				end

				-- Reset tracking values
				last_text = ""
				last_col = nil
			end,
		})

		vim.api.nvim_create_autocmd("TextYankPost", {
			callback = function()
				vim.schedule(function()
					local buf_name = vim.api.nvim_buf_get_name(0)
					local project_path = require("phxm.properties").current_project.project_path
					local cursor_pos = vim.api.nvim_win_get_cursor(0)
					local line_number = cursor_pos[1]

					-- Get yanked/deleted text from the unnamed register (preserve newlines)
					local yanked_text = vim.fn.getreg('"')

					-- Ensure valid text
					if yanked_text and yanked_text:match("%S") then
						-- Store the original text **with newlines intact** (DO NOT replace newlines)
						require("bubblecol").add(3, { project_path, buf_name, yanked_text }, { line_number })
						require("bubblecol").update_display()
					end
				end)
			end,
		})

		--    vim.api.nvim_create_autocmd('User', {
		--      pattern = 'preSwitchToProject',
		--      callback = function(event)
		--        require('mdtoc').update_is_disabled = true
		--      end,
		--    })
		--
		--    vim.api.nvim_create_autocmd('User', {
		--      pattern = 'postSwitchToProject',
		--      callback = function(event)
		--        vim.defer_fn(function()
		--          require('mdtoc').update_is_disabled = false
		--        end, 1)
		--      end,
		--    })
		--
		--
		-- NOTE: NOTE NEEDED
		--    vim.api.nvim_create_autocmd('User', {
		--      pattern = 'postSwitchToProject',
		--      callback = function()
		--        log 'DEBUG: postSwitchProject has fired!'
		--        require('bubblecol').update_display()
		--      end,
		--    })

		vim.api.nvim_create_autocmd("User", {
			pattern = "phxmPostSwitchedBuffer",
			callback = function(event)
				-- Get the buffer name (full path)
				local buf_name = vim.api.nvim_buf_get_name(0)

				-- Check if the buffer has a valid file path and exists on disk
				if buf_name ~= "" and vim.fn.filereadable(buf_name) == 1 then
					local project_path = require("phxm.properties").current_project.project_path
					--          local current_project = require('phxm.properties').current_project.name
					require("bubblecol").add(1, { project_path, buf_name })
					require("bubblecol").update_display()
				end
			end,
		})
		--    vim.api.nvim_create_autocmd('BufEnter', {
		--      callback = function()
		--        -- Get the buffer name (full path)
		--        local buf_name = vim.api.nvim_buf_get_name(0)
		--
		--        -- Check if the buffer has a valid file path and exists on disk
		--        if buf_name ~= '' and vim.fn.filereadable(buf_name) == 1 then
		--          local current_project = require('phxm.properties').current_project.name
		--          require('bubblecol').add(1, { current_project, buf_name })
		--          require('bubblecol').update_display()
		--        end
		--      end,
		--    })
		vim.api.nvim_create_autocmd("BufEnter", {
			callback = function()
				--vim.api.nvim_create_autocmd('User', {
				-- pattern = 'postSwitchToProject',
				-- callback = function()
				log("postSwitchToProject")
				-- Get the buffer name (full path)
				vim.defer_fn(function()
					local buf_name = vim.api.nvim_buf_get_name(0)

					-- Check if the buffer has a valid file path and exists on disk
					if buf_name ~= "" and vim.fn.filereadable(buf_name) == 1 then
						--          local current_project = require('phxm.properties').current_project.name
						local project_path = require("phxm.properties").current_project.project_path
						require("bubblecol").add(1, { project_path, buf_name })
						require("bubblecol").update_display()
					end
				end, 100)
			end,
		})
	end,
}
