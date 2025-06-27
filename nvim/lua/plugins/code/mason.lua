return {
    "mason-org/mason.nvim",
    keys = { { "<leader>cm", "<cmd>Mason<cr>", desc = "Open Mason", silent = true } },
    dependencies = { "WhoIsSethDaniel/mason-tool-installer.nvim" },
    build = ":MasonUpdate",
    config = function()
        local ensure_installed = {
            -- Formatters
            "stylua", -- Lua
            "prettierd", -- JS/TS/HTML/CSS
            "google-java-format", -- Java
            "ruff", -- Python

            -- Linters
            "eslint_d", -- JS/TS
            "selene", -- Lua

            -- LSP Servers
            "python-lsp-server", -- Python
            "lua-language-server", -- Lua
            "luau-lsp", -- Luau
            "typescript-language-server", -- JS/TS
            "json-lsp", -- JSON
            "rust-analyzer", -- Rust
            "jdtls", -- Java
        }

        require("mason").setup({ max_concurrent_installers = 4 })

        require("mason-tool-installer").setup({ ensure_installed = ensure_installed })

        local registry = require("mason-registry")

        registry:on("package:install:success", function()
            vim.defer_fn(function()
                vim.cmd("doautocmd FileType")
            end, 100)
        end)

        registry:on("package:install:failed", function(receipt)
            vim.notify(("Mason failed to install %s"):format(receipt.package:name()), vim.log.levels.ERROR)
        end)

        registry.refresh(function()
            for _, tool in ipairs(ensure_installed) do
                local package = registry.get_package(tool)

                if not package:is_installed() and not package:is_installing() then
                    package:install({}, function(success)
                        if not success then
                            vim.notify(("Failed installing %s"):format(package:name()), vim.log.levels.ERROR)
                        end
                    end)
                end
            end
        end)
    end,
}
