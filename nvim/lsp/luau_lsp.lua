---@type vim.lsp.Config
return {
    filetypes = { "luau" },
    root_markers = { ".git" },
    on_attach = function()
        local cwd = vim.fn.getcwd()

        local project = vim.fs.find(function(name)
            return vim.glob.to_lpeg("*.project.json"):match(name)
        end, { path = cwd, type = "file", limit = math.huge })[1]

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
                    vim.notify("Rojo Sourcemap Error: " .. result.stderr, vim.log.levels.ERROR)
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
    settings = {
        ["luau-lsp"] = {
            completion = {
                imports = {
                    enabled = true,
                    stringRequires = { enabled = true },
                },
            },
        },
    },
}
