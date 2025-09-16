---@type vim.lsp.Config
return {
    cmd = { "vscode-json-language-server", "--stdio" },
    filetypes = { "json", "jsonc" },
    init_options = {
        provideFormatter = true,
    },
    root_markers = { ".git" },
    on_attach = function(_, bufnr)
        vim.bo[bufnr].shiftwidth = 2
    end,
}
