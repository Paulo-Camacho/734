# 734

a dark and light neovim colorscheme. The dark variant matches Ghostty's built-in
Atom theme; the light variant has an orange cursor and orange yank flash.

![734 dark and 734-light, split diagonally](images/hero.png)

| variant | command | background | floats | cursor |
| --- | --- | --- | --- | --- |
| dark | `:colorscheme 734` | `#161719` | `#161719` | `#d0d0d0` |
| light | `:colorscheme 734-light` | `#ffffff` | `#ffffff` | `#ff6900` |

in the dark variant, floating windows share the editor's background and are
set apart by a grey border (`#4c4c4c`). The cursorline, completion menu and
folds use black.

**palette**

every dark color comes from Ghostty's Atom theme (the diff backgrounds are
blends of it). A terminal theme only names 16 colors, so the syntax roles below
are this theme's choice of slots. In the light variant, pink is the highlight
color and the cursor's orange carries over to properties and fields.

| role | dark | light |
| --- | --- | --- |
| keyword, `if`, `for`, `import` | `#b9b6fc` | `#b0306a` |
| `return`, exceptions | `#fd5ff1` | `#c4262e` |
| function, HTML/JSX tag | `#85befd` | `#0a5fc4` |
| string | `#87c38a` | `#2e7d32` |
| type, module | `#f5ffa8` | `#00766a` |
| number, constant, boolean | `#ffd7b1` | `#7b3fb5` |
| property, field, tag attribute | `#96cbfe` | `#c94a00` |
| builtin, macro, escape | `#94fa36` | `#8a5d00` |
| operator | `#e0e0e0` | `#9e4a6e` |
| punctuation, `<` `>` `=` in tags | `#c5c8c6` | `#6b655e` |
| comment (italic) | `#4c4c4c` | `#7d766e` |
| selection | `#444444` | `#ffd6e7` |

every syntax color meets roughly wcag aa (4.3:1 or better) against its
background, except dark comments, which keep Atom's `#4c4c4c` (about 2:1).

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
- `termguicolors` on (the palette is 24-bit; cterm coverage is minimal)


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

the cursor and yank flash are `#d0d0d0` in the dark variant and `#ff6900` in the
light variant. Loading either one also:

- attaches the `Cursor` group to `'guicursor'` so Neovim, not the terminal,
  colors the cursor. skipped if your `'guicursor'` already names `cursor` or
  `lCursor`, or is empty. Re-applied if you change `'guicursor'` later.
  Needs `termguicolors` on, and your terminal must support osc 12 (kitty,
  wezTerm, ghostty, foot, alacritty, iterm2 do).
- flashes yanked text with the `Yank734` group.

opt out before loading the colorscheme:

```lua
vim.g.theme734_cursor = false -- leave 'guicursor' alone
vim.g.theme734_yank = false   -- no yank flash (use this if you already have a TextYankPost highlight)
```

**license**

mit
