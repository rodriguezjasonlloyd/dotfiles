return {
    {
        "mrcjkb/rustaceanvim",
        ft = { "rust" },
        dependencies = { "williamboman/mason.nvim" },
        config = function()
            -- Base options for rustaceanvim
            local opts = {
                server = {
                    on_attach = function(_, bufnr)
                        local bufopts = { buffer = bufnr, noremap = true, silent = true }
                        vim.keymap.set("n", "<leader>cR", function()
                            vim.cmd.RustLsp("codeAction")
                        end, vim.tbl_extend("force", bufopts, { desc = "Code Action" }))
                        vim.keymap.set("n", "<leader>dr", function()
                            vim.cmd.RustLsp("debuggables")
                        end, vim.tbl_extend("force", bufopts, { desc = "Rust Debuggables" }))
                    end,
                    default_settings = {
                        ["rust-analyzer"] = {
                            cargo = {
                                allFeatures = true,
                                loadOutDirsFromCheck = true,
                                buildScripts = { enable = true },
                            },
                            checkOnSave = true,
                            diagnostics = { enable = true },
                            procMacro = {
                                enable = true,
                                ignored = {
                                    ["async-trait"] = { "async_trait" },
                                    ["napi-derive"] = { "napi" },
                                    ["async-recursion"] = { "async_recursion" },
                                },
                            },
                            files = {
                                excludeDirs = {
                                    ".direnv",
                                    ".git",
                                    ".github",
                                    ".gitlab",
                                    "bin",
                                    "node_modules",
                                    "target",
                                    "venv",
                                    ".venv",
                                },
                            },
                        },
                    },
                },
            }

            -- Setup DAP adapter if mason.nvim is available
            if package.loaded["mason.nvim"] then
                local registry = require("mason-registry")
                if registry.has("codelldb") then
                    local pkg = registry.get_package("codelldb")
                    local path = pkg:get_install_path()
                    local adapter = path .. "/extension/adapter/codelldb"
                    local libdir = path .. "/extension/lldb/lib/"
                    local ext = vim.loop.os_uname().sysname == "Linux" and "liblldb.so" or "liblldb.dylib"
                    local library = libdir .. ext
                    opts.dap = {
                        adapter = require("rustaceanvim.config").get_codelldb_adapter(adapter, library),
                    }
                end
            end

            -- Merge into global config and initialize
            vim.g.rustaceanvim = vim.tbl_deep_extend("force", vim.g.rustaceanvim or {}, opts)

            -- Warn if rust-analyzer missing
            if vim.fn.executable("rust-analyzer") == 0 then
                vim.notify(
                    "rust-analyzer not found in PATH, please install it: https://rust-analyzer.github.io/",
                    vim.log.levels.ERROR
                )
            end
        end,
    },
}
