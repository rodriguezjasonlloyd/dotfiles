local autocmd = vim.api.nvim_create_autocmd
local augroup = function(name)
    return vim.api.nvim_create_augroup(name, { clear = true })
end

autocmd("TextYankPost", {
    group = augroup("HighlightYank"),
    callback = function()
        vim.hl.on_yank()
    end,
})

autocmd("VimEnter", {
    group = augroup("SessionRestore"),
    callback = function()
        if vim.fn.argc() == 0 and not vim.o.modified then
            vim.defer_fn(function()
                local ok, persistence = pcall(require, "persistence")
                if not ok or type(persistence.load) ~= "function" then
                    return
                end
                persistence.load()
            end, 0)
        end
    end,
})

autocmd("FileType", {
    group = augroup("CloseFile"),
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
                desc = "Quit Buffer",
            })
        end)
    end,
})
