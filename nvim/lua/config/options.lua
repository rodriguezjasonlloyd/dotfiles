local opt = vim.opt
local g = vim.g

-- Global Leader Settings
g.mapleader = " "
g.maplocalleader = " "

-- Clipboard and Auto-Save
opt.clipboard = vim.env.SSH_TTY and "" or "unnamedplus"
opt.autowrite = true

-- Completion and Conceal
opt.completeopt = "menu,menuone,noselect"
opt.conceallevel = 2

-- Cursor and Mouse
opt.cursorline = true
opt.mouse = "a"

-- Formatting, Display, and Folding
opt.expandtab = true
opt.formatoptions = "jcroqlnt"
opt.fillchars = {
    foldopen = "",
    foldclose = "",
    fold = " ",
    foldsep = " ",
    diff = "╱",
    eob = " ",
}
opt.foldlevel = 99
opt.linebreak = true
opt.list = true
opt.number = true
opt.relativenumber = true
opt.ruler = false
opt.listchars = { tab = "» ", trail = "·", nbsp = "␣" }

-- Indentation and Tab Settings
opt.shiftwidth = 4
opt.tabstop = 2
opt.smartindent = true
opt.shiftround = true

-- Grep and Search
opt.grepformat = "%f:%l:%c:%m"
opt.grepprg = "rg --vimgrep"
opt.ignorecase = true
opt.smartcase = true

-- Command and Jump Options
opt.inccommand = "nosplit"
opt.jumpoptions = "view"

-- Popup Menu
opt.pumblend = 10
opt.pumheight = 10

-- Scrolling and Window Dimensions
opt.scrolloff = 10
opt.sidescrolloff = 8
opt.winminwidth = 5

-- Session and Split Behavior
opt.sessionoptions = { "buffers", "curdir", "tabpages", "winsize", "help", "globals", "skiprtp", "folds" }
opt.splitbelow = true
opt.splitkeep = "screen"
opt.splitright = true

-- Message Display and Status Column
opt.shortmess:append({ W = true, I = true, c = true, C = true })
opt.showmode = false
opt.signcolumn = "yes"

-- Spell Checking
opt.spelllang = { "en" }

-- Terminal Colors and Appearance
opt.termguicolors = true

-- Timeout and Update Settings
opt.timeoutlen = 300
opt.updatetime = 200

-- Undo and Backup
opt.undofile = true
opt.undolevels = 10000
opt.backupcopy = "yes"

-- Virtual Editing and Wild Mode
opt.virtualedit = "block"
opt.wildmode = "longest:full,full"
