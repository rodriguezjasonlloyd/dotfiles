require("gitsigns").setup({
    on_attach = function(bufnr)
        local gitsigns = require("gitsigns")

        local function map(mode, left, right, opts)
            vim.keymap.set(mode, left, right, vim.tbl_extend("force", opts or {}, { silent = true, buffer = bufnr }))
        end

        -- Navigation
        map("n", "]c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "]c", bang = true })
            else
                ---@diagnostic disable-next-line: param-type-mismatch
                gitsigns.nav_hunk("next")
            end
        end, { desc = "Go to next hunk" })

        map("n", "[c", function()
            if vim.wo.diff then
                vim.cmd.normal({ "[c", bang = true })
            else
                ---@diagnostic disable-next-line: param-type-mismatch
                gitsigns.nav_hunk("prev")
            end
        end, { desc = "Go to prev hunk" })

        -- Actions
        map("n", "<leader>hs", gitsigns.stage_hunk, { desc = "Stage hunk under cursor" })
        map("n", "<leader>hr", gitsigns.reset_hunk, { desc = "Reset hunk under cursor" })

        map("v", "<leader>hs", function()
            gitsigns.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Stage selected lines" })

        map("v", "<leader>hr", function()
            gitsigns.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
        end, { desc = "Reset selected lines" })

        map("n", "<leader>hS", gitsigns.stage_buffer, { desc = "Stage buffer" })
        map("n", "<leader>hR", gitsigns.reset_buffer, { desc = "Reset buffer" })
        map("n", "<leader>hp", gitsigns.preview_hunk, { desc = "Preview hunk" })
        map("n", "<leader>hi", gitsigns.preview_hunk_inline, { desc = "Preview hunk inline" })

        map("n", "<leader>hb", function()
            gitsigns.blame_line({ full = true })
        end, { desc = "Blame line" })

        map("n", "<leader>hd", gitsigns.diffthis, { desc = "Diff against index" })

        map("n", "<leader>hD", function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.diffthis("~")
        end, { desc = "Diff against HEAD~1" })

        map("n", "<leader>hQ", function()
            ---@diagnostic disable-next-line: param-type-mismatch
            gitsigns.setqflist("all")
        end, { desc = "Quickfix all hunks" })
        map("n", "<leader>hq", gitsigns.setqflist, { desc = "Quickfix buffer" })

        -- Toggles
        map("n", "<leader>tb", gitsigns.toggle_current_line_blame, { desc = "Toggle line blame" })
        map("n", "<leader>tw", gitsigns.toggle_word_diff, { desc = "Toggle word diff" })

        -- Text object
        map({ "o", "x" }, "ih", gitsigns.select_hunk, { desc = "Select hunk text object" })
    end,
})
