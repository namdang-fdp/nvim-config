# Mason Go Tooling Smoke Report

Date: 2026-06-22
Repo: `/home/dorriss-dev/.config/nvim`
Smoke project: `/tmp/nvim-go-smoke-test`

## Status

**Ready with minor fixes**

Neovim is ready for serious Go backend work: `gopls` attaches, Go save formatting works, Go imports/format/lint tools are installed, Delve is installed, and Treesitter now covers `go`, `gomod`, `gowork`, and `gosum`.

The main remaining issue is shell `PATH`: the current shell cannot find the Go tools directly until Mason and Go bin directories are added.

## Health Summary

### Mason

- `nvim --headless "+checkhealth" "+qa"` exited `0`.
- Mason health is usable for Go.
- Mason warning: installed `mason.nvim` is `v2.3.0`; latest reported by health is `v2.3.1`.
- Mason optional runtime warnings: `cargo`, `luarocks`, `ruby`, `gem`, `composer`, `php`, and `julia` are not on `PATH`. These are not blockers for Go.
- Mason log contains duplicate registry warnings for `github:mason-org/mason-registry` and `github:mason-org/mason-system-registry`; no Go install failure was observed.

### Lazy

- `nvim --headless "+Lazy! check" "+qa"` exited `0`.
- Lazy check contacted plugin remotes and reported available upstream logs/status.
- `lazy-lock.json` was not changed.
- Health warning: Lazy's local hererocks/luarocks path is missing. No current plugin requires luarocks, so this is not a Go blocker.

## Installed Tools

Installed through Mason and available under `~/.local/share/nvim/mason/bin`:

- `gopls` v0.22.0
- `dlv` / Delve v1.26.3
- `gofumpt` v0.10.0
- `goimports` v0.46.0
- `staticcheck` 2026.1 / v0.7.0
- `golangci-lint` v2.12.2

Fallback binaries were also installed with `go install` under `~/go/bin`.

## Missing Tools

None after remediation.

Before remediation, Mason was missing:

- `delve`
- `staticcheck`

Before PATH remediation, the shell could not resolve:

- `gopls`
- `dlv`
- `gofumpt`
- `goimports`
- `staticcheck`
- `golangci-lint`

## Installation Actions Performed

- Ran Mason install:
  `nvim --headless "+MasonInstall gopls delve gofumpt goimports staticcheck golangci-lint" "+qa"`
- Ran fallback `go install` commands for all requested tools because they were not visible on shell `PATH`.
- Installed Treesitter `gowork` parser:
  `nvim --headless "+TSInstallSync gowork" "+qa"`
- Updated config minimally:
  - Added `delve` and `staticcheck` to Mason `ensure_installed` in `lua/plugins/lsp.lua`.
  - Added `gowork` to Treesitter `ensure_installed` in `lua/plugins/treesitter.lua`.

## PATH Issue

Current shell `PATH` does not include:

- `/home/dorriss-dev/.local/share/nvim/mason/bin`
- `/home/dorriss-dev/go/bin`

Add this line to your shell config, for example `~/.bashrc`:

```sh
export PATH="$HOME/.local/share/nvim/mason/bin:$HOME/go/bin:$PATH"
```

After that, a normal shell should resolve `gopls`, `dlv`, `gofumpt`, `goimports`, `staticcheck`, and `golangci-lint`.

## Go LSP Status

- `gopls` is configured in `lua/plugins/lsp.lua`.
- `gopls` settings include:
  - `gofumpt = true`
  - `staticcheck = true`
  - `analyses.unusedparams = true`
- Headless smoke test opened `/tmp/nvim-go-smoke-test/main.go`.
- `gopls` attached successfully to the Go buffer.

## Format, Lint, And DAP Readiness

- Format on save works for Go. The smoke test intentionally saved badly formatted code through headless Neovim, and the file was corrected.
- `gofumpt -l .` returned clean.
- `goimports -l .` returned clean.
- `go test ./...` passed.
- `staticcheck ./...` passed.
- `golangci-lint run ./...` passed with `0 issues`.
- Delve is installed and available as `dlv`.
- Go debugging is exposed through `go.nvim` keymaps such as `<leader>gdb` / `:GoDebug`. The general `nvim-dap` plugin exists, but its explicit config is currently C/C++-oriented and filetype-gated.

## Config Risks Found

- `ftplugin/go.lua` and `lua/plugins/go.lua` both register Go save autocmds for imports/organize-imports. It works in the smoke test, but duplicate save hooks can cause redundant work or edge-case conflicts.
- `nvim-lint` does not currently register Go linters. Go linting is still covered by `gopls` staticcheck plus external `staticcheck` and `golangci-lint`.
- Shell `PATH` needs the export above for direct CLI use outside Neovim.
- Lazy health reports hererocks/luarocks missing. Not a Go blocker.
- Mason health reports optional runtime/toolchain warnings for non-Go ecosystems. Not a Go blocker.

## Exact Next Steps

1. Add the PATH export line to your shell config and restart the shell.
2. Run:
   `gopls version && dlv version && gofumpt -version && staticcheck -version && golangci-lint --version`
3. For CenterOS Go repos, add a project-level `.golangci.yml` when the new gateway service starts to stabilize.
4. Later cleanup: deduplicate the Go save autocmds and optionally add Go to `nvim-lint` if you want editor-triggered `golangci-lint` diagnostics.
