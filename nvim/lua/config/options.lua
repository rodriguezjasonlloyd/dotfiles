local opt = vim.opt

-- Clipboard & Auto-Save
opt.clipboard = "unnamedplus"
opt.autowrite = true

-- Completion & Popup Menu
opt.completeopt = { "menu", "menuone", "noselect" }
opt.pumblend = 30
opt.pumheight = 10

-- Search
opt.ignorecase = true

-- Interface & Display
opt.cursorline = true
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.signcolumn = "yes"
opt.list = true
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }
opt.termguicolors = true
opt.linebreak = true

-- Indentation & Tabs
opt.expandtab = true
opt.shiftwidth = 4
opt.tabstop = 4
opt.smartindent = true

-- Splits & Windows
opt.splitbelow = true
opt.splitright = true
opt.splitkeep = "screen"
opt.winminwidth = 5

-- Scrolling & Movement
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.jumpoptions = "view"

-- Session & Persistence
opt.shada = ""
opt.shadafile = "NONE"
opt.sessionoptions = { "buffers", "folds" }

-- Undo, Backup & Fileformats
opt.undofile = true
opt.undolevels = 10000
opt.backupcopy = "yes"
opt.fileformats = "unix"
opt.fileformat = "unix"

-- Messages & Mode
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false

-- Virtual Editing & Wildcards
opt.virtualedit = "block"
opt.wildmode = { "longest", "full" }

-- Timing
opt.timeoutlen = 300

-- Spell Checking
opt.spelllang = "en"
