---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local cmd = "tsgo"
        local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/tsgo"

        if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
        end

        return vim.lsp.rpc.start({ cmd, "--lsp", "--stdio" }, dispatchers)
    end,
    filetypes = {
        "javascript",
        "javascriptreact",
        "javascript.jsx",
        "typescript",
        "typescriptreact",
        "typescript.tsx",
    },
    root_dir = function(bufnr, on_dir)
        local root_markers = { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock" }
        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })

        if vim.fs.root(bufnr, { "deno.json", "deno.jsonc", "deno.lock" }) then
            return
        end

        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        on_dir(project_root)
    end,
}
