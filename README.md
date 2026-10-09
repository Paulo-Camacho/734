# 734.nvim

A dark and light Neovim colorscheme with an orange cursor and orange yank flash.

| variant | command |
| --- | --- |
| dark | `:colorscheme 734` |
| light | `:colorscheme 734-light` |

<!-- screenshots: add images of both variants here -->

## Requirements

- Neovim 0.10+
- `termguicolors` on (the palette is 24-bit; cterm coverage is minimal)

## Install

### lazy.nvim

```lua
-- ~/.config/nvim/lua/plugins/734.lua
return {
  "Paulo-Camacho/734.nvim",
  lazy = false,
  priority = 1000,
  config = function()
    vim.cmd.colorscheme("734")
  end,
}
```

### vim.pack (Neovim 0.12+)

```lua
-- ~/.config/nvim/init.lua
vim.pack.add({ "https://github.com/Paulo-Camacho/734.nvim" })
vim.cmd.colorscheme("734")
```

### Manual

Copy `colors/` and `lua/` into `~/.config/nvim/`.

## Orange cursor and yank

Loading either variant also:

- attaches the `Cursor` group to `'guicursor'` so Neovim, not the terminal,
  colors the cursor. Skipped if your `'guicursor'` already names `Cursor` or
  `lCursor`, or is empty. Your terminal must support OSC 12 (kitty, WezTerm,
  Ghostty, foot, Alacritty, iTerm2 do).
- flashes yanked text with the `Yank734` group.

Opt out before loading the colorscheme:

```lua
vim.g.theme734_cursor = false -- leave 'guicursor' alone
vim.g.theme734_yank = false   -- no yank flash (use this if you already have a TextYankPost highlight)
```

## License

MIT
