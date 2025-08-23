return {
    "windwp/nvim-autopairs",
    event = { "InsertEnter" },
    dependencies = { "hrsh7th/nvim-cmp" },
    opts = {
        disable_filetype = { "TelescopePrompt", "vim" },
        ignored_next_char = "[%w%.]",
        enable_check_bracket_line = false,
        check_ts = true,
        ts_config = {
            lua = { "string" },
            javascript = { "template_string" },
            java = false,
        },
        fast_wrap = {},
    },
}
