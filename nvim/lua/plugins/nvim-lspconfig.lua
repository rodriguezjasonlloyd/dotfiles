return {
    "neovim/nvim-lspconfig",
    event = { "BufReadPre", "BufNewFile" },
    dependencies = {
        "williamboman/mason.nvim",
        "williamboman/mason-lspconfig.nvim",
    },
    opts = {
        capabilities = {
            workspace = {
                fileOperations = {
                    didRename = true,
                    willRename = true,
                },
            },
        },
        format = {
            formatting_options = nil,
            timeout_ms = nil,
        },
        servers = {
            lua_ls = {
                settings = {
                    Lua = {
                        workspace = {
                            checkThirdParty = false,
                        },
                        diagnostics = {
                            globals = { "vim" },
                        },
                        codeLens = {
                            enable = true,
                        },
                        completion = {
                            callSnippet = "Replace",
                        },
                        doc = {
                            privateName = { "^_" },
                        },
                        hint = {
                            enable = true,
                            setType = false,
                            paramType = true,
                            paramName = "Disable",
                            semicolon = "Disable",
                            arrayIndex = "Disable",
                        },
                    },
                },
            },
            luau_lsp = {
                cmd = {
                    vim.fn.stdpath("data") .. "\\mason\\bin\\luau-lsp.CMD",
                    "lsp",
                    "--definitions=" .. vim.fn.stdpath("data") .. "\\luau\\GlobalTypes.d.luau",
                    "--docs=" .. vim.fn.stdpath("data") .. "\\luau\\api-docs.json",
                    "--no-flags-enabled",
                },
                settings = {
                    ["luau-lsp"] = {
                        completion = {
                            imports = {
                                enabled = true,
                            },
                            autocompleteEnd = true,
                        },
                    },
                },
            },
            ts_ls = {
                settings = {
                    typescript = {
                        suggest = {
                            completeFunctionCalls = false,
                        },
                    },
                    javascript = {
                        suggest = {
                            completeFunctionCalls = false,
                        },
                    },
                },
            },
            rust_analyzer = {
                enabled = false,
            },
        },
        setup = {
            ts_ls = function()
                vim.keymap.set("n", "<leader>oi", function()
                    for _, client in ipairs(vim.lsp.get_clients({ bufnr = 0 })) do
                        client:exec_cmd({
                            command = "_typescript.organizeImports",
                            arguments = { vim.api.nvim_buf_get_name(0) },
                            title = "",
                        }, { bufnr = 0 }, function(err)
                            if err then
                                vim.notify("Error organizing imports: " .. err.message, vim.log.levels.ERROR)
                            else
                                vim.notify("Imports organized successfully!", vim.log.levels.INFO)
                            end
                        end)
                    end
                end, { noremap = true, silent = true })
            end,
        },
    },
    config = function(_, opts)
        local servers = opts.servers
        local has_cmp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
        local capabilities = vim.tbl_deep_extend(
            "force",
            {},
            vim.lsp.protocol.make_client_capabilities(),
            has_cmp and cmp_nvim_lsp.default_capabilities() or {},
            opts.capabilities or {}
        )

        local function setup(server)
            local server_opts = vim.tbl_deep_extend("force", {
                capabilities = vim.deepcopy(capabilities),
            }, servers[server] or {})

            if server_opts.enabled == false then
                return
            end

            if opts.setup[server] then
                if opts.setup[server](server, server_opts) then
                    return
                end
            elseif opts.setup["*"] then
                if opts.setup["*"](server, server_opts) then
                    return
                end
            end

            require("lspconfig")[server].setup(server_opts)
        end

        local have_mason, mlsp = pcall(require, "mason-lspconfig")

        local all_mslp_servers = {}

        if have_mason then
            all_mslp_servers = vim.tbl_keys(mlsp.get_installed_servers())
        end

        local ensure_installed = {}

        for server, server_opts in pairs(servers) do
            if server_opts then
                server_opts = server_opts == true and {} or server_opts

                if server_opts.enabled ~= false then
                    if server_opts.mason == false or not vim.tbl_contains(all_mslp_servers, server) then
                        setup(server)
                    else
                        ensure_installed[#ensure_installed + 1] = server
                    end
                end
            end
        end

        if have_mason then
            mlsp.setup({
                ensure_installed = ensure_installed,
                handlers = {
                    function(server)
                        setup(server)
                    end,
                },
            })
        end
    end,
}
