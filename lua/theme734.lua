-- Extras a plain colorscheme file can't do on its own: route the cursor
-- through the `Cursor` group (so it turns orange instead of inheriting the
-- terminal's color) and flash yanks with `Yank734`.
--
-- Opt out before `:colorscheme 734`:
--   vim.g.theme734_cursor = false  -- leave 'guicursor' alone
--   vim.g.theme734_yank = false    -- no yank flash

local M = {}

local attached = false

local function is_734()
	return (vim.g.colors_name or ""):match("^734") ~= nil
end

-- true when some mode in 'guicursor' already names Cursor/lCursor, i.e. the
-- user picked their own cursor groups and we should not touch it
local function has_cursor_group(gc)
	for part in gc:gmatch("[^,]+") do
		for word in part:gmatch("[^:%-]+") do
			if word == "Cursor" or word == "lCursor" or word:match("^Cursor/") then
				return true
			end
		end
	end
	return false
end

local function set_cursor()
	if vim.g.theme734_cursor == false then
		return
	end
	local gc = vim.o.guicursor
	if gc == "" or has_cursor_group(gc) then
		return
	end
	-- attach Cursor/lCursor to every mode except terminal, which keeps
	-- TermCursor so :terminal still shows the program's own cursor
	local parts = {}
	for part in gc:gmatch("[^,]+") do
		local modes = part:match("^([^:]+):")
		if modes and not modes:match("^t$") then
			part = part .. "-Cursor/lCursor"
		end
		table.insert(parts, part)
	end
	vim.o.guicursor = table.concat(parts, ",")
end

function M.attach()
	set_cursor()
	if attached then
		return
	end
	attached = true
	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("theme734", { clear = true }),
		desc = "734: orange yank flash",
		callback = function()
			if vim.g.theme734_yank == false or not is_734() then
				return
			end
			vim.hl.on_yank({ higroup = "Yank734", timeout = 150 })
		end,
	})
end

return M
