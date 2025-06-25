return {
    "folke/snacks.nvim",
    priority = 1000,
    lazy = false,
    opts = {
        indent = { enabled = true },
        input = { enabled = true },
        notifier = { enabled = true },
        picker = { enabled = true },
        statuscolumn = { enabled = true },
    },
    keys = function()
        local snacks = require("snacks")

        return {
            { "<leader><space>", snacks.picker.smart, desc = "Smart Find Files" },
            { "<leader>/", snacks.picker.grep, desc = "Grep" },
            { "<leader>:", snacks.picker.command_history, desc = "Command History" },
            { "<leader>n", snacks.picker.notifications, desc = "Notification History" },
            -- find
            { "<leader>fb", snacks.picker.buffers, desc = "Buffers" },
            {
                "<leader>fc",
                function()
                    snacks.picker.files({ cwd = vim.fn.stdpath("config") })
                end,
                desc = "Find Config File",
            },
            { "<leader>ff", snacks.picker.files, desc = "Find Files" },
            { "<leader>fg", snacks.picker.git_files, desc = "Find Git Files" },
            { "<leader>fp", snacks.picker.projects, desc = "Projects" },
            { "<leader>fr", snacks.picker.recent, desc = "Recent" },
            -- git
            { "<leader>gb", snacks.picker.git_branches, desc = "Git Branches" },
            { "<leader>gl", snacks.picker.git_log, desc = "Git Log" },
            { "<leader>gL", snacks.picker.git_log_line, desc = "Git Log Line" },
            { "<leader>gs", snacks.picker.git_status, desc = "Git Status" },
            { "<leader>gS", snacks.picker.git_stash, desc = "Git Stash" },
            { "<leader>gd", snacks.picker.git_diff, desc = "Git Diff (Hunks)" },
            { "<leader>gf", snacks.picker.git_log_file, desc = "Git Log File" },
            -- Grep
            { "<leader>sb", snacks.picker.lines, desc = "Buffer Lines" },
            { "<leader>sB", snacks.picker.grep_buffers, desc = "Grep Open Buffers" },
            { "<leader>sw", snacks.picker.grep_word, desc = "Visual selection or word", mode = { "n", "x" } },
            -- search
            { '<leader>s"', snacks.picker.registers, desc = "Registers" },
            { "<leader>s/", snacks.picker.search_history, desc = "Search History" },
            { "<leader>sa", snacks.picker.autocmds, desc = "Autocmds" },
            { "<leader>sb", snacks.picker.lines, desc = "Buffer Lines" },
            { "<leader>sc", snacks.picker.command_history, desc = "Command History" },
            { "<leader>sC", snacks.picker.commands, desc = "Commands" },
            { "<leader>sd", snacks.picker.diagnostics, desc = "Diagnostics" },
            { "<leader>sD", snacks.picker.diagnostics_buffer, desc = "Buffer Diagnostics" },
            { "<leader>sh", snacks.picker.help, desc = "Help Pages" },
            { "<leader>sH", snacks.picker.highlights, desc = "Highlights" },
            { "<leader>si", snacks.picker.icons, desc = "Icons" },
            { "<leader>sj", snacks.picker.jumps, desc = "Jumps" },
            { "<leader>sk", snacks.picker.keymaps, desc = "Keymaps" },
            { "<leader>sl", snacks.picker.loclist, desc = "Location List" },
            { "<leader>sm", snacks.picker.marks, desc = "Marks" },
            { "<leader>sM", snacks.picker.man, desc = "Man Pages" },
            { "<leader>sp", snacks.picker.lazy, desc = "Search for Plugin Spec" },
            { "<leader>sq", snacks.picker.qflist, desc = "Quickfix List" },
            { "<leader>sR", snacks.picker.resume, desc = "Resume" },
            { "<leader>su", snacks.picker.undo, desc = "Undo History" },
            { "<leader>uC", snacks.picker.colorschemes, desc = "Colorschemes" },
            -- LSP
            { "gd", snacks.picker.lsp_definitions, desc = "Goto Definition" },
            { "gD", snacks.picker.lsp_declarations, desc = "Goto Declaration" },
            { "gy", snacks.picker.lsp_type_definitions, desc = "Goto T[y]pe Definition" },
            { "<leader>ss", snacks.picker.lsp_symbols, desc = "LSP Symbols" },
            { "<leader>sS", snacks.picker.lsp_workspace_symbols, desc = "LSP Workspace Symbols" },
        }
    end,
}
