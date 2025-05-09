# telescope-scoped-crate.nvim

A Telescope picker like files, but scoped to only the current crate. I find
this useful when working on cargo workspaces with many crates.

The current crate is determined by the current buffer's path. It does not matter
in which directory nvim was started. This means that we can, for example, use
it inside dependencies

## Usage

```
Telescope scoped_crate
```

## Lazy.nvim install

```lua
  {
    "druskus20/telescope-scoped-crate.nvim",
  },
```

Then tell telescope to load the extension:

```lua
require("telescope").load_extension("scoped_crate")
```

### LazyVim

I recommend users of LazyVim to load the extension in the following way:

```lua
  {
    "druskus20/telescope-scoped-crate.nvim",
  },
  {
    "nvim-telescope/telescope.nvim",
    optional = true,
    opts = function()
      LazyVim.on_load("telescope.nvim", function()
        require("telescope").load_extension("scoped_crate")
      end)
    end,
  }
```
