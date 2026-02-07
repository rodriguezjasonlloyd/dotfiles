require("nvim-autopairs").setup({ fast_wrap = {} })
require("nvim-ts-autotag").setup({})

local flash = require("flash")

local function map(mode, left, right, opts)
    vim.keymap.set(mode, left, right, vim.tbl_extend("force", opts or {}, { silent = true }))
end

map({ "n", "x", "o" }, "s", flash.jump, { desc = "Flash Jump" })
map({ "n", "x", "o" }, "S", flash.treesitter, { desc = "Flash Treesitter" })
map("o", "r", flash.remote, { desc = "Flash Jump" })
map({ "x", "o" }, "R", flash.treesitter_search, { desc = "Flash Treesitter" })

local persistence = require("persistence")
persistence.setup()

if vim.fn.argc() == 0 then
    vim.schedule(persistence.load)
end

local oil = require("oil")

oil.setup({
    constrain_cursor = "name",
    float = {
        border = "solid",
        max_width = 0.6,
        padding = 4,
    },
    skip_confirm_for_simple_edits = true,
})

vim.keymap.set("n", "\\", oil.toggle_float, { desc = "Toggle Oil Float", silent = true })

require("which-key").setup({
    preset = "modern",
})

require("cord").setup({
    editor = { tooltip = "Neovim" },
    idle = { enabled = false },
    advanced = { server = { timeout = 30000 } },
})
