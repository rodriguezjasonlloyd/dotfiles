local data_dir = vim.fn.stdpath("data")
local luau_dir = data_dir .. "/luau"

if vim.loop.fs_stat(luau_dir) == nil then
    vim.fn.mkdir(luau_dir, "p")
end

local function download_file(url, destination)
    local cmd = { "curl", "-fLo", destination, url }

    vim.notify("Downloading " .. url .. " to " .. destination, vim.log.levels.INFO)

    vim.fn.system(cmd)

    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to download " .. url, vim.log.levels.ERROR)
    else
        vim.notify("Downloaded " .. destination, vim.log.levels.INFO)
    end
end

local global_types_file = luau_dir .. "/GlobalTypes.d.luau"

if vim.loop.fs_stat(global_types_file) == nil then
    download_file(
        "https://raw.githubusercontent.com/JohnnyMorganz/luau-lsp/main/scripts/globalTypes.PluginSecurity.d.luau",
        global_types_file
    )
end

local api_docs_file = luau_dir .. "/api-docs.json"

if vim.loop.fs_stat(api_docs_file) == nil then
    download_file(
        "https://raw.githubusercontent.com/MaximumADHD/Roblox-Client-Tracker/roblox/api-docs/en-us.json",
        api_docs_file
    )
end

