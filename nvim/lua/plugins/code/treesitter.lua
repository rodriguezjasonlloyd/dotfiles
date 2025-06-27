return {
    "nvim-treesitter/nvim-treesitter",
    branch = "main",
    build = ":TSUpdate",
    lazy = true,
    config = function()
        local treesitter = require("nvim-treesitter")
        treesitter.setup()

        local ensure_installed = {
            "bash",
            "c",
            "diff",
            "html",
            "javascript",
            "jsdoc",
            "json",
            "jsonc",
            "lua",
            "luadoc",
            "luap",
            "luau",
            "markdown",
            "markdown_inline",
            "printf",
            "python",
            "query",
            "regex",
            "rust",
            "toml",
            "tsx",
            "typescript",
            "vim",
            "vimdoc",
            "xml",
            "yaml",
        }

        local installed = require("nvim-treesitter.config").get_installed("parsers")

        local not_installed = vim.tbl_filter(function(parser)
            return not vim.tbl_contains(installed, parser)
        end, ensure_installed)

        if #not_installed > 0 then
            require("nvim-treesitter").install(not_installed)
        end
    end,
}
