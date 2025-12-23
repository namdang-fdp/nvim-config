-- ============================================
-- NEOVIDE GUI SETTINGS
-- ============================================

if not vim.g.neovide then
	return
end

-- Font
vim.o.guifont = "CaskaydiaCove Nerd Font Mono:h17"

-- Cursor animations
vim.g.neovide_cursor_animation_length = 0.18
vim.g.neovide_cursor_trail_size = 0.9

-- Cursor VFX
vim.g.neovide_cursor_vfx_mode = "pixiedust"
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0

-- Scroll animation
vim.g.neovide_scroll_animation_length = 0.5
vim.g.neovide_scroll_animation_far_lines = 1

-- Transparency
vim.g.neovide_opacity = 0.5
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 4.0
vim.g.neovide_floating_blur_amount_y = 4.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- Performance
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false

-- Padding
vim.g.neovide_padding_top = 5
vim.g.neovide_padding_bottom = 5
vim.g.neovide_padding_right = 5
vim.g.neovide_padding_left = 5

-- Additional settings
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_input_macos_alt_is_meta = true

-- Cursor particles
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- Antialiasing
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_smooth_blink = true
