return function(root)
    local modules = {}
    local base = vim.fs.basename(root)

    local function has_lua_files(path)
        for name, typ in vim.fs.dir(path, { depth = 1 }) do
            if typ == "file" and name:match("%.lua$") then
                return true
            end
        end
        return false
    end

    if has_lua_files(root) then
        table.insert(modules, base)
    end

    local function scan(path, parent)
        for name, typ in vim.fs.dir(path, { depth = 1 }) do
            if typ == "directory" then
                local full = vim.fs.joinpath(path, name)
                local init_file = vim.fs.joinpath(full, "init.lua")

                if not vim.uv.fs_stat(init_file) and has_lua_files(full) then
                    local module_name = parent .. "." .. name
                    table.insert(modules, module_name)
                    scan(full, module_name)
                else
                    scan(full, parent .. "." .. name)
                end
            end
        end
    end

    scan(root, base)
    return modules
end
