local function augroup(name)
    return vim.api.nvim_create_augroup("lazyvim_" .. name, { clear = true })
end

-- Check if we need to reload the file when it changed
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    group = augroup("checktime"),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    group = augroup("highlight_yank"),
    callback = function()
        (vim.hl or vim.highlight).on_yank()
    end,
})

-- close some filetypes with <q>
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("close_with_q"),
    pattern = {
        "PlenaryTestPopup",
        "checkhealth",
        "dbout",
        "gitsigns-blame",
        "grug-far",
        "help",
        "lspinfo",
        "neotest-output",
        "neotest-output-panel",
        "neotest-summary",
        "notify",
        "qf",
        "spectre_panel",
        "startuptime",
        "tsplayground",
    },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, {
                buffer = event.buf,
                silent = true,
                desc = "Quit buffer",
            })
        end)
    end,
})

-- wrap and check for spell in text filetypes
vim.api.nvim_create_autocmd("FileType", {
    group = augroup("wrap_spell"),
    pattern = { "text", "plaintex", "typst", "gitcommit", "markdown" },
    callback = function()
        vim.opt_local.wrap = true
        vim.opt_local.spell = true
    end,
})

vim.api.nvim_create_autocmd("VimEnter", {
    group = augroup("session_restore"),
    callback = function()
        if vim.fn.argc() == 0 and not vim.o.modified then
            vim.defer_fn(function()
                require("persistence").load()
            end, 100)
        end
    end,
})

vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = ".eslintrc",
    callback = function()
        vim.bo.filetype = "json"
    end,
})

local rojoSourcemapWatchPID

vim.api.nvim_create_autocmd("VimEnter", {
    callback = function()
        local project_files = vim.fn.glob("*.project.json", false, true)
        local project_file = project_files[1]

        if not project_file or project_file == "" then
            return
        end

        if rojoSourcemapWatchPID then
            vim.loop.kill(rojoSourcemapWatchPID, "sigterm")
            rojoSourcemapWatchPID = nil
        end

        local cmd = {
            "rojo",
            "sourcemap",
            "--watch",
            project_file,
            "--output",
            "sourcemap.json",
        }

        local ok, job = pcall(vim.system, cmd, { text = true }, function(result)
            if result.stderr and result.stderr ~= "" then
                vim.defer_fn(function()
                    vim.notify("Rojo sourcemap error: " .. result.stderr, vim.log.levels.ERROR)
                end, 100)
            end
        end)

        if ok and job then
            rojoSourcemapWatchPID = job.pid
        else
            vim.notify("Failed to start rojo sourcemap watcher", vim.log.levels.ERROR)
        end
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    callback = function()
        if rojoSourcemapWatchPID then
            vim.loop.kill(rojoSourcemapWatchPID, "sigterm")
            rojoSourcemapWatchPID = nil
        end
    end,
})
