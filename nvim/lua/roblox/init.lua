local luau_directory = vim.fs.joinpath(vim.fn.stdpath("data"), "luau")

if not vim.uv.fs_stat(luau_directory) then
    vim.fn.mkdir(luau_directory, "p")
end

local to_download = {
    ["types.d.luau"] = "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.PluginSecurity.d.luau",
    ["docs.json"] = "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json",
}

for name, url in pairs(to_download) do
    vim.fn.system({ "curl", "-fLo", vim.fs.joinpath(luau_directory, name), url })
end
