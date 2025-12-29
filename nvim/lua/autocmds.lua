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
        vim.keymap.set("n", "q", ":close<CR>", { buffer = event.buf, silent = true, desc = "Close Window" })
    end,
})

do
    local parsers = vim.api.nvim_get_runtime_file("parser/*", true)
    local parser_names = {}

    for _, parser in ipairs(parsers) do
        local parser_name = vim.fn.fnamemodify(parser, ":t:r")
        parser_names[parser_name] = true
    end

    autocmd("FileType", {
        group = augroup("StartTreesitter"),
        callback = function(args)
            local filetype = vim.bo[args.buf].filetype

            if filetype == "" then
                return
            end

            local language = vim.treesitter.language.get_lang(filetype)

            if language == nil then
                return
            end

            if parser_names[language] == nil then
                return
            end

            vim.treesitter.start(args.buf, language)
        end,
    })
end
