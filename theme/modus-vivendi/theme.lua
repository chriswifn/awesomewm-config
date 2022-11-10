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

-- background colors
theme.bg_normal     = "#1e1e1e"
theme.bg_focus      = "#323232"
theme.bg_urgent     = "#ff8059"
theme.bg_minimize   = "#100f10"
theme.bg_systray    = theme.bg_normal

-- foreground colors
theme.fg_normal     = "#bfc0c4"
theme.fg_focus      = "#f4f4f4"
theme.fg_urgent     = "#ff8059"
theme.fg_minimize   = "#bfc0c4"

-- gaps and border options
theme.useless_gap   = dpi(2)
theme.border_width  = dpi(1)
theme.border_normal = "#323232"
theme.border_focus  = "#f78fe7"
theme.border_marked = "#ff8059"
theme.taglist_spacing = 8 

-- Generate taglist squares:

-- no stupid icons
theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
