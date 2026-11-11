# 734

a dark and light neovim colorscheme. both share an orange cursor and yank flash (`#d77757`). The statusline is black with white text in dark and blends
into the white editor in light.

![734 dark and 734-light, split diagonally](images/hero.png)

| variant | command | background | floats | cursor |
| --- | --- | --- | --- | --- |
| dark | `:colorscheme 734` | `#161719` | `#161719` | `#d77757` |
| light | `:colorscheme 734-light` | `#ffffff` | `#ffffff` | `#d77757` |

in both variants, floating windows share the editor's background and are set
apart by a grey border. The cursorline, completion menu and folds sit on a
second surface: black in dark, a pale lavender-grey in light.

**palette**

the light variant mirrors dark role for role: the same hue plays the same part, darkened until it reads on white.

| role | dark | light |
| --- | --- | --- |
| keyword, `if`, `for`, `import` | `#b9b6fc` | `#5b43d6` |
| `return`, exceptions, errors | `#fd5ff1` | `#bd1a9c` |
| function, HTML/JSX tag | `#85befd` | `#0a5fc4` |
| string | `#87c38a` | `#0f7a52` |
| type, module, constructor | `#f5ffa8` | `#7d6000` |
| number, constant, boolean | `#ffd7b1` | `#b04400` |
| property, field | `#96cbfe` | `#17709e` |
| HTML/JSX/XML tag attribute | `#ffd7b1` | `#b04400` |
| builtin, macro, escape | `#94fa36` | `#4f7700` |
| operator | `#e0e0e0` | `#241f31` |
| punctuation, variable | `#c5c8c6` | `#241f31` |
| `<` `>` `/>` `=` in tags | `#807ead` | `#745fdc` |
| comment (italic) | `#80848b` | `#6c6873` |
| selection | `#444444` | `#e2e0f6` |

every syntax color meets wcag aa against its background: 4.7:1 or better in
both variants, comments and tag punctuation included.

**screenshots**

real neovim captures: typescript with tree-sitter, a ts_ls hover and
diagnostic, a search hit, gitsigns and a custom statusline. regenerate them
with `scripts/screenshots/make.sh`.

**dark** — `:colorscheme 734`

![734 dark variant](images/734-dark.png)

**light** — `:colorscheme 734-light`

![734-light variant](images/734-light.png)

**requirements**

- neovim 0.11+ (the yank flash uses `vim.hl.on_yank`)
- `termguicolors` on (the palette is 24-bit; there are no cterm colors)


**installing with lazy.nvim**

```lua
-- ~/.config/nvim/lua/plugins/734.lua
return {
  "Paulo-Camacho/734",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("734") -- or "734-light"
  end,
}
```

**installing with vim.pack (Neovim 0.12+)**
```lua
-- ~/.config/nvim/init.lua
vim.pack.add({ "https://github.com/Paulo-Camacho/734" })
vim.cmd.colorscheme("734") -- or "734-light"
```

**manual install**

copy `colors/` and `lua/` into `~/.config/nvim/`.
```bash
cp -R colors/ ~/.config/nvim/
```

**cursor and yank**

both variants use `#d77757` for the cursor and yank flash. Loading either one
also:

- appends `a:Cursor/lCursor` to `'guicursor'` so Neovim, not the terminal,
  colors the cursor in every mode. Skipped if `'guicursor'` is empty or already
  uses `Cursor/lCursor`; set `'guicursor'` before the colorscheme. Needs
  `termguicolors` and a terminal with osc 12 support (kitty, wezterm, ghostty,
  foot, alacritty, iterm2).
- flashes yanked text with the `Yank734` group.

opt out before loading the colorscheme:

```lua
vim.g.theme734_cursor = false -- leave 'guicursor' alone
vim.g.theme734_yank = false   -- no yank flash (use this if you already have a TextYankPost highlight)
```

**license**

mit
