-- Sets up the screenshot scene once ts_ls has attached and published its
-- diagnostics: a search for CONTRAST_MIN, the cursor on a call to
-- `contrast`, and its hover float. Writes $SHOT_DONE when ready.
if vim.env.SHOT_VARIANT == "light" then
	vim.cmd.colorscheme("734-light")
end

local function ready()
	vim.cmd("let @/ = 'CONTRAST_MIN' | set hlsearch")
	local row = vim.fn.search("contrast(hex, palette", "nw")
	local col = vim.fn.getline(row):find("contrast") - 1
	vim.api.nvim_win_set_cursor(0, { row, col })
	-- below, so the float covers closing braces rather than the git changes
	vim.lsp.buf.hover({ anchor_bias = "below" })
	vim.defer_fn(function()
		vim.cmd("echo ''")
		vim.fn.writefile({}, vim.env.SHOT_DONE)
	end, 1500)
end

local done = false
vim.api.nvim_create_autocmd("DiagnosticChanged", {
	callback = function()
		if done or #vim.diagnostic.get(0) == 0 then
			return
		end
		done = true
		-- let gitsigns and the rest of the first redraws settle
		vim.defer_fn(ready, 1000)
	end,
})
