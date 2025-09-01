vim.g.enfocado_style = "neon"

vim.cmd.colorscheme("enfocado")

require("noice").setup({
    presets = {
        cmdline_output_to_split = true,
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
    },
    cmdline = {
        view = "cmdline",
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
