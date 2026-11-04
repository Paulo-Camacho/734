-- Palette for each variant. Groups (lua/theme734/groups.lua) refer to these
-- by name, so a color changed here changes everywhere it's used.
return {
	-- dark is Ghostty's built-in "Atom" theme. Comments give the ANSI slot;
	-- nothing here is off-theme except the diff tints, which are blends.
	dark = {
		bg = "#161719", -- background
		fg = "#c5c8c6", -- foreground
		surface = "#000000", -- ansi 0
		surface2 = "#444444", -- selection-background
		float_bg = "#161719",
		float_border = "#4c4c4c", -- ansi 8
		colorcolumn = "#000000",
		selection = "#444444", -- selection-background
		split = "#444444",
		indent = "#444444",
		dim = "#4c4c4c", -- ansi 8
		subtle = "#c5c8c6",
		bright = "#e0e0e0", -- ansi 7/15
		cursor = "#d0d0d0", -- cursor-color
		on_cursor = "#151515", -- cursor-text
		black = "#000000",
		pink = "#b9b6fc", -- ansi 5/13, keywords and accent
		red = "#fd5ff1", -- ansi 1/9
		blue = "#85befd", -- ansi 4/6/14
		green = "#87c38a", -- ansi 2
		teal = "#f5ffa8", -- ansi 11, types
		purple = "#ffd7b1", -- ansi 3, numbers and constants
		property = "#96cbfe", -- ansi 12
		yellow = "#94fa36", -- ansi 10, builtins, macros, escapes
		operator = "#e0e0e0",
		punct = "#c5c8c6",
		comment = "#4c4c4c", -- ansi 8
		orange = "#ffd7b1",
		brown = "#ffd7b1",
		quickfix = "#85befd",
		on_accent = "#000000",
		on_search = "#000000",
		on_error = "#000000",
		search_bg = "#f5ffa8",
		error_bg = "#fd5ff1",
		pink_bg = "#b9b6fc",
		blue_bg = "#85befd",
		purple_bg = "#b9b6fc",
		green_bg = "#87c38a",
		teal_bg = "#85befd",
		brown_bg = "#ffd7b1",
		bar_fg = "#e0e0e0",
		bar_bg = "#000000",
		bar_nc_fg = "#4c4c4c",
		bar_nc_bg = "#000000",
		devinfo_fg = "#c5c8c6",
		h1 = "#ffd7b1",
		h2 = "#f5ffa8",
		h4 = "#85befd",
		h5 = "#96cbfe",
		h6 = "#c5c8c6",
		plugin_border = "#4c4c4c",
		indentscope = "#4c4c4c",
		icon_blue = "#85befd",
		icon_grey = "#e0e0e0",
		jump_ahead = "#e0e0e0",
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
	light = {
		bg = "#ffffff",
		fg = "#241f31",
		surface = "#ffffff",
		surface2 = "#eee6dd",
		float_bg = "#ffffff",
		float_border = "#e39abb",
		colorcolumn = "#ffffff",
		selection = "#ffd6e7",
		split = "#e3d8cc",
		indent = "#e2d6ca",
		dim = "#7d766e",
		subtle = "#6b655e",
		bright = "#241f31",
		cursor = "#ff6900",
		on_cursor = "#14171c",
		black = "#000000",
		pink = "#b0306a",
		red = "#c4262e",
		blue = "#0a5fc4",
		green = "#2e7d32",
		teal = "#00766a",
		purple = "#7b3fb5",
		property = "#c94a00",
		yellow = "#8a5d00",
		operator = "#9e4a6e",
		punct = "#6b655e",
		comment = "#7d766e",
		orange = "#c94a00",
		brown = "#8a5a35",
		quickfix = "#007373",
		on_accent = "#241f31",
		on_search = "#241f31",
		on_error = "#ffffff",
		search_bg = "#ffe28a",
		error_bg = "#ed333b",
		pink_bg = "#ff7eb3",
		blue_bg = "#99c1f1",
		purple_bg = "#dc8add",
		green_bg = "#8ff0a4",
		teal_bg = "#8ff0a4",
		brown_bg = "#cdab8f",
		bar_fg = "#ffffff",
		bar_bg = "#000000",
		bar_nc_fg = "#8b8b8b",
		bar_nc_bg = "#000000",
		devinfo_fg = "#cbbfb3",
		h1 = "#0a5fc4",
		h2 = "#813d9c",
		h4 = "#c94a00",
		h5 = "#8a5a35",
		h6 = "#6b655e",
		plugin_border = "#e2d6ca",
		indentscope = "#cbbfb3",
		icon_blue = "#0a5fc4",
		icon_grey = "#6b655e",
		jump_ahead = "#6b655e",
		diff_add = "#e0e8db", -- green 14%
		diff_delete = "#f6dedc", -- red 13%
		diff_change = "#f1e9f0", -- purple 9%
		diff_text = "#e8dcec", -- purple 16%
	},
}
