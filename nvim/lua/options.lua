local opt = vim.opt
local o = vim.o

-- Basic Display
o.number = true
o.relativenumber = true
o.cursorline = true
o.signcolumn = "yes"
o.wrap = false
o.linebreak = true

-- Search
o.ignorecase = true
o.smartcase = true

-- Indentation & Tabs
o.expandtab = true
o.shiftwidth = 4
o.tabstop = 4

-- Interface Elements
o.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.fillchars = { eob = " " }
o.winborder = "rounded"

-- Completion & Popup Menu
opt.completeopt = { "menu", "menuone", "popup", "noselect" }
o.pumblend = 30
o.pumheight = 10

-- Splits & Windows
o.splitbelow = true
o.splitright = true
o.splitkeep = "screen"
o.winminwidth = 5

-- Scrolling & Movement
o.scrolloff = 10
o.sidescrolloff = 8
o.jumpoptions = "view"

-- Clipboard & Auto-Save
o.clipboard = "unnamedplus"
o.autowrite = true

-- Undo & Backup
o.undofile = true
o.backupcopy = "yes"

-- File Formats
o.fileformats = "unix"

-- Session & Persistence
opt.sessionoptions = { "buffers", "folds" }

-- Messages & Mode
opt.shortmess:append({ W = true, I = true, c = true, C = true })
o.showmode = false

-- Virtual Editing & Wildcards
o.virtualedit = "block"
opt.wildmode = { "longest", "full" }

-- Timing
o.timeoutlen = 300

-- Spell Checking
o.spelllang = "en"
