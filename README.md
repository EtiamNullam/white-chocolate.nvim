# white-chocolate.nvim

It's an opinionated bright theme for [`neovim`](https://neovim.io) containing my custom colorscheme and configurations for other great plugins.

Every bright colorscheme that I've tried had some issues, so I've decided to make my own thanks to [RRethy/nvim-base16](https://github.com/RRethy/nvim-base16).

### Goals

- `simple` - both in use and development
- `light` - minimal performance impact
- `functional` - does its job and nothing more
- `familiar` - vibrant colors that you are used to: strings are green, comments are gray (but visible), functions are blue, background is white
- `bright` - darken your screen if its blinding, nothing will blind you if everything is bright and transition will be smooth
- `complete` - delivers a complete package together with optional 3rd-party plugin configurations
- `modular` - use any set of features that you like

Make sure to raise an issue if you have any suggestion about how we can get closer to these goals. 

## Installation

Use your favorite plugin manager.

For [`vim-plug`] you can use this:

```vim
call plug#begin('~/.vim-plug')

Plug 'EtiamNullam/white-chocolate.nvim', { 'branch': 'v0' }

call plug#end()
```

### Dependencies

You have to install them on your own.

- [https://github.com/RRethy/nvim-base16](RRethy/nvim-base16) - required

[`vim-plug`] snippet:

```vim
Plug 'RRethy/nvim-base16'
```

### Usage

Default options:

```lua
require('white-chocolate').setup()
```

Enable all options:

```lua
require('white-chocolate').setup(true)
```

Custom options (defaults in example):

```lua
require('white-chocolate').setup {
    add_colorscheme = true,
    invert_selection = true,
}
```
