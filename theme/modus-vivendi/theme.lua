--------------------------------------------------
-- modus vivendi theme (originally an emacs theme)
--------------------------------------------------

--  some imports that are necessary
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local configuration_path = gfs.get_configuration_dir()

-- generate table for options
local theme = {}

-- font
theme.font = "Monoid 9"
theme.tasklist_disable_icon = true

-- background colors
theme.bg_normal     = "#000000"
theme.bg_focus      = "#323232"
theme.bg_urgent     = "#ff8059"
theme.bg_minimize   = "#595959"
theme.bg_systray    = theme.bg_normal

-- foreground colors
theme.fg_normal     = "#ffffff"
theme.fg_focus      = "#ffffff"
theme.fg_urgent     = "#000000"
theme.fg_minimize   = "#ffffff"

-- gaps and border options
theme.useless_gap   = dpi(0)
theme.gap_single_client = false
theme.border_width  = dpi(5)
theme.border_normal = "#000000"
theme.border_focus  = "#feacd0"
theme.border_marked = "#ff8059"
theme.taglist_spacing = 8 

-- Generate taglist squares:

-- no stupid icons
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
