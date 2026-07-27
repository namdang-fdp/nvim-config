if not vim.g.neovide then
	return
end

-- Typography and layout
vim.o.guifont = "Maple Mono NF:h16"
vim.opt.linespace = 6
vim.g.neovide_padding_top = 10
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_left = 15
vim.g.neovide_padding_right = 15

-- Moderate transparency keeps the blue wallpaper visible without sacrificing
-- contrast against the warm graphite Kanagawa palette.
vim.g.neovide_opacity = 0.94
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 1.5
vim.g.neovide_floating_blur_amount_y = 1.5
vim.g.neovide_floating_shadow = true

-- Restrained motion: cursor trail and scrolling stay smooth, particle VFX do not
-- compete with code or diagnostics.
vim.g.neovide_cursor_animation_length = 0.10
vim.g.neovide_cursor_trail_size = 0.55
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_scroll_animation_length = 0.22
vim.g.neovide_scroll_animation_far_lines = 1
vim.g.neovide_position_animation_length = 0.10

vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_remember_window_size = true
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_theme = "dark"
vim.g.neovide_scale_factor = 1.0

vim.keymap.set("n", "<leader>u=", function()
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end, { desc = "Neovide zoom in" })

vim.keymap.set("n", "<leader>u-", function()
	vim.g.neovide_scale_factor = math.max(0.5, vim.g.neovide_scale_factor - 0.1)
end, { desc = "Neovide zoom out" })

vim.keymap.set("n", "<leader>u0", function()
	vim.g.neovide_scale_factor = 1.0
end, { desc = "Neovide reset zoom" })
