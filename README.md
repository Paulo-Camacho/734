# 734

a theme that includes a mirrored* dark and light mode **designed** to be **as readable as possible** while staying **beautiful**.

![734 dark and 734-light, split diagonally](images/hero.png)

`:colorscheme 734`

![734 dark variant](images/734-dark.png)

`:colorscheme 734-light`

![734-light variant](images/734-light.png)

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

**requirements & additional information**

- neovim 0.11+ (the yank flash uses `vim.hl.on_yank`)
- `termguicolors` on (the palette is 24-bit; there are no cterm colors)
- set `'guicursor'` before the colorscheme. needs
  `termguicolors` and a terminal with osc 12 support (kitty, wezterm, ghostty, foot, alacritty, iterm2).
- appends a:Cursor/lCursor to 'guicursor' so Neovim, not the terminal, colors the cursor in every mode. skipped if 'guicursor' is empty or already uses Cursor/lCursor;
flashes yanked text with the Yank734 group.


```lua
-- opt out before loading the colorscheme:
vim.g.theme734_cursor = false -- turn off orange cursor
vim.g.theme734_yank = false -- turn off orange yank highlight
```

**license**

[mit](./LICENSE)
