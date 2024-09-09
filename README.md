<h1>
  white-chocolate.nvim
  <a href="https://github.com/EtiamNullam/white-chocolate.nvim/tags" alt="Latest SemVer tag">
    <img src="https://img.shields.io/github/v/tag/EtiamNullam/white-chocolate.nvim" />
  </a>
  <a href="LICENSE" alt="License">
    <img src="https://img.shields.io/github/license/EtiamNullam/white-chocolate.nvim" />
  </a>
</h2>

It's an opinionated **bright** theme for [`neovim`](https://neovim.io) containing my custom color scheme and configurations for theme-related plugins.

![image](https://github.com/user-attachments/assets/0f9a664a-8982-4325-bf26-1e68a11aff57)

Every bright color scheme that I've tried had some issues, so I've decided to make my own. At first it based on [`RRethy/nvim-base16`](https://github.com/RRethy/nvim-base16).

### Goals

- `Simple` - both in use and development.
- `Familiar` - provides colors that you are used to.
- `Light` - minimal performance impact.

Make sure to raise an issue if you have any suggestion about how we can get closer to these goals.

### Features

- Almost completely white background.
- Plays nicely with reduced blue light (and green to some extend).
- Provides distinct and intense colors.
- Displays yank register preview at a glance.
- Includes optional configurations for `statusline`, `bufferline`, `tabline`, and `winbar`.

### Why not dark theme?

- [It makes reading harder](https://pubmed.ncbi.nlm.nih.gov/23654206). Especially if you have astigmatism - [About 40% of population have astigmatism](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10045990).
- It consumes more power as you need to increase brightness.
- It provides far less blue light. Exposure to blue light (during the day, in moderation) increases alertness, [is beneficial for memory](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC5602660/) and [helps with depression](https://pubmed.ncbi.nlm.nih.gov/19016463/).
- It's less blinding in the dark, but it's still [a bad idea to stare at your screen in the dark](https://www.sciencedaily.com/releases/2006/04/060425015643.htm). Instead turn on the lights in your room and reduce the brightness in software (system settings and programs) or hardware (monitor settings).
- Sudden appearance of bright scene on dark theme can be dramatic. It's only mildly disappointing when it happens in the other way. Bright background is still the default in most places.

Arguments in favor for dark theme:
- On OLED display every pixel can turn off separately when its completely black, this looks neat and [reduces power consumption](https://www.ifixit.com/News/16952/does-dark-mode-really-save-battery-on-your-phone).

### Why it doesn't have a stronger yellow/orange tint?

It's better to remove blue light globally using system-wide tools, than for every app separately.

## Installation

Use your favorite plugin manager.

[`vim-plug`](https://github.com/junegunn/vim-plug):

```lua
local plug = vim.fn['plug#']

vim.call('plug#begin')

  plug('EtiamNullam/white-chocolate.nvim')

vim.call('plug#end')

require('white-chocolate').setup()
```

[`lazy.nvim`](https://github.com/folke/lazy.nvim):

```lua
{
  'EtiamNullam/white-chocolate.nvim',
  config = function()
    require('white-chocolate').setup()
  end,
},
```

### Dependencies

You have to install them if you want extra functionality.

- [`windwp/windline.nvim`](https://github.com/windwp/windline.nvim) - `statusline`, optional
- [`noib3/nvim-cokeline`](https://github.com/noib3/nvim-cokeline) - `bufferline + tabline`, optional
- [`nvim-lua/plenary.nvim`](https://github.com/nvim-lua/plenary.nvim) - required dependency of `cokeline.nvim`
- [`nvim-tree/nvim-web-devicons`](https://github.com/nvim-tree/nvim-web-devicons) - icons in `bufferline`, optional dependency of `cokeline.nvim`
- [`stevearc/resession.nvim`](https://github.com/stevearc/resession.nvim) - optional dependency of `cokeline.nvim`

#### [`vim-plug`](https://github.com/junegunn/vim-plug) snippet:

```lua
local plug = vim.fn['plug#']

vim.call('plug#begin')

  plug('EtiamNullam/white-chocolate.nvim')
    plug('windwp/windline.nvim') -- optional
    plug('noib3/nvim-cokeline') -- optional
      plug('nvim-lua/plenary.nvim') -- required for cokeline
      plug('nvim-tree/nvim-web-devicons') -- optional
      plug('stevearc/resession.nvim') -- optional

vim.call('plug#end')

require('white-chocolate').setup()
```

#### [`lazy.nvim`](https://github.com/folke/lazy.nvim) snippet:

```lua
{
  'EtiamNullam/white-chocolate.nvim',
  config = function()
    require('white-chocolate').setup()
  end,
  dependencies = {
    { 'windwp/windline.nvim' }, -- optional
    {
      'noib3/nvim-cokeline', -- optional
      dependencies = {
        { 'nvim-lua/plenary.nvim' }, -- required for cokeline
        { 'nvim-tree/nvim-web-devicons' }, -- optional
        { 'stevearc/resession.nvim' }, -- optional
      },
    },
  },
},
```
### Configuration

Default options:

```lua
require('white-chocolate').setup()
```

Custom options (defaults in example):

```lua
require('white-chocolate').setup {
  invert_visual = true, -- visual mode will flip background of selected text
  setup_bufferline = false, -- configures bufferline and tabline using optional dependency 'noib3/nvim-cokeline'
  setup_statusline = false, -- configures statusline and winbar using 'windwp/windline.nvim'
  fix_terminal_background = false, -- remove padding in terminal around neovim instance
  use_previous_options = false, -- apply options on top of previous options
  apply_immediately = true, -- apply theme immediately
  trigger_events = true, -- invoke colorscheme related events
  color_overrides = {
    background = '#fffdfb',
    foreground = '#643d2c',
    cursor = '#0022aa',
    cursorline = '#eee9e7',
    floating_window = '#e4d7d3',
    comment = '#9d8580',
    parameter = '#b1a600',
    info = '#1aa7d6',
    error = '#da1306',
    current = '#69b98b',
    change = '#be621e',
    string = '#81ba01',
    special = '#a54dff',
    action = '#476cff',
    key = '#bf1ca2',
  },
}
```

### Usage

As long as you run `setup()` with your preferred configuration plugin will work mostly out of the box.

If you decide to use [`noib3/nvim-cokeline`](https://github.com/noib3/nvim-cokeline) for bufferline and tabline you might want to define mappings for switching buffers, my preference:

> [!NOTE]
> You might want to change your `<Leader>` key first, I suggest `vim.g.mapleader = ' '`.

```lua
vim.keymap.set('n', '<Leader>bj', function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(
      '<Plug>(cokeline-focus-next)<Leader>b',
      true,
      false,
      true
    ),
    'm',
    true
  )
end, { desc = 'Buffer: Go to next' })

vim.keymap.set('n', '<Leader>bk', function()
  vim.api.nvim_feedkeys(
    vim.api.nvim_replace_termcodes(
      '<Plug>(cokeline-focus-prev)<Leader>b',
      true,
      false,
      true
    ),
    'm',
    true
  )
end, { desc = 'Buffer: Go to previous' })
```

#### Using theme colors

You can access exposed default color scheme like this:

```lua
local white_chocolate_colorscheme = require('white-chocolate.colorscheme')
```

### Updating

I will try to follow [`Semantic Versioning 2.0`](https://semver.org/spec/v2.0.0.html).

Which means given `major`.`minor`.`patch`:

- `major` will change on API-breaking changes
- `minor` will change on compatible changes
- `patch` will change on bugfixes

#### Pinning

Branches `v<major>`, `v<major>.<minor>` and tags `v<major>.<minor>.<patch>` are available to follow so you don't have to worry about plugin breaking on update.

It's recommended to at least pin to the recent major version, especially if you do some configuration.

##### Examples

Examples using [`lazy.nvim`](https://github.com/folke/lazy.nvim):

New features without breaking changes:

```lua
{
  'EtiamNullam/white-chocolate.nvim',
  branch = 'v1',
  config = function()
    require('white-chocolate').setup()
  end,
},
```

Bugfixes only:

```lua
{
  'EtiamNullam/white-chocolate.nvim',
  branch = 'v1.1',
  config = function()
    require('white-chocolate').setup()
  end,
},

```
Pin to a specific version:

```lua
{
  'EtiamNullam/white-chocolate.nvim',
  tag = 'v1.1.0',
  config = function()
    require('white-chocolate').setup()
  end,
},
```
