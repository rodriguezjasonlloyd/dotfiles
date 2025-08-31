local luau_directory = vim.fs.joinpath(vim.fn.stdpath("data"), "luau")

if not vim.uv.fs_stat(luau_directory) then
    vim.uv.fs_mkdir(luau_directory, tonumber("755", 8))
end

local download = {
    ["types.d.luau"] = "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.PluginSecurity.d.luau",
    ["docs.json"] = "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json",
}

for name, url in pairs(download) do
    local path = vim.fs.joinpath(luau_directory, name)
    vim.system({ "curl", "-fLo", path, "-z", path, url })
end
