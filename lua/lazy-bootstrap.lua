local M = {}
M.ensure = function()
	-- lazy.nvim bootstrapper
	--
	-- Overview: This code has been taken from the `kickstart.nvim` repository.
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

	-- [[ Install `lazy.nvim` plugin manager ]]
	--    See `:help lazy.nvim.txt` or https://github.com/folke/lazy.nvim for more info
	local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
	if not (vim.uv or vim.loop).fs_stat(lazypath) then
		local lazyrepo = "https://github.com/folke/lazy.nvim.git"
		local out = vim.fn.system({ "git", "clone", "--filter=blob:none", "--branch=stable", lazyrepo, lazypath })
		if vim.v.shell_error ~= 0 then
			error("Error cloning lazy.nvim:\n" .. out)
		end
	end ---@diagnostic disable-next-line: undefined-field
	vim.opt.rtp:prepend(lazypath)
end

return M
