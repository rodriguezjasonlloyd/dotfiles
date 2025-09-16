-- Visuals
vim.pack.add({
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
}, { confirm = false })

-- Installers
vim.pack.add({
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
}, { confirm = false })

-- Editing
vim.pack.add({
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
    { src = "https://github.com/RRethy/nvim-treesitter-endwise" },
    { src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
    { src = "https://github.com/folke/ts-comments.nvim" },
}, { confirm = false })

-- Miscellaneous
vim.pack.add({
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/folke/persistence.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/vyfor/cord.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/noice.nvim" },
}, { confirm = false })

require("plugins.visuals")
require("plugins.snacks")
require("plugins.installers")
require("plugins.editing")
require("plugins.workflow")
require("plugins.git")
