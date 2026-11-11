-- Loads the colorscheme (colors/734.lua and colors/734-light.lua call `load`).
-- Besides highlight groups, it routes the cursor through `Cursor` so the
-- theme, not the terminal, colors it, and flashes yanks with `Yank734`.
--
-- Opt out before `:colorscheme 734`:
--   vim.g.theme734_cursor = false  -- leave 'guicursor' alone
--   vim.g.theme734_yank = false    -- no yank flash

local M = {}

-- variant is "dark" or "light"
function M.load(variant)
	vim.o.background = variant
	vim.cmd("hi clear")
	if vim.g.syntax_on then
		vim.cmd("syntax reset")
	end
	vim.g.colors_name = variant == "light" and "734-light" or "734"

	-- re-read the color files on every :colorscheme, like a .vim colorscheme
	-- is re-sourced, so edits show up without restarting
	package.loaded["theme734.palettes"] = nil
	package.loaded["theme734.groups"] = nil
	local c = require("theme734.palettes")[variant]
	for name, spec in pairs(require("theme734.groups")(c)) do
		vim.api.nvim_set_hl(0, name, spec)
	end
	for i, color in ipairs(c.ansi) do -- :terminal's 16 ANSI colors
		vim.g["terminal_color_" .. (i - 1)] = color
	end

	-- "a:" adds the highlight to every mode without changing cursor shapes
	local gc = vim.o.guicursor
	if vim.g.theme734_cursor ~= false and gc ~= "" and not gc:find("Cursor/lCursor", 1, true) then
		vim.opt.guicursor:append("a:Cursor/lCursor")
	end

	vim.api.nvim_create_autocmd("TextYankPost", {
		group = vim.api.nvim_create_augroup("theme734", { clear = true }),
		desc = "734: yank flash",
		callback = function()
			if vim.g.theme734_yank ~= false and (vim.g.colors_name or ""):match("^734") then
				vim.hl.on_yank({ higroup = "Yank734", timeout = 150 })
			end
		end,
	})
end

return M
