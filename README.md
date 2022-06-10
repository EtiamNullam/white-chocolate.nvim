# white-chocolate.nvim

It's an opinionated bright theme for [`neovim`](https://neovim.io) containing my custom colorscheme and configurations for other great plugins.

Every bright colorscheme that I've tried had some issues, so I've decided to make my own thanks to [RRethy/nvim-base16](https://github.com/RRethy/nvim-base16).

### Goals

- `simple` - both in use and development
- `light` - minimal performance impact
- `bright` - dim your screen if its too much
- `functional` - does its job and nothing more
- `complete` - delivers a complete package together
- `redshift-friendly` - plays nicely with reduced blue light
- `familiar` - vibrant colors that you are used to: strings are green, comments are gray (but visible), functions are blue, background is white
- `modular` - use any set of features that you like

Make sure to raise an issue if you have any suggestion about how we can get closer to these goals. 

## Installation

Use your favorite plugin manager.

For [`vim-plug`](https://github.com/junegunn/vim-plug) you can use this:

```vim
call plug#begin('~/.vim-plug')

    Plug 'EtiamNullam/white-chocolate.nvim'

call plug#end()
```

### Dependencies

You have to install them on your own.

- [RRethy/nvim-base16](https://github.com/RRethy/nvim-base16) - required

[`vim-plug`](https://github.com/junegunn/vim-plug) snippet:

```vim
Plug 'RRethy/nvim-base16'
```

### Usage

Default options:

```lua
require('white-chocolate').setup()
```

Custom options (defaults in example):

```lua
require('white-chocolate').setup {
    apply_colorscheme = true,
    invert_selection = true,
    tweak_nontext = true,
    tweak_float = true,
    tweak_matchparen = true,
}
```
