local get_descendants = require("utility.get_descendants")

local lazy_path = vim.fs.joinpath(vim.fn.stdpath("data"), "lazy", "lazy.nvim")

if not vim.uv.fs_stat(lazy_path) then
    local output = vim.fn.system({
        "git",
        "clone",
        "--filter=blob:none",
        "--branch=stable",
        "https://github.com/folke/lazy.nvim.git",
        lazy_path,
    })
    if vim.v.shell_error ~= 0 then
        vim.notify("Failed to clone lazy.nvim:\n" .. (output or ""), vim.log.levels.ERROR)
        os.exit(1)
    end
end

vim.opt.rtp:prepend(lazy_path)

local plugin_specs = get_descendants(vim.fs.joinpath(vim.fn.stdpath("config"), "lua", "plugins"))

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
