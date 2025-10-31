local function organize_imports(bufnr)
    vim.lsp.buf_request_sync(bufnr, "workspace/executeCommand", {
        command = "_typescript.organizeImports",
        arguments = { vim.api.nvim_buf_get_name(bufnr) },
        title = "",
    }, 500)
end

---@type vim.lsp.Config
return {
    init_options = { hostInfo = "neovim" },
    cmd = { "typescript-language-server", "--stdio" },
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        local project_root = vim.fs.root(
            bufnr,
            { "package.json", "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        )

        if not project_root then
            return
        end

        on_dir(project_root)
    end,
    handlers = {
        ["_typescript.rename"] = function(_, result, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))

            vim.lsp.util.show_document({
                uri = result.textDocument.uri,
                range = {
                    start = result.position,
                    ["end"] = result.position,
                },
            }, client.offset_encoding)

            vim.lsp.buf.rename()

            return vim.NIL
        end,
    },
    commands = {
        ["editor.action.showReferences"] = function(command, ctx)
            local client = assert(vim.lsp.get_client_by_id(ctx.client_id))
            local file_uri, position, references = unpack(command.arguments)

            local quickfix_items = vim.lsp.util.locations_to_items(references, client.offset_encoding)

            vim.fn.setqflist({}, " ", {
                title = command.title,
                items = quickfix_items,
                context = {
                    command = command,
                    bufnr = ctx.bufnr,
                },
            })

            vim.lsp.util.show_document({
                uri = file_uri,
                range = {
                    start = position,
                    ["end"] = position,
                },
            }, client.offset_encoding)

            vim.cmd("botright copen")
        end,
    },
    on_attach = function(client, bufnr)
        vim.api.nvim_buf_create_user_command(bufnr, "LspTypescriptSourceAction", function()
            local source_actions = vim.tbl_filter(function(action)
                return vim.startswith(action, "source.")
            end, client.server_capabilities.codeActionProvider.codeActionKinds)

            vim.lsp.buf.code_action({
                context = {
                    only = source_actions,
                },
            })
        end, {})

        vim.keymap.set("n", "<leader>oi", function()
            organize_imports(bufnr)
        end, { buffer = bufnr, desc = "Organize Imports", silent = true })

        vim.api.nvim_buf_create_user_command(bufnr, "OrganizeImports", function()
            organize_imports(bufnr)
        end, { desc = "Organize TS imports" })
    end,
}
