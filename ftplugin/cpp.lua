-- ============================================
-- C++ FTPLUGIN — Buffer-local settings & build helpers
-- Loaded automatically for every .cpp/.cc/.cxx/.h/.hpp file
-- ============================================

-- ── Editor settings ─────────────────────────────────────────────────────────
vim.opt_local.tabstop     = 4
vim.opt_local.shiftwidth  = 4
vim.opt_local.expandtab   = true    -- spaces, not tabs (clang-format will fix anyway)
vim.opt_local.textwidth   = 100
vim.opt_local.colorcolumn = "100"
vim.opt_local.commentstring = "// %s"

-- ── Quick compile & run helpers ──────────────────────────────────────────────
-- These work for single-file programs (competitive programming / quick tests).
-- For CMake projects use <leader>cb / <leader>cr from cmake-tools.

local bufnr = vim.api.nvim_get_current_buf()
local opts  = { buffer = bufnr, silent = true }

-- Compile current file with g++ (C++23, all warnings, debug info)
vim.keymap.set("n", "<leader>cc", function()
  local file = vim.fn.expand("%:p")
  local out  = vim.fn.expand("%:p:r")   -- strip extension
  local cmd  = string.format(
    "g++ -std=c++23 -Wall -Wextra -Wpedantic -g -O0 -o %s %s 2>&1",
    vim.fn.shellescape(out), vim.fn.shellescape(file)
  )
  vim.cmd("botright 12new")
  vim.fn.termopen(cmd, {
    on_exit = function(_, code)
      if code == 0 then
        vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "✅  Compiled OK → " .. out })
      else
        vim.api.nvim_buf_set_lines(0, -1, -1, false, { "", "❌  Compilation failed (exit " .. code .. ")" })
      end
    end,
  })
  vim.cmd("startinsert")
end, vim.tbl_extend("force", opts, { desc = "C++: Compile current file" }))

-- Compile + run (Release, optimized)
vim.keymap.set("n", "<leader>cr", function()
  local file = vim.fn.expand("%:p")
  local out  = vim.fn.expand("%:p:r")
  local cmd  = string.format(
    "g++ -std=c++23 -O2 -o %s %s && %s",
    vim.fn.shellescape(out), vim.fn.shellescape(file), vim.fn.shellescape(out)
  )
  vim.cmd("botright 15new")
  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, vim.tbl_extend("force", opts, { desc = "C++: Compile & Run" }))

-- Compile with AddressSanitizer (memory bugs)
vim.keymap.set("n", "<leader>cA", function()
  local file = vim.fn.expand("%:p")
  local out  = vim.fn.expand("%:p:r") .. "_asan"
  local cmd  = string.format(
    "g++ -std=c++23 -Wall -g -fsanitize=address,undefined -o %s %s && %s",
    vim.fn.shellescape(out), vim.fn.shellescape(file), vim.fn.shellescape(out)
  )
  vim.cmd("botright 15new")
  vim.fn.termopen(cmd)
  vim.cmd("startinsert")
end, vim.tbl_extend("force", opts, { desc = "C++: Compile & Run (ASan)" }))

-- ── Clangd inlay hints toggle ────────────────────────────────────────────────
vim.keymap.set("n", "<leader>ci", function()
  vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = bufnr }), { bufnr = bufnr })
end, vim.tbl_extend("force", opts, { desc = "C++: Toggle inlay hints" }))

-- ── clangd switch header/source ──────────────────────────────────────────────
vim.keymap.set("n", "<leader>ch", "<cmd>ClangdSwitchSourceHeader<cr>",
  vim.tbl_extend("force", opts, { desc = "C++: Switch header/source" }))

-- ── Generate compile_commands.json via cmake (shortcut) ─────────────────────
vim.keymap.set("n", "<leader>cC", function()
  local build = vim.fn.getcwd() .. "/build"
  local cmd = string.format("cmake -B %s -DCMAKE_EXPORT_COMPILE_COMMANDS=ON -G Ninja %s",
    vim.fn.shellescape(build), vim.fn.shellescape(vim.fn.getcwd()))
  vim.fn.system(cmd)
  local src = build .. "/compile_commands.json"
  local dst = vim.fn.getcwd() .. "/compile_commands.json"
  if vim.fn.filereadable(src) == 1 then
    vim.fn.system("cp " .. vim.fn.shellescape(src) .. " " .. vim.fn.shellescape(dst))
    vim.notify("compile_commands.json generated at project root ✅", vim.log.levels.INFO)
  else
    vim.notify("cmake failed — check if CMakeLists.txt exists", vim.log.levels.WARN)
  end
end, vim.tbl_extend("force", opts, { desc = "C++: Generate compile_commands.json" }))

-- ── clangd type hierarchy / AST (clangd_extensions) ─────────────────────────
vim.keymap.set("n", "<leader>cT", "<cmd>ClangdTypeHierarchy<cr>",
  vim.tbl_extend("force", opts, { desc = "C++: Type Hierarchy" }))
vim.keymap.set("n", "<leader>cM", "<cmd>ClangdMemoryUsage<cr>",
  vim.tbl_extend("force", opts, { desc = "C++: clangd Memory Usage" }))
