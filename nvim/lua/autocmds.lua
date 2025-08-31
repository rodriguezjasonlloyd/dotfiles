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

autocmd("FileType", {
    group = augroup("CloseFile"),
    pattern = { "help", "qf" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false

        vim.schedule(function()
            vim.keymap.set("n", "q", function()
                vim.cmd("close")
                pcall(vim.api.nvim_buf_delete, event.buf, { force = true })
            end, { buffer = event.buf, silent = true, desc = "Quit Buffer" })
        end)
    end,
})
