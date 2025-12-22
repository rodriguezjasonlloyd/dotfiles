local plugins = {
    { src = "https://github.com/HiPhish/rainbow-delimiters.nvim" },
    { src = "https://github.com/JoosepAlviste/nvim-ts-context-commentstring" },
    { src = "https://github.com/MunifTanjim/nui.nvim" },
    { src = "https://github.com/OXY2DEV/markview.nvim" },
    { src = "https://github.com/RRethy/nvim-treesitter-endwise" },
    { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
    { src = "https://github.com/benomahony/oil-git.nvim" },
    { src = "https://github.com/folke/flash.nvim" },
    { src = "https://github.com/folke/noice.nvim" },
    { src = "https://github.com/folke/persistence.nvim" },
    { src = "https://github.com/folke/snacks.nvim" },
    { src = "https://github.com/folke/ts-comments.nvim" },
    { src = "https://github.com/folke/which-key.nvim" },
    { src = "https://github.com/lewis6991/gitsigns.nvim" },
    { src = "https://github.com/mason-org/mason.nvim" },
    { src = "https://github.com/mfussenegger/nvim-lint" },
    { src = "https://github.com/nvim-lualine/lualine.nvim" },
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/rose-pine/neovim" },
    { src = "https://github.com/nvim-treesitter/nvim-treesitter" },
    { src = "https://github.com/saghen/blink.cmp" },
    { src = "https://github.com/stevearc/conform.nvim" },
    { src = "https://github.com/stevearc/oil.nvim" },
    { src = "https://github.com/vyfor/cord.nvim" },
    { src = "https://github.com/windwp/nvim-autopairs" },
    { src = "https://github.com/windwp/nvim-ts-autotag" },
}

local max_retries = 5
local attempt = 0

while attempt < max_retries do
    attempt = attempt + 1

    local ok = pcall(vim.pack.add, plugins, { confirm = false })

    if ok then
        break
    end
end

if attempt == max_retries then
    error(string.format("Failed to install plugins after %d retries", max_retries))
end

require("plugins.visuals")
require("plugins.snacks")
require("plugins.installers")
require("plugins.editing")
require("plugins.workflow")
require("plugins.git")
