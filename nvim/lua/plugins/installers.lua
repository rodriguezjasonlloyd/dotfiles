local mason = require("mason")
mason.setup({})

require("mason-tool-installer").setup({
    ensure_installed = {
        -- Formatters
        "stylua", -- Lua
        "prettierd", -- JS/TS/HTML/CSS
        "google-java-format", -- Java
        "ruff", -- Python

        -- Linters
        "eslint_d", -- JS/TS
        "selene", -- Lua

        -- LSP Servers
        "pyrefly", -- Python
        "lua-language-server", -- Lua
        "luau-lsp", -- Luau
        "typescript-language-server", -- JS/TS
        "json-lsp", -- JSON
        "rust-analyzer", -- Rust
        "jdtls", -- Java
        "tombi", -- TOML
        "lemminx", -- XML
    },
})

vim.keymap.set("n", "<leader>m", ":Mason<CR>", { silent = true, desc = "Open Mason" })

require("nvim-treesitter").install({
    "bash",
    "c",
    "diff",
    "html",
    "java",
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
})
