local luau_directory = vim.fs.joinpath(vim.fn.stdpath("data"), "luau")
local definitions = vim.fs.joinpath(luau_directory, "types.d.luau")
local docs = vim.fs.joinpath(luau_directory, "docs.json")

---@type vim.lsp.Config
return {
    filetypes = { "luau" },
    root_markers = { ".git" },
    on_init = function()
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

        if not vim.uv.fs_stat(luau_directory) then
            vim.uv.fs_mkdir(luau_directory, tonumber("755", 8))
        end

        local download = {
            ["types.d.luau"] = "https://luau-lsp.pages.dev/type-definitions/globalTypes.PluginSecurity.d.luau",
            ["docs.json"] = "https://luau-lsp.pages.dev/api-docs/en-us.json",
        }

        for name, url in pairs(download) do
            local path = vim.fs.joinpath(luau_directory, name)
            vim.system({ "curl", "-fLo", path, "-z", path, url })
        end
    end,
    cmd = { "luau-lsp", "lsp", "--definitions", definitions, "--docs", docs },
    init_options = {
        fflags = {
            LuauExplicitTypeExpressionInstantiation = "true",
            LuauSolverV2 = "true",
        },
    },
}
