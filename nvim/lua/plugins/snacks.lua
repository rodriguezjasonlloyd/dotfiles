local snacks = require("snacks")

snacks.setup({
    dashboard = {
        sections = {
            { section = "header" },
            { section = "keys", gap = 1, padding = 1 },
        },
    },
    indent = { enabled = true },
    input = { enabled = true },
    notifier = { enabled = true },
    picker = { enabled = true },
    statuscolumn = { enabled = true },
})

local map = vim.keymap.set

-- Find
map("n", "<leader>fb", Snacks.picker.buffers, { desc = "Buffers" })
map("n", "<leader>ff", Snacks.picker.files, { desc = "Find Files" })
map("n", "<leader>fp", Snacks.picker.projects, { desc = "Projects" })
map("n", "<leader>fr", Snacks.picker.recent, { desc = "Recent" })
-- Grep
map("n", "<leader>sB", Snacks.picker.grep_buffers, { desc = "Grep Open Buffers" })
map("n", "<leader>sg", Snacks.picker.grep, { desc = "Grep" })
map({ "n", "x" }, "<leader>sw", Snacks.picker.grep_word, { desc = "Visual selection or word" })
-- Search
map("n", '<leader>s"', Snacks.picker.registers, { desc = "Registers" })
map("n", "<leader>s/", Snacks.picker.search_history, { desc = "Search History" })
map("n", "<leader>sa", Snacks.picker.autocmds, { desc = "Autocmds" })
map("n", "<leader>sb", Snacks.picker.lines, { desc = "Buffer Lines" })
map("n", "<leader>sc", Snacks.picker.command_history, { desc = "Command History" })
map("n", "<leader>sC", Snacks.picker.commands, { desc = "Commands" })
map("n", "<leader>sd", Snacks.picker.diagnostics, { desc = "Diagnostics" })
map("n", "<leader>sD", Snacks.picker.diagnostics_buffer, { desc = "Buffer Diagnostics" })
map("n", "<leader>sh", Snacks.picker.help, { desc = "Help Pages" })
map("n", "<leader>sH", Snacks.picker.highlights, { desc = "Highlights" })
map("n", "<leader>si", Snacks.picker.icons, { desc = "Icons" })
map("n", "<leader>sj", Snacks.picker.jumps, { desc = "Jumps" })
map("n", "<leader>sk", Snacks.picker.keymaps, { desc = "Keymaps" })
map("n", "<leader>sl", Snacks.picker.loclist, { desc = "Location List" })
map("n", "<leader>sm", Snacks.picker.marks, { desc = "Marks" })
map("n", "<leader>sM", Snacks.picker.man, { desc = "Man Pages" })
map("n", "<leader>sp", Snacks.picker.lazy, { desc = "Search for Plugin Spec" })
map("n", "<leader>sq", Snacks.picker.qflist, { desc = "Quickfix List" })
map("n", "<leader>sR", Snacks.picker.resume, { desc = "Resume" })
map("n", "<leader>su", Snacks.picker.undo, { desc = "Undo History" })
map("n", "<leader>uC", Snacks.picker.colorschemes, { desc = "Colorschemes" })
-- LSP
map("n", "gd", Snacks.picker.lsp_definitions, { desc = "Goto Definition" })
map("n", "gD", Snacks.picker.lsp_declarations, { desc = "Goto Declaration" })
map("n", "grr", Snacks.picker.lsp_references, { desc = "References" })
map("n", "gI", Snacks.picker.lsp_implementations, { desc = "Goto Implementation" })
map("n", "gy", Snacks.picker.lsp_type_definitions, { desc = "Goto T[y]pe Definition" })
map("n", "<leader>ss", Snacks.picker.lsp_symbols, { desc = "LSP Symbols" })
map("n", "<leader>sS", Snacks.picker.lsp_workspace_symbols, { desc = "LSP Workspace Symbols" })
-- Others
map("n", "<leader>n", Snacks.picker.notifications, { desc = "Notification History" })
