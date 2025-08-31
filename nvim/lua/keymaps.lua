local function map(mode, left, right, opts)
    vim.keymap.set(mode, left, right, vim.tbl_extend("force", opts or {}, { silent = true }))
end

vim.g.mapleader = " "

-- Scrolling
map({ "n", "v" }, "<S-h>", "zh", { desc = "Scroll Left" })
map({ "n", "v" }, "<S-l>", "zl", { desc = "Scroll Right" })

-- Resize window using <ctrl> arrow keys
map("n", "<C-Up>", ":resize +2<CR>", { desc = "Increase Window Height" })
map("n", "<C-Down>", ":resize -2<CR>", { desc = "Decrease Window Height" })
map("n", "<C-Left>", ":vertical resize -2<CR>", { desc = "Decrease Window Width" })
map("n", "<C-Right>", ":vertical resize +2<CR>", { desc = "Increase Window Width" })

-- Normal mode line movement
map("n", "<A-j>", ":move .+1<CR>==", { desc = "Move Down" })
map("n", "<A-k>", ":move .-2<CR>==", { desc = "Move Up" })

-- Insert mode line movement
map("i", "<A-j>", "<esc>:move .+1<CR>==gi", { desc = "Move Down" })
map("i", "<A-k>", "<esc>:move .-2<CR>==gi", { desc = "Move Up" })

-- Visual mode line movement
map("v", "<A-j>", ":<C-u>execute \"'<,'>move '>+\" . v:count1<cr>gv=gv", { desc = "Move Down" })
map("v", "<A-k>", ":<C-u>execute \"'<,'>move '<-\" . (v:count1 + 1)<cr>gv=gv", { desc = "Move Up" })

-- Buffer Navigation & Management
map("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })
map("n", "<leader>bD", ":bdelete!<CR>", { desc = "Delete Buffer Without Saving" })

-- Saving & Quitting
map({ "x", "n", "s" }, "<leader>w", ":write<CR>", { desc = "Save File" })
map("n", "<leader>qq", ":quit<CR>", { desc = "Quit" })
map("n", "<leader>QQ", ":quit!<CR>", { desc = "Force Quit" })
map("n", "<leader>qr", ":restart<CR>", { desc = "Restart" })

-- Indenting (Visual Mode)
map("v", "<", "<gv")
map("v", ">", ">gv")

-- Commenting
map("n", "gco", "o<esc>Vcx<esc>:normal gcc<CR>fxa<bs>", { desc = "Add Comment Below" })
map("n", "gcO", "O<esc>Vcx<esc>:normal gcc<CR>fxa<bs>", { desc = "Add Comment Above" })

-- Changing & Pasting
map({ "n", "v" }, "c", '"_c', { noremap = true })
map({ "n", "v" }, "C", '"_C', { noremap = true })
map("v", "p", '"_dP', { noremap = true })
map("v", "P", '"_dP', { noremap = true })
