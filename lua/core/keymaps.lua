local map = vim.keymap.set

map("n", "<Esc>", "<cmd>nohlsearch<cr>", { desc = "Clear search highlight" })

-- Window navigation stays compatible with a future vim-tmux-navigator layer.
map("n", "<C-h>", "<C-w>h", { desc = "Window left" })
map("n", "<C-j>", "<C-w>j", { desc = "Window down" })
map("n", "<C-k>", "<C-w>k", { desc = "Window up" })
map("n", "<C-l>", "<C-w>l", { desc = "Window right" })

map("n", "<leader>w", "<cmd>write<cr>", { desc = "Save file" })
map("n", "<leader>q", "<cmd>quit<cr>", { desc = "Quit window" })

map("v", "<", "<gv", { desc = "Indent left" })
map("v", ">", ">gv", { desc = "Indent right" })
map("n", "<A-j>", ":move .+1<cr>==", { desc = "Move line down" })
map("n", "<A-k>", ":move .-2<cr>==", { desc = "Move line up" })
map("v", "<A-j>", ":move '>+1<cr>gv=gv", { desc = "Move selection down" })
map("v", "<A-k>", ":move '<-2<cr>gv=gv", { desc = "Move selection up" })

-- Buffers
map("n", "<S-l>", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<S-h>", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bn", "<cmd>bnext<cr>", { desc = "Next buffer" })
map("n", "<leader>bp", "<cmd>bprevious<cr>", { desc = "Previous buffer" })
map("n", "<leader>bd", "<cmd>bdelete<cr>", { desc = "Delete buffer" })
map("n", "<leader>bo", "<cmd>%bd|edit#|bdelete#<cr>", { desc = "Delete other buffers" })
map("n", "<leader>bl", "<cmd>edit #<cr>", { desc = "Last buffer" })

-- Diagnostics use Neovim 0.12's native [d and ]d mappings.
map("n", "<leader>xd", vim.diagnostic.open_float, { desc = "Line diagnostics" })
map("n", "<leader>ud", function()
	require("core.diagnostic-config").toggle_virtual_text()
end, { desc = "Toggle diagnostic virtual text" })

-- Oil remains the fast file-operation path; Neo-tree owns the sidebar.
map("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
map("n", "<leader>o", "<cmd>Oil<cr>", { desc = "Open file directory in Oil" })
map("n", "<leader>O", "<cmd>Oil --float<cr>", { desc = "Open Oil floating" })

-- Project navigation
map("n", "<leader>pp", "<cmd>FindProjects<cr>", { desc = "Find projects" })
map("n", "<leader>ps", "<cmd>ProjectSessionSave<cr>", { desc = "Save project session" })
map("n", "<leader>pl", "<cmd>ProjectSessionLoad<cr>", { desc = "Load project session" })
