# Go Format Hook Dedup Report

Date: 2026-06-22

## Duplicate Hook Found

Go save-time formatting/import work was registered in multiple places:

- `ftplugin/go.lua` created two `BufWritePre` autocmds for `*.go`:
  - `require("go.format").goimport()`
  - LSP `source.organizeImports`
- `lua/plugins/go.lua` created two more `BufWritePre` autocmds for `*.go` in the `GoFormat` augroup:
  - `require("go.format").goimports()`
  - LSP `source.organizeImports`
- `lua/plugins/formatting.lua` already configured conform.nvim, but Go format-on-save was disabled there because go.nvim was handling Go formatting.

## Formatting Path Kept

Kept conform.nvim as the single Go save-time formatting path.

Current Go conform chain:

```lua
go = { "goimports", "gofumpt" }
```

This keeps import management and stricter Go formatting on one save path.

## Hook Removed Or Disabled

- Removed both Go `BufWritePre` autocmds from `ftplugin/go.lua`.
- Removed both Go `BufWritePre` autocmds from `lua/plugins/go.lua`.
- Set `go.nvim` `auto_format = false`.
- Enabled conform format-on-save for Go by removing the Go skip in `lua/plugins/formatting.lua`.

Go LSP remains configured in `lua/plugins/lsp.lua`.
go.nvim remains installed and available for Go commands/keymaps.

## Files Changed

- `ftplugin/go.lua`
- `lua/plugins/go.lua`
- `lua/plugins/formatting.lua`
- `docs/audit/GO_FORMAT_HOOK_DEDUP_REPORT.md`

Pre-existing unrelated working tree changes were present in `lua/plugins/lsp.lua` and `lua/plugins/treesitter.lua`; this cleanup did not edit them.

## Validation

Ran:

```sh
luac -p ftplugin/go.lua lua/plugins/go.lua lua/plugins/formatting.lua
nvim --headless "+checkhealth" "+qa"
nvim --headless "+Lazy! check" "+qa"
```

Results:

- `luac -p ...`: passed.
- `nvim --headless "+checkhealth" "+qa"`: passed with exit code 0 when rerun with normal Neovim state/cache/plugin directory access.
- `nvim --headless "+Lazy! check" "+qa"`: passed with exit code 0 when rerun with normal Neovim state/cache/plugin directory access.

Initial sandboxed runs also exited 0, but reported read-only filesystem noise for Neovim state/cache/plugin paths such as Shada, Mason, Treesitter parser, plugin `.git/FETCH_HEAD`, and plugin logs. Those were sandbox/environment artifacts, not Go formatting config errors.

## Remaining Risks

- conform.nvim now runs `goimports` then `gofumpt` on Go save. If a project expects import grouping behavior from gopls organize-imports specifically, this deliberately no longer runs as a separate save hook.
- `lua/plugins/lsp.lua` still has `gopls.settings.gopls.gofumpt = true`, which is LSP configuration, not a save autocmd.
