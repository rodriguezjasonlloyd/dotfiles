return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = { "hrsh7th/cmp-nvim-lsp", "mason-org/mason-lspconfig.nvim" },
    config = function()
        require("mason-lspconfig").setup({ automatic_enable = { exclude = { "ruff" } } })

        local cmp_nvim_lsp = require("cmp_nvim_lsp")

        local capabilities =
            vim.tbl_extend("force", vim.lsp.protocol.make_client_capabilities(), cmp_nvim_lsp.default_capabilities())

        vim.lsp.config("*", {
            capabilities = capabilities,
            on_attach = function(_, bufnr)
                vim.treesitter.start(bufnr)
            end,
        })

        vim.lsp.config("lua_ls", {
            settings = {
                Lua = {
                    runtime = { version = "LuaJIT" },
                    diagnostics = { globals = { "vim" } },
                    hint = { enable = true, arrayIndex = "Disable", setType = true },
                },
            },
        })

        vim.lsp.config("luau_lsp", {
            on_attach = function(_, bufnr)
                vim.lsp.config["*"].on_attach(_, bufnr)
                vim.treesitter.start(bufnr)

                local cwd = vim.fn.getcwd()

                local project = vim.fs.find(function(name, path)
                    return name:match(".*%.project%.json$") and path == cwd
                end, { path = cwd, depth = 1, type = "file", limit = 1 })[1]

                if project and project ~= "" then
                    vim.system({
                        "rojo",
                        "sourcemap",
                        "--watch",
                        project,
                        "--output",
                        vim.fs.joinpath(cwd, "sourcemap.json"),
                    }, { cwd = cwd, text = true }, function(result)
                        if result.stderr and result.stderr ~= "" then
                            vim.schedule(function()
                                vim.notify("Rojo Sourcemap Error: " .. result.stderr, vim.log.levels.ERROR)
                            end)
                        end
                    end)
                end
            end,
            cmd = function(dispatchers)
                local luau_directory = vim.fs.joinpath(vim.fn.stdpath("data"), "luau")
                local definitions = vim.fs.joinpath(luau_directory, "types.d.luau")
                local docs = vim.fs.joinpath(luau_directory, "docs.json")
                local executable = (vim.fn.has("win32") == 1) and "luau-lsp.cmd" or "luau-lsp"

                return vim.lsp.rpc.start({
                    executable,
                    "lsp",
                    "--definitions=" .. definitions,
                    "--docs=" .. docs,
                    "--no-flags-enabled",
                }, dispatchers)
            end,
            settings = { ["luau-lsp"] = { completion = { imports = { enabled = true } } } },
        })

        vim.lsp.config("ts_ls", {
            on_attach = function(_, bufnr)
                vim.lsp.config["*"].on_attach(_, bufnr)

                local function organize_imports()
                    vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", {
                        command = "_typescript.organizeImports",
                        arguments = { vim.api.nvim_buf_get_name(bufnr) },
                        title = "",
                    }, 500)
                end

                vim.keymap.set(
                    "n",
                    "<leader>oi",
                    organize_imports,
                    { buffer = bufnr, desc = "Organize Imports", silent = true }
                )

                vim.api.nvim_buf_create_user_command(
                    bufnr,
                    "OrganizeImports",
                    organize_imports,
                    { desc = "Organize TS imports" }
                )
            end,
        })

        vim.lsp.config("lemminx", { filetypes = { "xml", "xsd", "xsl", "xslt", "svg", "ant" } })

        vim.lsp.config("jdtls", {
            init_options = {
                settings = {
                    java = {
                        project = { sourcePaths = { "src" } },
                        configuration = { runtimes = { { path = vim.env.JAVA_HOME } } },
                    },
                },
            },
        })
    end,
}
