vim.cmd.colorscheme("evergarden-winter")

require("noice").setup({
    presets = {
        cmdline_output_to_split = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
    },
    cmdline = { view = "cmdline" },
    lsp = {
        override = {
            ["vim.lsp.util.convert_input_to_markdown_lines"] = false,
            ["vim.lsp.util.stylize_markdown"] = false,
            ["cmp.entry.get_documentation"] = false,
        },
    },
    views = {
        hover = {
            border = { style = "single", padding = { 0, 0 } },
            position = { row = 2, col = 1 },
        },
    },
    routes = {
        {
            view = "notify",
            filter = { event = "lsp", kind = "progress" },
            opts = { replace = true },
        },
    },
})

require("lualine").setup({
    options = {
        theme = "auto",
        section_separators = "",
        component_separators = "",
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "branch", "diff", "diagnostics" },
        lualine_c = { { "filename", path = 4 } },
        lualine_x = {
            { "encoding" },
            { "fileformat" },
            { "filetype", icon_only = true },
            {
                function()
                    local _, client = next(vim.lsp.get_clients({ bufnr = 0 }))

                    if client == nil then
                        return "No Active LSP"
                    end

                    return client.name
                end,
                padding = { left = 0, right = 1 },
            },
        },
        lualine_y = {
            { "progress", separator = "", padding = { left = 1, right = 0 } },
            { "location", padding = { left = 0, right = 1 } },
        },
        lualine_z = {
            function()
                return os.date("%R")
            end,
        },
    },
})

require("markview").setup({
    preview = { enable = false },
})
