-- ============================================
-- NEOVIDE GUI SETTINGS
-- ============================================
if not vim.g.neovide then
	return
end

-- ==================== FONTS ====================
-- Option 1: JetBrains Mono (recommended - đẹp, rõ ràng)
vim.o.guifont = "JetBrainsMono Nerd Font:h16"

-- Option 2: Fira Code (có ligatures đẹp: -> => != >=)
-- vim.o.guifont = "FiraCode Nerd Font:h16"

-- Option 3: Cascadia Code (của Microsoft, rất đẹp)
-- vim.o.guifont = "CaskaydiaCove Nerd Font:h16"

-- Option 4: Iosevka (modern, mỏng)
-- vim.o.guifont = "Iosevka Nerd Font:h16"

-- Option 5: Victor Mono (có italic đẹp như chữ viết tay)
-- vim.o.guifont = "VictorMono Nerd Font:h16"

-- Option 6: Maple Mono (font cũ của anh)
-- vim.o.guifont = "Maple Mono NF:h16"

-- ==================== SPACING ====================
-- Tăng khoảng cách giữa các dòng (line spacing)
vim.opt.linespace = 8 -- Default: 0, thử 2-8

-- Tăng khoảng cách giữa các ký tự (character spacing)
-- Neovide không hỗ trợ trực tiếp, nhưng có thể dùng font với spacing tự nhiên rộng hơn

-- ==================== CURSOR ANIMATIONS ====================
vim.g.neovide_cursor_animation_length = 0.13 -- Nhanh hơn = mượt hơn
vim.g.neovide_cursor_trail_size = 0.8

-- ==================== CURSOR VFX ====================
-- Các option VFX mode:
-- "railgun"    - Đạn laser khi di chuyển cursor (COOL!)
-- "torpedo"    - Như tên lửa
-- "pixiedust"  - Bụi lấp lánh (hiện tại)
-- "sonicboom"  - Sóng âm thanh
-- "ripple"     - Gợn sóng nước
-- "wireframe"  - Khung lưới 3D (ĐỈNH!)

vim.g.neovide_cursor_vfx_mode = "pixiedust" -- Thử cái này!
vim.g.neovide_cursor_vfx_opacity = 200.0
vim.g.neovide_cursor_vfx_particle_lifetime = 1.2
vim.g.neovide_cursor_vfx_particle_density = 7.0

-- ==================== SCROLL ANIMATION ====================
vim.g.neovide_scroll_animation_length = 0.3 -- Mượt hơn
vim.g.neovide_scroll_animation_far_lines = 1

-- ==================== TRANSPARENCY & BLUR ====================
vim.g.neovide_opacity = 0.85 -- Tăng opacity lên cho đỡ mờ
vim.g.neovide_window_blurred = true
vim.g.neovide_floating_blur_amount_x = 2.0 -- Giảm blur
vim.g.neovide_floating_blur_amount_y = 2.0
vim.g.neovide_floating_shadow = true
vim.g.neovide_floating_z_height = 10
vim.g.neovide_light_angle_degrees = 45
vim.g.neovide_light_radius = 5

-- ==================== PERFORMANCE ====================
vim.g.neovide_refresh_rate = 60
vim.g.neovide_refresh_rate_idle = 5
vim.g.neovide_remember_window_size = true
vim.g.neovide_fullscreen = false

-- ==================== PADDING ====================
vim.g.neovide_padding_top = 10 -- Tăng padding
vim.g.neovide_padding_bottom = 10
vim.g.neovide_padding_right = 15
vim.g.neovide_padding_left = 15

-- ==================== ADDITIONAL SETTINGS ====================
vim.g.neovide_hide_mouse_when_typing = true
vim.g.neovide_confirm_quit = true
vim.g.neovide_input_macos_alt_is_meta = true

-- ==================== CURSOR PARTICLES ====================
vim.g.neovide_cursor_animate_in_insert_mode = true
vim.g.neovide_cursor_animate_command_line = true
vim.g.neovide_cursor_unfocused_outline_width = 0.125

-- ==================== ANTIALIASING ====================
vim.g.neovide_cursor_antialiasing = true
vim.g.neovide_cursor_smooth_blink = true

-- ==================== MỚI - CỰC COOL ====================
-- Position animation length
vim.g.neovide_position_animation_length = 0.15

-- Scroll animation length
vim.g.neovide_scroll_animation_length = 0.3

-- Hiding the mouse when typing
vim.g.neovide_hide_mouse_when_typing = true

-- Underline automatic scaling
vim.g.neovide_underline_automatic_scaling = false

-- Theme (light/dark/auto)
vim.g.neovide_theme = "auto"

-- Scale factor (zoom in/out toàn bộ UI)
vim.g.neovide_scale_factor = 1.0

-- Keybinding để zoom in/out
vim.keymap.set("n", "<C-=>", function()
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor + 0.1
end)
vim.keymap.set("n", "<C-->", function()
	vim.g.neovide_scale_factor = vim.g.neovide_scale_factor - 0.1
end)
vim.keymap.set("n", "<C-0>", function()
	vim.g.neovide_scale_factor = 1.0
end)
