return {
    "williamboman/mason.nvim",
    cmd = "Mason",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Mason" } },
    build = ":MasonUpdate",
    dependencies = {
        "williamboman/mason-lspconfig.nvim",
        "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    opts = {
        ensure_installed = {
            "stylua",
            "prettierd",
            "eslint_d",
            "selene",
            "pyright",
            "google-java-format",

            "codelldb",
            "bacon-ls",
            "rust-analyzer",
            "json-lsp",
            "lua-language-server",
            "luau-lsp",
            "typescript-language-server",
            "jdtls",
        },
    },
    config = function(_, opts)
        require("mason").setup(opts)

        require("mason-lspconfig").setup({})

        require("mason-tool-installer").setup({
            ensure_installed = opts.ensure_installed,
        })

        local masonRegistry = require("mason-registry")

        masonRegistry:on("package:install:success", function()
            vim.defer_fn(function()
                vim.cmd("doautocmd FileType")
            end, 100)
        end)

        masonRegistry.refresh(function()
            for _, tool in ipairs(opts.ensure_installed) do
                local package = masonRegistry.get_package(tool)

                if not package:is_installed() then
                    package:install()
                end
            end
        end)
    end,
}
