local get_descendants = require("utility.get_descendants")

local data_directory = vim.fn.stdpath("data")
local lazy_path = vim.fs.joinpath(data_directory, "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazy_path) then
    vim.notify("Cloning lazy.nvim into " .. lazy_path, vim.log.levels.INFO)

    local ok, output = pcall(vim.fn.system, {
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_path,
    })
    if not ok or vim.fn.getenv("SHELL_ERROR") ~= "0" then
        vim.notify("Failed to clone lazy.nvim:\n" .. (output or ""), vim.log.levels.ERROR)
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazy_path)

local plugin_root = vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins")
local plugin_specs = get_descendants(plugin_root)

for i, module in ipairs(plugin_specs) do
    plugin_specs[i] = { import = module }
end

require("lazy").setup({
    spec = plugin_specs,
    defaults = {
        lazy = false,
        version = false,
    },
    install = {
        colorscheme = { "tokyonight" },
    },
    performance = {
        rtp = {
            disabled_plugins = {
                "gzip",
                "tarPlugin",
                "tohtml",
                "tutor",
                "zipPlugin",
            },
        },
    },
})
