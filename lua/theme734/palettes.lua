-- Palette for each variant. Groups (lua/theme734/groups.lua) refer to these
-- by name, so a color changed here changes everywhere it's used. Light mirrors
-- dark role for role: the same hue plays the same part in both.

-- shared by both variants: Claude Code's orange cursor
local common = {
	black = "#000000",
	cursor = "#d77757",
	on_cursor = "#000000",
}

local palettes = {
	-- dark is Ghostty's built-in "Atom" theme. Comments give the ANSI slot;
	-- only the comment grey and the blends are off-theme.
	dark = {
		bg = "#161719", -- background
		fg = "#c5c8c6", -- foreground
		surface = "#000000", -- ansi 0: cursorline, menus, folds
		surface2 = "#444444", -- selection-background: selection, splits, guides
		dim = "#4c4c4c", -- ansi 8: borders, relative line numbers, whitespace
		comment = "#80848b", -- Atom's ansi 8 is 2:1 on bg, this is 4.8:1
		subtle = "#c5c8c6",
		bright = "#e0e0e0", -- ansi 7/15, operators
		on_accent = "#000000", -- text on a syntax color used as background
		purple = "#b9b6fc", -- ansi 5/13, keywords and accent
		red = "#fd5ff1", -- ansi 1/9, `return`, exceptions, errors
		blue = "#85befd", -- ansi 4/6/14, functions and tags
		green = "#87c38a", -- ansi 2, strings
		yellow = "#f5ffa8", -- ansi 11, types and modules
		orange = "#ffd7b1", -- ansi 3, numbers, constants, tag attributes
		property = "#96cbfe", -- ansi 12, properties and fields
		lime = "#94fa36", -- ansi 10, builtins, macros, escapes
		tag_punct = "#807ead", -- purple blended 65% into bg: `<`, `>`, `=` in tags
		search_bg = "#f5ffa8",
		bar_bg = "#000000", -- statusline: black with white text
		bar_fg = "#ffffff",
		-- diff backgrounds: the accent blended into bg, so syntax shows through
		diff_add = "#2a362d", -- green 18%
		diff_delete = "#402440", -- red 18%
		diff_change = "#232b34", -- blue 12%
		diff_text = "#2e3c4b", -- blue 22%
		-- :terminal gets the theme's 16 ANSI colors as they are
		ansi = {
			"#000000", "#fd5ff1", "#87c38a", "#ffd7b1", "#85befd", "#b9b6fc", "#85befd", "#e0e0e0",
			"#4c4c4c", "#fd5ff1", "#94fa36", "#f5ffa8", "#96cbfe", "#b9b6fc", "#85befd", "#e0e0e0",
		},
	},
	-- every syntax color is at least 5.3:1 on bg and 4.7:1 on surface
	light = {
		bg = "#ffffff",
		fg = "#241f31",
		surface = "#f3f2f8",
		surface2 = "#e2e0f6",
		dim = "#a8a5b0",
		comment = "#6c6873",
		subtle = "#6c6873",
		bright = "#241f31",
		on_accent = "#ffffff",
		purple = "#5b43d6",
		red = "#bd1a9c",
		blue = "#0a5fc4",
		green = "#0f7a52",
		yellow = "#7d6000",
		orange = "#b04400",
		property = "#17709e",
		lime = "#4f7700",
		tag_punct = "#745fdc", -- purple blended 85% into bg
		search_bg = "#ffe28a",
		bar_bg = "#ffffff", -- statusline: same as the editor
		bar_fg = "#241f31",
		diff_add = "#ddece7", -- green 14%
		diff_delete = "#f7e4f3", -- red 12%
		diff_change = "#e9f1fa", -- blue 9%
		diff_text = "#cedff3", -- blue 20%
		-- "black" is the text color and "white" a mid grey, so programs
		-- printing either stay readable
		ansi = {
			"#241f31", "#bd1a9c", "#0f7a52", "#b04400", "#0a5fc4", "#5b43d6", "#17709e", "#6c6873",
			"#a8a5b0", "#bd1a9c", "#4f7700", "#7d6000", "#17709e", "#5b43d6", "#0a5fc4", "#241f31",
		},
	},
}

for name, palette in pairs(palettes) do
	palettes[name] = vim.tbl_extend("error", common, palette)
end

return palettes
