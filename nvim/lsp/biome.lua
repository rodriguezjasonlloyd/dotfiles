local function insert_package_json(config_files, field, fname)
    local path = vim.fn.fnamemodify(fname, ":h")
    local root_with_package = vim.fs.dirname(vim.fs.find("package.json", { path = path, upward = true })[1])

    if root_with_package then
        local path_sep = vim.uv.os_uname().version:match("Windows") and "\\" or "/"

        for line in io.lines(root_with_package .. path_sep .. "package.json") do
            if line:find(field) then
                config_files[#config_files + 1] = "package.json"
                break
            end
        end
    end

    return config_files
end

---@type vim.lsp.Config
return {
    cmd = function(dispatchers, config)
        local cmd = "biome"
        local local_cmd = (config or {}).root_dir and config.root_dir .. "/node_modules/.bin/biome"

        if local_cmd and vim.fn.executable(local_cmd) == 1 then
            cmd = local_cmd
        end

        return vim.lsp.rpc.start({ cmd, "lsp-proxy" }, dispatchers)
    end,
    filetypes = {
        "astro",
        "css",
        "graphql",
        "html",
        "javascript",
        "javascriptreact",
        "json",
        "jsonc",
        "svelte",
        "typescript",
        "typescript.tsx",
        "typescriptreact",
        "vue",
    },
    workspace_required = true,
    root_dir = function(bufnr, on_dir)
        local root_markers =
            { "package-lock.json", "yarn.lock", "pnpm-lock.yaml", "bun.lockb", "bun.lock", "deno.lock" }
        root_markers = vim.fn.has("nvim-0.11.3") == 1 and { root_markers, { ".git" } }
            or vim.list_extend(root_markers, { ".git" })
        local project_root = vim.fs.root(bufnr, root_markers) or vim.fn.getcwd()

        local filename = vim.api.nvim_buf_get_name(bufnr)

        local biome_config_files = { "biome.json", "biome.jsonc" }
        biome_config_files = insert_package_json(biome_config_files, "biome", filename)

        local is_buffer_using_biome = vim.fs.find(biome_config_files, {
            path = filename,
            type = "file",
            limit = 1,
            upward = true,
            stop = vim.fs.dirname(project_root),
        })[1]

        if not is_buffer_using_biome then
            return
        end

        on_dir(project_root)
    end,
}
