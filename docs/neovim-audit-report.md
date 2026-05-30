# Neovim Audit Report

Date: 2026-05-30  
Repo: `/home/dorriss-dev/.config/nvim`  
Neovim: `NVIM v0.12.2`  
Scope: read-only audit of current Neovim/Neovide config. No config files were modified.

Reference docs checked:

- mason-tool-installer.nvim README: <https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim>
- mason-lspconfig.nvim README/docs: <https://github.com/mason-org/mason-lspconfig.nvim>
- nvim-lspconfig README/docs: <https://github.com/neovim/nvim-lspconfig>
- which-key.nvim local docs/config and upstream repo: <https://github.com/folke/which-key.nvim>
- oil.nvim: <https://github.com/stevearc/oil.nvim>
- neo-tree.nvim: <https://github.com/nvim-neo-tree/neo-tree.nvim>
- nvim-tree.lua: <https://github.com/nvim-tree/nvim-tree.lua>

## 1. Current Config Structure

Config root is `/home/dorriss-dev/.config/nvim`.

Entry point is `init.lua`, not `init.vim`.

Plugin manager is `lazy.nvim`, bootstrapped in `init.lua` and loaded with:

```lua
require("lazy").setup("plugins", {
  change_detection = { notify = false },
})
```

Current load graph:

```text
init.lua
  -> require("core.neovide")
  -> require("core.options")
  -> require("core.keymaps")
  -> require("core.autocmds")
  -> require("core.diagnostic-config")
  -> require("core.java-autocmd")
  -> bootstrap lazy.nvim
  -> require("lazy").setup("plugins")
      -> lua/plugins/*.lua
          -> lsp.lua
          -> cmp.lua
          -> formatting.lua
          -> lint.lua
          -> treesitter.lua
          -> java.lua
          -> cpp.lua
          -> go.lua
          -> oil.lua
          -> neo-tree.lua
          -> telescope.lua
          -> ui.lua
          -> colorscheme.lua
          -> bufferline.lua
          -> gitsigns.lua
          -> fugitive.lua
          -> diffview.lua
          -> trouble.lua
          -> editor.lua
          -> etc.
      -> ftplugin/java.lua, ftplugin/go.lua, ftplugin/cpp.lua load by filetype
```

Main files:

- `init.lua`: main entry point and lazy.nvim setup.
- `lua/core/neovide.lua`: Neovide GUI settings.
- `lua/core/options.lua`: global options, diagnostics, notification filtering.
- `lua/core/keymaps.lua`: global keymaps, including Oil mappings.
- `lua/core/autocmds.lua`: yank highlight and terminal close autocmd.
- `lua/core/diagnostic-config.lua`: second global diagnostic config.
- `lua/core/java-autocmd.lua`: Java filetype diagnostic/JDTLS check.
- `lua/plugins/lsp.lua`: LSP, Mason, mason-tool-installer, mason-lspconfig.
- `lua/plugins/cmp.lua`: completion and snippets.
- `lua/plugins/formatting.lua`: conform.nvim formatter config.
- `lua/plugins/lint.lua`: nvim-lint config.
- `lua/plugins/treesitter.lua`: Treesitter parsers.
- `lua/plugins/java.lua` and `ftplugin/java.lua`: nvim-jdtls and Java launch config.
- `lua/plugins/cpp.lua` and `ftplugin/cpp.lua`: C/C++ CMake, DAP, clangd extensions, build helpers.
- `lua/plugins/go.lua` and `ftplugin/go.lua`: go.nvim and Go helpers.
- `lua/plugins/ui.lua`, `colorscheme.lua`, `bufferline.lua`, `gitsigns.lua`: UI/theme/status/git specs.

Worktree note: several files were already modified or untracked before this report, including `lua/plugins/lsp.lua`, `lua/plugins/formatting.lua`, `lua/plugins/lint.lua`, `lua/plugins/treesitter.lua`, `lua/core/neovide.lua`, `ftplugin/java.lua`, `ftplugin/cpp.lua`, and `lua/plugins/cpp.lua`.

## 2. Current Plugin Inventory

### Plugin manager

- `folke/lazy.nvim`
- Config: `init.lua`
- Issue: no direct lazy.nvim config issue found in repo. A sandboxed headless run with altered `XDG_STATE_HOME` produced a lazy package cache error, but that is not confirmed as a normal runtime startup issue.

### LSP

- `neovim/nvim-lspconfig`
- Config: `lua/plugins/lsp.lua`
- Servers configured in Lua table: `gopls`, `lua_ls`, `ts_ls`, `eslint`, `html`, `cssls`, `tailwindcss`, `jsonls`, `pyright`, `omnisharp`, `clangd`.
- Java is special-cased and run through `nvim-jdtls` in `ftplugin/java.lua`.
- Compatibility issue: latest nvim-lspconfig docs say `require("lspconfig")[server].setup(...)` is legacy/deprecated on Neovim 0.11+ in favor of `vim.lsp.config(...)` and `vim.lsp.enable(...)`. Current config uses the old setup path at `lua/plugins/lsp.lua:187`.
- Functional startup issue: current `mason-lspconfig` v2 no longer uses the old `handlers` setup style in the documented path; it automatically enables installed servers via `vim.lsp.enable()` by default. Current `handlers` table at `lua/plugins/lsp.lua:178-190` is old-style and should be migrated.

### Mason / mason-lspconfig / mason-tool-installer

- `williamboman/mason.nvim`
- `williamboman/mason-lspconfig.nvim` / current upstream is `mason-org/mason-lspconfig.nvim`
- `WhoIsSethDaniel/mason-tool-installer.nvim`
- Config: `lua/plugins/lsp.lua`
- Definite error: `lua/plugins/lsp.lua:173-175` passes `integrations["mason-lspconfig"]` as a table:

```lua
integrations = {
  ["mason-lspconfig"] = { automatic_installation = false },
},
```

`mason-tool-installer` validates that `integrations["mason-lspconfig"]` is a boolean, so this causes `mason-lspconfig: expected boolean, got table`.

- API drift: `mason-lspconfig` latest docs use `automatic_enable`, not `automatic_installation`, and the old setup `handlers` approach is not the documented v2 path.

### Completion

- `hrsh7th/nvim-cmp`
- `hrsh7th/cmp-nvim-lsp`
- `hrsh7th/cmp-buffer`
- `hrsh7th/cmp-path`
- Config: `lua/plugins/cmp.lua`
- Status: functional old-school nvim-cmp stack. No startup crash found.
- Possible modernization: newer Neovim configs often use `saghen/blink.cmp`, but keeping nvim-cmp is fine.

### Snippet

- `L3MON4D3/LuaSnip`
- `saadparwaiz1/cmp_luasnip`
- `rafamadriz/friendly-snippets`
- Config: `lua/plugins/cmp.lua`
- Duplicate spec: `LuaSnip` also appears as an optional spec in `lua/plugins/cpp.lua:216-220`. This is not useful because LuaSnip is already a dependency of cmp.

### Formatter

- `stevearc/conform.nvim`
- Config: `lua/plugins/formatting.lua`
- Formatters: Prettier, goimports, google-java-format, stylua, clang_format.
- Issue: `lsp_fallback = true` is older conform API. Current conform uses `lsp_format = "fallback"` in recent examples. It may still work via compatibility, but it should be checked before the next cleanup.
- Missing formatters for Shell (`shfmt`), SQL (`sqlfluff` or similar), Docker/YAML can rely on prettier for YAML only.

### Linter

- `mfussenegger/nvim-lint`
- Config: `lua/plugins/lint.lua`
- Linters: `eslint_d`, `ruff`, conditional `clangtidy`.
- Missing: `shellcheck`, `markdownlint-cli2`, Dockerfile lint, YAML lint if desired.
- Issue: `clang-tidy` is checked from shell PATH. Mason has `clangd`/`clang-format`, but not necessarily `clang-tidy`. System `clang-tidy` presence decides whether C/C++ lint is enabled.

### Treesitter

- `nvim-treesitter/nvim-treesitter`
- Config: `lua/plugins/treesitter.lua`
- Parsers: C/C++, CMake, Go, Java, frontend, config files, Lua/Vim, Markdown, Bash.
- Issue observed in sandbox/headless: parser dir under `/home/dorriss-dev/.local/share/nvim/lazy/nvim-treesitter/parser` was not writable from the sandbox. In normal desktop use this may not occur, but if it appears outside sandbox, make the parser dir writable or configure an alternative parser install directory.

### Debugger / DAP

- `mfussenegger/nvim-dap`
- `rcarriga/nvim-dap-ui`
- `nvim-neotest/nvim-nio`
- `theHamsta/nvim-dap-virtual-text`
- Config: `lua/plugins/cpp.lua`
- Current support: C/C++ only. Uses Mason `codelldb`, fallback to `lldb-dap` / `lldb-vscode`.
- Java debug adapter is not configured. Go debugging may be handled by go.nvim only if its debug dependencies are present.

### File explorer / navigation

- `stevearc/oil.nvim`
- Config: `lua/plugins/oil.lua`
- Keymaps: `-`, `<leader>e`, `<leader>fe` in `lua/core/keymaps.lua`.
- `neo-tree.nvim` exists as a disabled/commented spec in `lua/plugins/neo-tree.lua`.
- No active `nvim-tree.lua`.
- `mini.map` is installed/configured, but this is minimap, not file explorer.

### Fuzzy finder

- `nvim-telescope/telescope.nvim`
- `nvim-telescope/telescope-fzf-native.nvim`
- Config: `lua/plugins/telescope.lua`
- Status: strong coverage for files, grep, buffers, git, symbols, diagnostics.

### Git integration

- `lewis6991/gitsigns.nvim`
- `tpope/vim-fugitive`
- `sindrets/diffview.nvim`
- Telescope git pickers
- Config: `lua/plugins/gitsigns.lua`, `lua/plugins/fugitive.lua`, `lua/plugins/diffview.lua`, `lua/plugins/telescope.lua`, plus duplicate gitsigns spec in `lua/plugins/editor.lua`.
- Issue: `gitsigns.nvim` is declared twice. Keep the richer standalone config in `lua/plugins/gitsigns.lua` and remove the smaller duplicate from `lua/plugins/editor.lua` in a future patch.

### Terminal integration

- `akinsho/toggleterm.nvim`
- Config: `lua/plugins/editor.lua`
- Keymaps: `<C-\>`, `<leader>tt`, `<leader>tf`, `<leader>th`, `<leader>tv`.
- Status: good.

### Theme / colorscheme

- Active: `catppuccin/nvim`, `flavour = "mocha"`, transparent background.
- Config: duplicated in both `lua/plugins/ui.lua` and `lua/plugins/colorscheme.lua`.
- Issue: duplicate catppuccin specs can lead to config merge/order confusion. Keep one source of truth, preferably `lua/plugins/colorscheme.lua`.

### Statusline / bufferline

- `nvim-lualine/lualine.nvim`
- `akinsho/bufferline.nvim`
- Config: lualine and one bufferline spec in `lua/plugins/ui.lua`; another bufferline spec in `lua/plugins/bufferline.lua`.
- Issue: bufferline is duplicated. Keep `lua/plugins/bufferline.lua` and remove the duplicate from `lua/plugins/ui.lua`.

### which-key

- `folke/which-key.nvim`
- Config: `lua/plugins/ui.lua:175-187`
- Issue: `window = { ... }` is deprecated in which-key v3. Current option is `win = { ... }`. Health warning is expected from this exact config.

### UI / noice / notify / dashboard

- `rcarriga/nvim-notify`
- `folke/noice.nvim`
- `goolord/alpha-nvim`
- `stevearc/dressing.nvim`
- `folke/trouble.nvim`
- `folke/todo-comments.nvim`
- `folke/twilight.nvim`
- `folke/zen-mode.nvim`
- `NvChad/nvim-colorizer.lua`
- Status: broad UI stack.
- Issue: `core/options.lua` overrides `vim.notify` early and filters out which-key messages. Later `nvim-notify` replaces `vim.notify`. This can hide useful warnings during startup and makes debugging harder.

## 3. Current Tooling Matrix

Classification below considers both config and installed Mason packages observed under `/home/dorriss-dev/.local/share/nvim/mason`.

| Stack | Status | Current state | Recommendation |
| --- | --- | --- | --- |
| C/C++ | Đã có và khá ổn, nhưng config cần cleanup | `clangd`, `clang-format`, `codelldb`, `cpptools` are in Mason; system has `clangd`, `clang-format`, `cmake`, `gdb`; config has clangd, CMake tools, DAP, clangd_extensions, ftplugin helpers. | Keep. Add/verify `clang-tidy` if linting is important. Remove keymap collision between CMake `<leader>cr` and `ftplugin/cpp.lua` compile-run `<leader>cr`. |
| Java | Đã có nhưng config cần kiểm tra | `jdtls` and `google-java-format` are in Mason. `nvim-jdtls` exists. `ftplugin/java.lua` starts JDTLS with Lombok. | Keep. Fix comments vs values: file says APT off but sets `aptEnabled = true` and `-Dorg.eclipse.jdt.apt.aptEnabled=true`. Add Java debug/test bundles later if needed. |
| JavaScript/TypeScript | Đã có nhưng blocked bởi lỗi LSP startup | `ts_ls`, `eslint`, prettier, eslint_d configured; Mason has TS LS, ESLint LS, Prettier, eslint_d. | Fix Mason/LSP startup first. Then consider disabling ESLint `EslintFixAll` autocmd if project format policy differs. |
| React/Next | Đã có cơ bản | TS/JS, ESLint, Prettier, Tailwind LS configured and installed. | Good baseline. Add CSS modules/emmet choices only if needed. |
| Lua/Neovim config | Đã có | `lua_ls`, `stylua`, Treesitter Lua configured and installed. | Add Lua workspace settings for Neovim runtime if diagnostics are noisy. |
| Bash/Shell | Nên thêm | Treesitter Bash exists. No `bash-language-server`, `shfmt`, `shellcheck` in ensure/config. | Add `bashls`, `bash-language-server`, `shfmt`, `shellcheck`; add conform and nvim-lint entries. |
| Docker | Nên thêm | No Dockerfile or compose LSP configured. | Add `dockerls`/`dockerfile-language-server` and `docker_compose_language_service` if you edit Docker often. |
| YAML/JSON | JSON có, YAML thiếu LSP | `jsonls` configured and installed. YAML only formatted by Prettier, no `yamlls`. | Add `yamlls` and `yaml-language-server`; optionally configure schemas. |
| Markdown | Nên thêm vừa phải | Treesitter Markdown and Prettier formatting exist. No `marksman` or markdownlint. | Add `marksman` if writing docs often; add markdownlint only if project style requires it. |
| SQL | Không cần thêm ngay unless active SQL work | No SQL LSP/linter/formatter. | Add later: `sqlls`/`sqls` or `sqlfluff` depending on DB/workflow. |
| Git tooling | Đã có và tốt | gitsigns, fugitive, diffview, Telescope git. | Remove duplicate gitsigns spec only. |
| Go | Đã có | gopls, goimports, gofumpt, golangci-lint installed; go.nvim configured. | Good, but there are duplicate Go format/import autocmds in `go.lua` and `ftplugin/go.lua`; simplify later. |
| Python | Đã có dù không được hỏi | pyright, ruff, black installed/configured. | Fine to keep if you touch Python. |
| C# | Có một phần | omnisharp configured, csharpier installed; no omnisharp in Mason ensure list. | Keep only if needed. Otherwise it adds noise. |

Important environment note: from the shell, Mason binaries were not on `PATH`, so commands like `prettier`, `jdtls`, `stylua`, `gopls` appeared missing. Mason packages are present under Mason's install directory, and Neovim/Mason may inject its bin path at runtime. If tools fail inside Neovim, first check `:echo $PATH` and `:Mason`.

## 4. Startup Errors

### 4.1 nvim-lspconfig / mason-tool-installer error

Definite crashing startup error:

```text
lazy.nvim: Failed to run config for nvim-lspconfig
mason-tool-installer.nvim/lua/mason-tool-installer/init.lua:58:
mason-lspconfig: expected boolean, got table
```

Exact local cause:

- File: `lua/plugins/lsp.lua`
- Lines: `173-175`

```lua
integrations = {
  ["mason-lspconfig"] = { automatic_installation = false },
},
```

Why it fails:

- `mason-tool-installer` expects each integration flag to be boolean.
- Its defaults are effectively:

```lua
integrations = {
  ["mason-lspconfig"] = true,
  ["mason-null-ls"] = true,
  ["mason-nvim-dap"] = true,
}
```

- Current config passes a table where a boolean is required.
- `automatic_installation` belongs to older mason-lspconfig patterns, not to `mason-tool-installer.integrations`.

Second LSP compatibility issue:

- File: `lua/plugins/lsp.lua`
- Lines: `178-190`

```lua
require("mason-lspconfig").setup({
  handlers = {
    function(server_name)
      ...
      require("lspconfig")[server_name].setup(server)
    end,
  },
})
```

Latest docs checked:

- `mason-lspconfig.nvim` v2 requires Neovim >= 0.11 and says it automatically enables installed servers via `vim.lsp.enable()` by default. Its documented setting is `automatic_enable`, not `automatic_installation`.
- `nvim-lspconfig` says the old `require("lspconfig")` framework is deprecated on Nvim 0.11+ and should migrate to `vim.lsp.config(...)` plus `vim.lsp.enable(...)`.

Practical fix direction:

1. Change `mason-tool-installer.integrations["mason-lspconfig"]` to a boolean, usually `true` or `false`.
2. Move LSP server customization to `vim.lsp.config(server, opts)`.
3. Use `mason-lspconfig.setup({ automatic_enable = { exclude = { "jdtls" } } })` or `automatic_enable = false` depending on how explicit you want startup to be.
4. Keep `jdtls` excluded because `ftplugin/java.lua` owns Java startup via `nvim-jdtls`.

### 4.2 which-key health issue

Exact local cause:

- File: `lua/plugins/ui.lua`
- Lines: `180-185`

```lua
require("which-key").setup({
  window = {
    border = "rounded",
    position = "bottom",
  },
})
```

Why it warns:

- which-key v3 marks `window` as deprecated and points users to `opts.win`.
- The current plugin's config validator explicitly lists `window` as deprecated.
- `position = "bottom"` is also not part of the current `win` schema in the same way. Current layout is controlled by `preset`, `win`, and `layout`.

Suggested replacement:

```lua
require("which-key").setup({
  preset = "classic",
  win = {
    border = "rounded",
    padding = { 1, 2 },
  },
})
```

Also note: `lua/core/options.lua` filters notifications containing `which-key`, which can hide this warning. That filter should be removed after the config is corrected.

## 5. File Explorer Recommendation

### oil.nvim

Pros:

- Excellent for file operations because directories are editable buffers.
- Very fast and low UI overhead.
- Works well for renaming/moving batches of files.
- Can be kept as a power tool even if a tree is added.

Cons:

- Not a persistent project outline.
- Less comfortable for users who expect VS Code-style sidebar navigation.
- In very large projects, repeatedly drilling through directories can feel slower than scanning a persistent tree.

### neo-tree.nvim

Pros:

- Closest fit for a VS Code-style project sidebar.
- Supports filesystem, buffers, and git status sources.
- Has commands for reveal current file, left/right/float position, git status view.
- Integrates with diagnostics and devicons.
- Already has a disabled config file in this repo, so adoption is straightforward.

Cons:

- More dependencies (`plenary.nvim`, `nui.nvim`, devicons).
- More moving parts than oil or mini.files.
- Can need tuning for very large repos: hidden files, gitignored files, follow current file, filesystem watchers.

### nvim-tree.lua

Pros:

- Mature, focused filesystem tree.
- Good Git/diagnostic support.
- Familiar simple sidebar model.
- Usually lower conceptual overhead than neo-tree.

Cons:

- Primarily file tree, not multi-source tree framework.
- If you want buffers/git-status/tree-like views in one plugin, neo-tree is broader.
- This repo already has neo-tree scaffold, not nvim-tree scaffold.

### mini.files

Pros:

- Lightweight and consistent with mini.nvim design.
- Good for file operations and column-style navigation.
- Lower maintenance burden.

Cons:

- Not a VS Code-style persistent tree.
- Less likely to solve the specific large-project sidebar desire.

Recommendation:

- Use `neo-tree.nvim` as the project sidebar.
- Keep `oil.nvim` for file operations.
- Do not replace Oil with a tree; use both with clear keymaps.

Suggested keymaps:

```lua
{ "<leader>e", "<cmd>Neotree toggle reveal left<cr>", desc = "Toggle file tree" }
{ "<leader>E", "<cmd>Neotree focus filesystem left<cr>", desc = "Focus file tree" }
{ "<leader>o", "<cmd>Oil --float<cr>", desc = "Oil file operations" }
{ "-", "<cmd>Oil<cr>", desc = "Open parent directory" }
```

For this repo, `neo-tree` is the better next choice than `nvim-tree` because the repo already has `lua/plugins/neo-tree.lua`, bufferline offsets already reference `neo-tree`, and Catppuccin config already enables `neo_tree` integration.

## 6. Theme Recommendation

Current active theme: Catppuccin Mocha, configured twice:

- `lua/plugins/ui.lua`
- `lua/plugins/colorscheme.lua`

Recommended cleanup before trying themes: keep only `lua/plugins/colorscheme.lua` as the theme source of truth.

Themes worth trying:

| Theme | Pros | Cons | Neovide fit |
| --- | --- | --- | --- |
| Catppuccin Mocha | Current, soft, broad plugin support, readable for long sessions. | Pastel can feel low-contrast with transparency/blur. | Good, but consider less transparency or Macchiato if text feels soft. |
| TokyoNight Storm or Moon | Maintained, strong Treesitter/LSP/plugin support, familiar VS Code-adjacent feel. | Can feel too blue/purple if you want less neon. | Very good in Neovide; try Storm first for readable contrast. |
| Kanagawa Wave | Calm, distinctive, good Treesitter support, not too harsh. | Warmer palette may not suit everyone; some UI groups may need tweaking. | Very good for long sessions. |
| Gruvbox Material | Warm, high readability, excellent for C/system programming vibe. | Less modern-looking; can feel yellow/brown. | Good, especially if transparency is reduced. |
| Nightfox / Carbonfox | Many variants, strong LSP/Treesitter/plugin support, good terminal ecosystem. | More options mean more decision overhead. | Very good; Carbonfox is a good dark Neovide candidate. |

Try first: `tokyonight.nvim` with `style = "storm"` and `transparent = true/false` tested both ways. It gives the most noticeable "đổi gió" from Catppuccin while staying readable and well-supported.

Second choice: `kanagawa.nvim` with `theme = "wave"` if you want calmer and less VS Code-like.

## 7. Proposed Fix Plan

1. Fix startup crash in `lua/plugins/lsp.lua`.
   - Change `mason-tool-installer.integrations["mason-lspconfig"]` to boolean.
   - Migrate `mason-lspconfig` setup to v2 style.
   - Exclude `jdtls` from automatic enable.

2. Fix which-key config in `lua/plugins/ui.lua`.
   - Replace `window` with `win`.
   - Remove invalid/deprecated `position`.
   - Remove `which-key` notification suppression from `lua/core/options.lua` after warning is resolved.

3. De-duplicate plugin specs.
   - Keep `lua/plugins/colorscheme.lua`; remove Catppuccin from `lua/plugins/ui.lua`.
   - Keep `lua/plugins/bufferline.lua`; remove Bufferline from `lua/plugins/ui.lua`.
   - Keep `lua/plugins/gitsigns.lua`; remove Gitsigns from `lua/plugins/editor.lua`.
   - Keep one `fidget.nvim` config source.
   - Remove optional LuaSnip duplicate from `lua/plugins/cpp.lua`.

4. Add project tree.
   - Enable and modernize `lua/plugins/neo-tree.lua`.
   - Remap `<leader>e` to Neo-tree and `<leader>o` to Oil.

5. Expand multi-stack tooling.
   - Add Shell: `bashls`, `shfmt`, `shellcheck`.
   - Add Docker: `dockerls`, docker compose language service.
   - Add YAML: `yamlls`.
   - Add Markdown: `marksman`, optionally `markdownlint-cli2`.
   - Add SQL only when SQL work becomes frequent.

6. Theme trial.
   - Add TokyoNight as an alternative in `lua/plugins/colorscheme.lua`.
   - Test `tokyonight-storm` first.

## 8. Proposed Patch Preview

Do not apply blindly; this is a sketch for the next change pass.

### LSP/Mason direction

```lua
-- lua/plugins/lsp.lua
require("mason").setup()

require("mason-tool-installer").setup({
  ensure_installed = {
    "gopls",
    "goimports",
    "gofumpt",
    "golangci-lint",
    "lua-language-server",
    "stylua",
    "typescript-language-server",
    "eslint-lsp",
    "prettier",
    "eslint_d",
    "html-lsp",
    "css-lsp",
    "tailwindcss-language-server",
    "json-lsp",
    "jdtls",
    "google-java-format",
    "pyright",
    "ruff",
    "black",
    "clangd",
    "clang-format",
    "codelldb",
    "cpptools",
    -- proposed additions
    "bash-language-server",
    "shfmt",
    "shellcheck",
    "yaml-language-server",
    "dockerfile-language-server",
    "docker-compose-language-service",
    "marksman",
  },
  integrations = {
    ["mason-lspconfig"] = true,
  },
})

for server_name, server in pairs(servers) do
  server.capabilities = vim.tbl_deep_extend("force", {}, capabilities, server.capabilities or {})
  vim.lsp.config(server_name, server)
end

require("mason-lspconfig").setup({
  automatic_enable = {
    exclude = { "jdtls" },
  },
})
```

If you want full manual control instead:

```lua
require("mason-lspconfig").setup({
  automatic_enable = false,
})

for server_name, server in pairs(servers) do
  if server_name ~= "jdtls" then
    vim.lsp.config(server_name, server)
    vim.lsp.enable(server_name)
  end
end
```

### which-key

```lua
require("which-key").setup({
  preset = "classic",
  win = {
    border = "rounded",
    padding = { 1, 2 },
  },
})
```

### Neo-tree

```lua
return {
  "nvim-neo-tree/neo-tree.nvim",
  branch = "v3.x",
  dependencies = {
    "nvim-lua/plenary.nvim",
    "nvim-tree/nvim-web-devicons",
    "MunifTanjim/nui.nvim",
  },
  cmd = "Neotree",
  keys = {
    { "<leader>e", "<cmd>Neotree toggle reveal left<cr>", desc = "Toggle file tree" },
    { "<leader>E", "<cmd>Neotree focus filesystem left<cr>", desc = "Focus file tree" },
    { "<leader>gs", "<cmd>Neotree float git_status<cr>", desc = "Git status tree" },
  },
  opts = {
    close_if_last_window = true,
    filesystem = {
      follow_current_file = { enabled = true },
      filtered_items = {
        hide_dotfiles = false,
        hide_gitignored = false,
      },
      use_libuv_file_watcher = true,
    },
    window = {
      width = 32,
    },
  },
}
```

### Oil keymaps after Neo-tree

```lua
vim.keymap.set("n", "-", "<cmd>Oil<cr>", { desc = "Open parent directory" })
vim.keymap.set("n", "<leader>o", "<cmd>Oil --float<cr>", { desc = "Oil file operations" })
vim.keymap.set("n", "<leader>O", "<cmd>Oil<cr>", { desc = "Oil full window" })
```

### Formatting/lint additions

```lua
-- conform.nvim
formatters_by_ft = {
  sh = { "shfmt" },
  bash = { "shfmt" },
  zsh = { "shfmt" },
}

-- nvim-lint
lint.linters_by_ft = {
  sh = { "shellcheck" },
  bash = { "shellcheck" },
  markdown = { "markdownlint-cli2" },
}
```

## 9. Risk Notes

- The `mason-tool-installer` integration type error is a definite startup crash for `nvim-lspconfig` config.
- The which-key issue is a warning, not a crash.
- Migrating to `vim.lsp.config`/`vim.lsp.enable` changes LSP startup behavior. Test C/C++, Java, TS, Lua after the patch.
- `jdtls` must stay excluded from Mason auto-enable or it may conflict with `ftplugin/java.lua`.
- Duplicate plugin specs may merge unpredictably under lazy.nvim. They are not all crashes, but they make config behavior harder to reason about.
- `core/options.lua` has broad `vim.notify` filtering. This improves quietness but can hide useful warnings while debugging.
- Go currently has duplicate format/import-on-save logic in `lua/plugins/go.lua` and `ftplugin/go.lua`.
- C++ keymaps have likely collisions: `lua/plugins/cpp.lua` CMake uses `<leader>cr` for CMake run, while `ftplugin/cpp.lua` uses `<leader>cr` for compile-and-run current file.
- Neovide transparency plus Catppuccin pastel colors may reduce readability. If eye strain occurs, reduce transparency before judging a theme.
- Headless checks in the Codex sandbox were partially polluted by read/write restrictions on cache/state/parser paths. Normal Neovide startup should be verified directly after fixes.
