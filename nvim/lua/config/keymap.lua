local map = vim.keymap.set

-- Movement (Better up/down)
map({ "n", "x" }, "j", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "<Down>", "v:count == 0 ? 'gj' : 'j'", { desc = "Down", expr = true, silent = true })
map({ "n", "x" }, "k", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })
map({ "n", "x" }, "<Up>", "v:count == 0 ? 'gk' : 'k'", { desc = "Up", expr = true, silent = true })

-- Move to window using <ctrl> hjkl keys
map("n", "<C-h>", "<C-w>h", { desc = "Go to Left Window", remap = true , silent = true})
map("n", "<C-j>", "<C-w>j", { desc = "Go to Lower Window", remap = true , silent = true})
map("n", "<C-k>", "<C-w>k", { desc = "Go to Upper Window", remap = true , silent = true})
map("n", "<C-l>", "<C-w>l", { desc = "Go to Right Window", remap = true , silent = true})

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase Window Height" , silent = true})
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease Window Height" , silent = true})
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease Window Width" , silent = true})
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase Window Width" , silent = true})

-- Normal mode line movement
map("n", "<A-j>", ":m .+1<CR>==", { desc = "Move Down" , silent = true})
map("n", "<A-k>", ":m .-2<CR>==", { desc = "Move Up" , silent = true})

-- Insert mode line movement
map("i", "<A-j>", "<esc>:m .+1<CR>==gi", { desc = "Move Down" , silent = true})
map("i", "<A-k>", "<esc>:m .-2<CR>==gi", { desc = "Move Up" , silent = true})

-- Visual mode line movement
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" , silent = true})
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" , silent = true})

-- Buffer Navigation & Management
map("n", "<S-h>", ":bprevious<CR>", { desc = "Prev Buffer" , silent = true})
map("n", "<S-l>", ":bnext<CR>", { desc = "Next Buffer" , silent = true})
map("n", "<leader>bd", ":bd<CR>", { desc = "Delete Buffer" , silent = true})
map("n", "<leader>bD", ":bd!<CR>", { desc = "Delete Buffer Without Saving" , silent = true})

-- Search and Redraw
map(
  "n",
  "<leader>ur",
  ":nohlsearch<bar>diffupdate<bar>normal! <C-L><CR>",
  { desc = "Redraw / Clear hlsearch / Diff Update" , silent = true}
)

-- Search Navigation (n/N)
map("n", "n", "'Nn'[v:searchforward].'zv'", { expr = true, desc = "Next Search Result" , silent = true})
map("x", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" , silent = true})
map("o", "n", "'Nn'[v:searchforward]", { expr = true, desc = "Next Search Result" , silent = true})
map("n", "N", "'nN'[v:searchforward].'zv'", { expr = true, desc = "Prev Search Result" , silent = true})
map("x", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" , silent = true})
map("o", "N", "'nN'[v:searchforward]", { expr = true, desc = "Prev Search Result" , silent = true})

-- Saving & Quitting
map({ "x", "n", "s" , silent = true}, "<leader>w", ":w<CR>", { desc = "Save File", silent = true })
map("n", "<leader>qq", ":q<CR>", { desc = "Quit" , silent = true})
map("n", "<leader>QQ", ":q!<CR>", { desc = "Force Quit" , silent = true})

-- Indenting (Visual Mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<esc>Vcx<esc>:normal gcc<CR>fxa<bs>", { desc = "Add Comment Below" , silent = true})
map("n", "gcO", "O<esc>Vcx<esc>:normal gcc<CR>fxa<bs>", { desc = "Add Comment Above" , silent = true})

-- Telescope (Fuzzy Finder)
map("n", "<leader>ff", ":Telescope find_files<CR>", { desc = "Telescope Find Files" , silent = true})
map("n", "<leader>fg", ":Telescope live_grep<CR>", { desc = "Telescope Live Grep" , silent = true})
map("n", "<leader>fb", ":Telescope buffers<CR>", { desc = "Telescope Buffers" , silent = true})

-- LSP / Language Features
map("n", "<leader>ca", vim.lsp.buf.code_action, { desc = "View Code Actions" , silent = true})
map("n", "<leader>rn", vim.lsp.buf.rename, { desc = "Rename Variable" , silent = true})
map("n", "K", vim.lsp.buf.hover, { desc = "Hover" , silent = true})
map("n", "gd", vim.lsp.buf.definition, { desc = "Go To Definition" , silent = true})
map("n", "gr", vim.lsp.buf.references, { desc = "Show References" , silent = true})

-- Trouble (Diagnostics)
map("n", "<leader>xx", function()
    vim.diagnostic.open_float({
        border = "rounded",
    })
end, { desc = "Open Diagnostics", silent = true })
