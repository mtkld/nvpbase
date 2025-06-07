return {
	"mtkld/greatinit.nvim",
	priority = 10000, -- otherwise settings may not apply, like colored row numbers are reset to white
	config = function()
		-- Set tabstop to 2 spaces (visual width of a tab character)
		--vim.o.tabstop = 3

		-- Set softtabstop to 2 (number of spaces inserted when pressing <Tab>)
		--vim.o.softtabstop = 2

		-- Set shiftwidth to 2 (number of spaces used for each indentation step)
		--vim.o.shiftwidth = 2

		-- Use spaces instead of tabs
		--vim.o.expandtab = true

		--
		--
		-------------------------------------------------------
		----------------START OF SECTION-----------------------
		-------------------------------------------------------
		--
		--  This section within the marked start and end, is from kickstart.nvim.
		--
		-- MODIFICATIONS HAVE BEEN MADE TO THE ORIGINAL CODE
		--
		-- Source repo: https://github.com/nvim-lua/kickstart.nvim
		-- Source file: https://github.com/nvim-lua/kickstart.nvim/blob/master/init.lua
		-- Commit SHA: 76cb865e4f3bd985fef9f209023d762eaa0f81e6
		-- Commit Time: 2025-05-09T23:41:44Z
		-- License: MIT (see below)

		--------------------------------------------------------------------------
		-- MIT License
		--
		-- Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
		--
		-- The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
		--
		-- THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
		--------------------------------------------------------------------------

		-- Set <space> as the leader key
		-- See `:help mapleader`
		--  NOTE: Must happen before plugins are loaded (otherwise wrong leader will be used)
		--vim.g.mapleader = ' '
		--vim.g.maplocalleader = ' '
		--
		-- Set to true if you have a Nerd Font installed and selected in the terminal
		vim.g.have_nerd_font = false

		-- Make line numbers default
		vim.opt.number = true
		-- You can also add relative line numbers, to help with jumping.
		--  Experiment for yourself to see if you like it!
		-- vim.opt.relativenumber = true

		-- Enable mouse mode, can be useful for resizing splits for example!
		vim.opt.mouse = "a"

		-- Don't show the mode, since it's already in the status line
		vim.opt.showmode = false

		-- Sync clipboard between OS and Neovim.
		--  Schedule the setting after `UiEnter` because it can increase startup-time.
		--  Remove this option if you want your OS clipboard to remain independent.
		--  See `:help 'clipboard'`
		vim.schedule(function()
			vim.opt.clipboard = "unnamedplus"
		end)

		-- Enable break indent
		vim.opt.breakindent = true

		-- Save undo history
		vim.opt.undofile = true

		-- Case-insensitive searching UNLESS \C or one or more capital letters in the search term
		vim.opt.ignorecase = true
		vim.opt.smartcase = true

		-- Keep signcolumn on by default
		vim.opt.signcolumn = "yes"

		-- Decrease update time
		vim.opt.updatetime = 250

		-- Decrease mapped sequence wait time
		-- Displays which-key popup sooner
		-- or 500...
		vim.opt.timeoutlen = 300

		-- Configure how new splits should be opened
		vim.opt.splitright = true
		vim.opt.splitbelow = true

		-- Sets how neovim will display certain whitespace characters in the editor.
		--  See `:help 'list'`
		--  and `:help 'listchars'`
		vim.opt.list = true
		vim.opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

		-- Preview substitutions live, as you type!
		vim.opt.inccommand = "split"

		-- Show which line your cursor is on
		vim.opt.cursorline = true

		-- Minimal number of screen lines to keep above and below the cursor.
		vim.opt.scrolloff = 10

		-- [[ Basic Keymaps ]]
		--  See `:help vim.keymap.set()`

		-- Clear highlights on search when pressing <Esc> in normal mode
		--  See `:help hlsearch`

		-- Added this:
		vim.opt.hlsearch = true

		vim.keymap.set("n", "<Esc>", "<cmd>nohlsearch<CR>")

		-- Exit terminal mode in the builtin terminal with a shortcut that is a bit easier
		-- for people to discover. Otherwise, you normally need to press <C-\><C-n>, which
		-- is not what someone will guess without a bit more experience.
		--
		-- NOTE: This won't work in all terminal emulators/tmux/etc. Try your own mapping
		-- or just use <C-\><C-n> to exit terminal mode
		--vim.keymap.set('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

		-- [[ Basic Autocommands ]]
		--  See `:help lua-guide-autocommands`

		-- Highlight when yanking (copying) text
		--  Try it with `yap` in normal mode
		--  See `:help vim.highlight.on_yank()`
		vim.api.nvim_create_autocmd("TextYankPost", {
			desc = "Highlight when yanking (copying) text",
			group = vim.api.nvim_create_augroup("kickstart-highlight-yank", { clear = true }),
			callback = function()
				vim.highlight.on_yank()
			end,
		})

		-----------------------------------------------------
		----------------END OF SECTION-----------------------
		-----------------------------------------------------
		-- Basic settings

		-- Doesnt help delay in tmux running in nvim terminal, delay of 1 sec or so when pressing esc to exit insert mode in for ex fish shell
		--set ttimeoutlen=10
		--    vim.o.ttimeoutlen = 10

		-- :echo &undodir
		-- Standard path is ~/.local/state/nvim/undo/
		-- vim.opt.undodir = the_undodir_path
		vim.opt.undolevels = 10000 -- Increase the number of undo levels
		vim.opt.undoreload = 10000 -- Increase the number of lines to save for undo

		-- Set the background color to none (transparent)
		vim.cmd([[hi Normal guibg=NONE ctermbg=NONE]])

		-- Lua configuration
		vim.api.nvim_set_hl(0, "FloatBorder", { fg = "#565f89", bg = "#1a1b26" })
		vim.api.nvim_set_hl(0, "NormalFloat", { fg = "#c0caf5", bg = "#3d1717" })

		vim.api.nvim_set_hl(0, "LineNrAbove", { fg = "#51B3EC", bold = false })
		vim.api.nvim_set_hl(0, "LineNr", { fg = "white", bold = true })
		--vim.api.nvim_set_hl(0, 'LineNrBelow', { fg = '#FB508F', bold = false })
		vim.api.nvim_set_hl(0, "LineNrBelow", { fg = "#51B3EC", bold = false })

		-- Set the status line for the active window
		vim.api.nvim_set_hl(0, "StatusLine", { bg = "#222222", fg = "#a3be8c", bold = true })

		-- Set the status line for inactive windows
		vim.api.nvim_set_hl(0, "StatusLineNC", { bg = "#222222", fg = "#d8dee9", bold = false })

		-- Set the color of all other line numbers (general)
		-- vim.api.nvim_set_hl(0, "LineNr", { ctermfg = 244 }) -- Use your preferred color code

		vim.o.number = true
		vim.o.relativenumber = true

		-- Auto write files
		vim.o.autowriteall = true

		-- TODO: Later move this to the key plugin
		-- Key mappings
		local keymap = vim.api.nvim_set_keymap
		local opts = { noremap = true, silent = true }

		vim.opt.spell = true
		-- vim.opt.spelllang = 'en_us'
		vim.opt.spelllang = "en_us,sv"

		-- Not needed as all are enabled by default above
		-- -- Enable spellcheck for markdown files
		-- vim.api.nvim_create_autocmd("FileType", {
		--     pattern = "markdown",
		--     callback = function()
		--         vim.opt.spell = true -- Enable spellcheck for markdown
		--     end,
		-- })

		-- Disable spellcheck for all other file types
		vim.api.nvim_create_autocmd("FileType", {
			pattern = "*", -- This matches all file types
			callback = function()
				if vim.bo.filetype ~= "markdown" then
					vim.opt.spell = false -- Disable spellcheck for non-markdown files
				end
			end,
		})

		vim.opt.signcolumn = "no"

		-- Remember last cursor position in file
		-- vim.opt.viewoptions = 'cursor,folds' -- ensures cursor position and folds are remembered
		-- This function is better, remembers more than Vim's built-in options, according to GPT
		-- Thus shuold not need function to remember position
		vim.api.nvim_create_autocmd("BufReadPost", {
			callback = function()
				local mark = vim.api.nvim_buf_get_mark(0, '"')
				local lcount = vim.api.nvim_buf_line_count(0)
				if mark[1] > 0 and mark[1] <= lcount then
					vim.api.nvim_win_set_cursor(0, mark)
				end
			end,
		})

		-- Start bash lsp
		--   Installed
		--    ◍ lua-language-server lua_ls
		--    ◍ shfmt
		--    ◍ stylua

		-- TODO: Is this still active and used? Does it work as expected?
		vim.api.nvim_create_autocmd("BufWritePre", {
			callback = function()
				local buf_ft = vim.bo.filetype

				-- Use shfmt for shell scripts
				if buf_ft == "sh" or buf_ft == "bash" then
					require("conform").format({
						async = false, -- Synchronous formatting for shell scripts
					})
				end

				-- Use Prettierd for supported filetypes
				if
					buf_ft == "javascript"
					or buf_ft == "typescript"
					or buf_ft == "css"
					or buf_ft == "html"
					or buf_ft == "json"
					or buf_ft == "markdown"
					or buf_ft == "yaml"
				then
					require("conform").format({
						async = false, -- Synchronous formatting for Prettierd
					})
				end
				-- Use stylua for Lua files
				if buf_ft == "lua" then
					require("conform").format({
						async = false, -- Synchronous formatting for Lua
						lsp_fallback = true,
					})
				end
			end,
		})

		-- the ; key is otherwise for flash plugin to jump to next occurence when doing f operator
		vim.keymap.set("n", ";", function()
			local command = require("phxm.properties").current_project.project_path .. "/terminal_command_quick_run"
			require("ctxterm").terminal_command_quick_run(command, true)
		end, { noremap = true, silent = true })

		-- Ctrl-Q to quit without saving
		-- No q! as we have autowriteall on
		vim.keymap.set("n", "<C-q>", ":q<CR>", { noremap = true, silent = true })
		vim.keymap.set("i", "<C-q>", "<Esc>:q<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<C-q>", "<Esc>:q<CR>", { noremap = true, silent = true })

		-- Ctrl-A to save the current file
		vim.keymap.set("n", "<C-a>", ":w<CR>", { noremap = true, silent = true })
		vim.keymap.set("i", "<C-a>", "<Esc>:w<CR>", { noremap = true, silent = true }) -- a
		vim.keymap.set("v", "<C-a>", "<Esc>:w<CR>", { noremap = true, silent = true }) -- gv
		--
		--      -- Ctrl-X to save and quit
		vim.keymap.set("n", "<C-x>", ":wq<CR>", { noremap = true, silent = true })
		vim.keymap.set("i", "<C-x>", "<Esc>:wq<CR>", { noremap = true, silent = true })
		vim.keymap.set("v", "<C-x>", "<Esc>:wq<CR>", { noremap = true, silent = true })

		-- TODO: fix these, do they work?

		-- Map Enter to insert a new line below the current line and return to normal mode with cursor on the original line
		vim.keymap.set("n", "<Enter>", "mxo<Esc>`x", { noremap = true, silent = true })

		-- Map Shift+Enter to insert a new line above the current line and return to normal mode with cursor on the original line
		vim.keymap.set("n", "<S-Enter>", "mxO<Esc>`x", { noremap = true, silent = true })

		-- Key mappings to select the entire file
		vim.keymap.set("n", "<F5>", "ggVG", { noremap = true, silent = true })
		vim.keymap.set("v", "<F5>", "ggVG", { noremap = true, silent = true })
		vim.keymap.set("s", "<F5>", "ggVG", { noremap = true, silent = true })

		-- Key mappings to copy to system clipboard
		vim.keymap.set("n", "<F6>", '"+y', { noremap = true, silent = true })
		vim.keymap.set("v", "<F6>", '"+y', { noremap = true, silent = true })
		vim.keymap.set("s", "<F6>", '"+y', { noremap = true, silent = true })

		-- Insert mode mappings (switch to normal mode first)
		vim.keymap.set("i", "<F5>", "<Esc>ggVG", { noremap = true, silent = true })
		vim.keymap.set("i", "<F6>", '<Esc>"+y', { noremap = true, silent = true })

		-- Non-leader mappings
		-- TODO: Review the use of these mappings
		vim.keymap.set("n", "gn", ":bnext<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "gp", ":bprevious<CR>", { noremap = true, silent = true })
		vim.keymap.set("n", "gx", ":bdelete<CR>", { noremap = true, silent = true })

		-- vim.api.nvim_set_keymap('n', '<C-p>', ':Lazy update<CR>', { noremap = true, silent = true })

		-- Close buffer without saving (leader+q)
		vim.keymap.set("n", "<leader>q", ":bd!<CR>", { noremap = true, silent = true })

		-- Save and close buffer (leader+x)
		vim.keymap.set("n", "<leader>x", ":w | bd<CR>", { noremap = true, silent = true })

		-- Toggle terminal set to project dir
		vim.keymap.set(
			"n",
			"<A-k>",
			'<CMD>lua require("ctxterm").toggle_context_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-k>",
			'<CMD>lua require("ctxterm").toggle_context_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-k>",
			'<CMD>lua require("ctxterm").toggle_context_terminal()<CR>',
			{ noremap = true, silent = true }
		)

		vim.keymap.set(
			"n",
			"<A-j>",
			'<CMD>lua require("ctxterm").create_new_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-j>",
			'<CMD>lua require("ctxterm").create_new_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-j>",
			'<CMD>lua require("ctxterm").create_new_terminal()<CR>',
			{ noremap = true, silent = true }
		)

		vim.keymap.set(
			"n",
			"<A-l>",
			'<CMD>lua require("ctxterm").next_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-l>",
			'<CMD>lua require("ctxterm").next_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-l>",
			'<CMD>lua require("ctxterm").next_terminal()<CR>',
			{ noremap = true, silent = true }
		)

		vim.keymap.set(
			"n",
			"<A-h>",
			'<CMD>lua require("ctxterm").previous_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-h>",
			'<CMD>lua require("ctxterm").previous_terminal()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-h>",
			'<CMD>lua require("ctxterm").previous_terminal()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle terminal buffer setup
		vim.keymap.set(
			"n",
			"<A-i>",
			'<CMD>lua require("permtermbuf").tt_setup.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-i>",
			'<CMD>lua require("permtermbuf").tt_setup.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-i>",
			'<CMD>lua require("permtermbuf").tt_setup.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle NNN
		vim.keymap.set(
			"n",
			"<A-f>",
			'<CMD>lua require("permtermbuf").filemanager.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-f>",
			'<CMD>lua require("permtermbuf").filemanager.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-f>",
			'<CMD>lua require("permtermbuf").filemanager.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle Neomutt
		vim.keymap.set(
			"n",
			"<A-m>",
			'<CMD>lua require("permtermbuf").neomutt.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-m>",
			'<CMD>lua require("permtermbuf").neomutt.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-m>",
			'<CMD>lua require("permtermbuf").neomutt.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle adash
		vim.keymap.set(
			"n",
			"<A-a>",
			'<CMD>lua require("permtermbuf").adash.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-a>",
			'<CMD>lua require("permtermbuf").adash.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-a>",
			'<CMD>lua require("permtermbuf").adash.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle nntm
		vim.keymap.set(
			"n",
			"<A-n>",
			'<CMD>lua require("permtermbuf").nntm.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-n>",
			'<CMD>lua require("permtermbuf").nntm.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-n>",
			'<CMD>lua require("permtermbuf").nntm.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- Toggle Lazygit
		vim.keymap.set(
			"n",
			"<A-g>",
			'<CMD>lua require("permtermbuf").lazygit.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"t",
			"<A-g>",
			'<CMD>lua require("permtermbuf").lazygit.toggle()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			"i",
			"<A-g>",
			'<CMD>lua require("permtermbuf").lazygit.toggle()<CR>',
			{ noremap = true, silent = true }
		)

		-- mdtoc stuff
		-- Also support highlighting in visual mode so we can jump to the heading
		vim.keymap.set({ "n", "v" }, "<C-n>", function()
			local count = vim.v.count -- Get the count if provided
			if count > 0 then
				require("mdtoc").jump_to(count)
			else
				require("mdtoc").next_heading()
			end
		end, { noremap = true, silent = true })

		vim.keymap.set({ "n", "v" }, "<C-p>", function()
			local count = vim.v.count -- Get the count if provided
			if count > 0 then
				require("mdtoc").jump_to(-count)
			else
				require("mdtoc").prev_heading()
			end
		end, { noremap = true, silent = true })

		--    vim.keymap.set({ 'n', 'v' }, '<C-n>', '<CMD>lua require("mdtoc").next_heading()<CR>', { noremap = true, silent = true })
		--    vim.keymap.set({ 'n', 'v' }, '<C-p>', '<CMD>lua require("mdtoc").prev_heading()<CR>', { noremap = true, silent = true })
		vim.keymap.set(
			{ "n", "v" },
			"<C-h>",
			'<CMD>lua require("mdtoc").telescope_headings()<CR>',
			{ noremap = true, silent = true }
		)

		vim.keymap.set(
			{ "n", "v" },
			"<C-k>",
			'<CMD>lua require("mdtoc").preview_outline_summary()<CR>',
			{ noremap = true, silent = true }
		)

		vim.keymap.set(
			{ "n", "v" },
			"<C-j>",
			'<CMD>lua require("mdtoc").ask_ai_about_visual_selection()<CR>',
			{ noremap = true, silent = true }
		)
		vim.keymap.set(
			{ "n", "v" },
			"<C-i>",
			'<CMD>lua require("mdtoc").ask_ai_and_replace_selection()<CR>',
			{ noremap = true, silent = true }
		)

		-- bubblecol
		vim.api.nvim_set_keymap("n", "<tab>", "", {
			noremap = true,
			silent = true,
			callback = function()
				local key = vim.fn.getcharstr() -- Capture a single key press immediately
				if key and #key == 1 then
					require("bubblecol").call_appropriate_action(key) -- Call appropriate action
				end
			end,
		})

		vim.api.nvim_set_keymap("v", "<tab>", "", {
			noremap = true,
			silent = true,
			callback = function()
				local key = vim.fn.getcharstr() -- Capture a single key press immediately
				if key and #key == 1 then
					require("bubblecol").call_appropriate_action(key) -- Call appropriate action
				end
			end,
		})
		--

		-- Function to create a comment box
		vim.keymap.set("n", "<C-c>", function()
			local filetype = vim.bo.filetype
			local comment_syntax = {
				php = "//",
				bash = "#",
				javascript = "//",
				python = "#",
			}

			local comment_start = comment_syntax[filetype] or "//"
			local max_line_length = 76 -- Define the maximum line length for the comment box

			-- Function to create a full decorative line
			local function create_decorative_line()
				return comment_start
					.. string.rep("-", max_line_length - 2 - string.len(comment_start))
					.. comment_start
			end

			-- Prompt user for comment
			local comment_text = vim.fn.input("Enter comment text: ")
			if comment_text == "" then
				print("No comment entered")
				return
			end

			local padding_length = (max_line_length - string.len(comment_text) - 2 * string.len(comment_start) - 1) / 2
			local padded_comment = comment_start
				.. " "
				.. string.rep(" ", math.floor(padding_length))
				.. comment_text
				.. string.rep(" ", math.ceil(padding_length) - 1)
				.. comment_start

			local row = vim.api.nvim_win_get_cursor(0)[1]
			local lines_to_insert = { create_decorative_line(), padded_comment, create_decorative_line(), "" }
			vim.api.nvim_buf_set_lines(0, row, row, false, lines_to_insert)

			-- Move cursor to the empty line just below the inserted box
			vim.api.nvim_win_set_cursor(0, { row + #lines_to_insert, 0 })
		end, { noremap = true, silent = true, desc = "Insert or Edit Comment Box" })

		--   vim.api.nvim_set_keymap('n', 'C-s', '<CMD>lua InsertOrEditCommentBox()<CR>', { noremap = true, silent = true })

		--     vim.keymap.set(
		--       'n', -- Mode (normal)
		--       'p', -- Key to map
		--       'lua print "just testing"', -- Lua code to run
		--       { noremap = true, silent = true, desc = 'Toggle PermtermBuf Project Selection' }
		--     )
		--
		--     -- Remap 'p' to your desired functionality
		--     vim.keymap.set(
		--       'n', -- Mode (normal)
		--       'pp', -- Key to map
		--       ":lua require('permtermbuf').promansel.toggle()<CR>",
		--       { noremap = true, silent = true, desc = 'Toggle PermtermBuf Project Selection' }
		--     )

		-- Proman select (leader+pp)
		--   vim.keymap.set('n', ' pk', ":lua require('proman').assign_key_to_current_project()<CR>", { noremap = true, silent = true, desc = 'Assign key to project' })
		-- and so on... but these are defined in keypoint.nvim

		-- Visual mode mappings for function outer and inner text objects
		vim.keymap.set("x", "af", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@function.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("x", "if", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@function.inner")
		end, { noremap = true, silent = true })

		-- Operator-pending mode mappings for function outer and inner text objects
		vim.keymap.set("o", "af", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@function.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("o", "if", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@function.inner")
		end, { noremap = true, silent = true })

		-- Visual mode mappings for block outer and inner text objects
		vim.keymap.set("x", "ab", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@block.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("x", "ib", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@block.inner")
		end, { noremap = true, silent = true })

		-- Operator-pending mode mappings for block outer and inner text objects
		vim.keymap.set("o", "ab", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@block.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("o", "ib", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@block.inner")
		end, { noremap = true, silent = true })

		-- Visual mode mappings for conditional outer and inner text objects
		vim.keymap.set("x", "ai", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@conditional.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("x", "ii", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@conditional.inner")
		end, { noremap = true, silent = true })

		-- Operator-pending mode mappings for conditional outer and inner text objects
		vim.keymap.set("o", "ai", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@conditional.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("o", "ii", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@conditional.inner")
		end, { noremap = true, silent = true })

		-- Visual mode mappings for loop outer and inner text objects
		vim.keymap.set("x", "al", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@loop.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("x", "il", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@loop.inner")
		end, { noremap = true, silent = true })

		-- Operator-pending mode mappings for loop outer and inner text objects
		vim.keymap.set("o", "al", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@loop.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("o", "il", function()
			require("nvim-treesitter.textobjects.select").select_textobject("@loop.inner")
		end, { noremap = true, silent = true })

		-------------------
		-------------------

		-- Optionally, map these using `vim.keymap.set` for consistency
		vim.keymap.set("n", "]f", function()
			require("nvim-treesitter.textobjects.move").goto_next_start("@function.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[f", function()
			require("nvim-treesitter.textobjects.move").goto_previous_start("@function.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "]F", function()
			require("nvim-treesitter.textobjects.move").goto_next_end("@function.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[F", function()
			require("nvim-treesitter.textobjects.move").goto_previous_end("@function.outer")
		end, { noremap = true, silent = true })

		-- Next/Previous loop start and end
		vim.keymap.set("n", "]l", function()
			require("nvim-treesitter.textobjects.move").goto_next_start("@loop.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[l", function()
			require("nvim-treesitter.textobjects.move").goto_previous_start("@loop.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "]L", function()
			require("nvim-treesitter.textobjects.move").goto_next_end("@loop.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[L", function()
			require("nvim-treesitter.textobjects.move").goto_previous_end("@loop.outer")
		end, { noremap = true, silent = true })

		-- Next/Previous condition start and end
		vim.keymap.set("n", "]i", function()
			require("nvim-treesitter.textobjects.move").goto_next_start("@conditional.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[i", function()
			require("nvim-treesitter.textobjects.move").goto_previous_start("@conditional.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "]I", function()
			require("nvim-treesitter.textobjects.move").goto_next_end("@conditional.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[I", function()
			require("nvim-treesitter.textobjects.move").goto_previous_end("@conditional.outer")
		end, { noremap = true, silent = true })

		-- Next/Previous block start
		vim.keymap.set("n", "]b", function()
			require("nvim-treesitter.textobjects.move").goto_next_start("@block.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[b", function()
			require("nvim-treesitter.textobjects.move").goto_previous_start("@block.outer")
		end, { noremap = true, silent = true })

		-- Next/Previous block end
		vim.keymap.set("n", "]B", function()
			require("nvim-treesitter.textobjects.move").goto_next_end("@block.outer")
		end, { noremap = true, silent = true })

		vim.keymap.set("n", "[B", function()
			require("nvim-treesitter.textobjects.move").goto_previous_end("@block.outer")
		end, { noremap = true, silent = true })

		-- Fixes:
		-- We need to help treesitter with bash files, it seem to not associate bash files to the parser that is installed, but complains no parser for 'sh'
		vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
			pattern = { "*" },
			callback = function()
				local line = vim.fn.getline(1)
				if line:match("^#!.*bash") or line:match("^#!.*sh") then
					vim.bo.filetype = "bash"
				end
			end,
		})

		-- Inteliphense
		-- Therefore, just use cwd to set intelephense's root dir.
		-- Use LspInfo vim cmd to see status.
		-- Autocomplete for ex should work, indicating it is working.
		--      require('lspconfig').intelephense.setup {
		--        root_dir = vim.loop.cwd,
		--        on_attach = function(client, bufnr)
		--          -- Your on_attach code, if any
		--        end,
		--        flags = {
		--          debounce_text_changes = 150,
		--        },
		--      }

		--------------------
		-- Override Kickstart
		--------------------
		-- TODO: Is this a problem here, what about buffer_number? Does it exit?
		-- Just don't set it to begin with, and no need to unset here
		--vim.keymap.del('t', '<Esc><Esc>', { buffer = buffer_number })

		-- NOTE: This still seem to work.
		-- Bash LSP, with Mason bash lsp server
		local cmp = require("cmp")
		cmp.setup({

			mapping = {
				-- Select the next item in the completion menu
				["<C-n>"] = cmp.mapping.select_next_item(),

				-- Select the previous item in the completion menu
				["<C-p>"] = cmp.mapping.select_prev_item(),

				-- Confirm the selected item with <Tab>
				["<C-Space>"] = cmp.mapping.confirm({ select = true }),
			},
			sources = {
				{ name = "nvim_lsp" }, -- Add this to use LSP as a completion source
				{ name = "buffer" }, -- Optional: buffer completion
				{ name = "path" }, -- Optional: path completion
			},
			-- You can add other configurations here as well
		})

		--vim.api.nvim_create_autocmd('TermOpen', {
		--  pattern = '*',
		--  callback = function()
		--    vim.cmd 'set nospell'
		--  end,
		--})

		require("greatinit").setup({})
	end,
}
