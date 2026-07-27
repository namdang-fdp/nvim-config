# Neovim configuration

Custom, modular Neovim configuration for full-stack development. Normal startup
does not install or update language servers, formatters, linters, or debuggers.

## Development tools

Run the explicit command below when you want Mason and Treesitter to install the
approved tool set:

```vim
:DevToolsSync
```

## Java and Lombok

JDTLS uses the system `java` executable and expects Java 21 for current Spring
Boot projects. Lombok support is optional. The stable local Lombok agent path is:

```text
~/.local/share/nvim/lombok/lombok.jar
```

That path may be a symlink to a versioned JAR, for example
`lombok-1.18.46.jar`. The Java filetype configuration expands the home-relative
path and verifies that it is readable before adding `-javaagent`. If the JAR is
missing, Neovim reports a warning and starts JDTLS without Lombok instead of
disabling Java language support.
