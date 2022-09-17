--------------------------------------------------
-- gruvbox theme
--------------------------------------------------

-- some imports that are necessary
local theme_assets = require("beautiful.theme_assets")
local xresources = require("beautiful.xresources")
local dpi = xresources.apply_dpi
local gfs = require("gears.filesystem")
local themes_path = gfs.get_themes_dir()
local configuration_path = gfs.get_configuration_dir()

-- generate table for options
local theme = {}

-- font (the bar)
theme.font          = "JetBrains Mono 12"
-- font (taglist)
theme.taglist_font  = "JetBrains Mono 12"

-- background colors
theme.bg_normal     = "#1d2021"
theme.bg_focus      = "#282828"
theme.bg_urgent     = "#cc241d"
theme.bg_minimize   = "#3c3836"
theme.bg_systray    = theme.bg_normal

-- foreground colors
theme.fg_normal     = "#fbf1c7"
theme.focus         = "#fbf1c7"
theme.fg_urgent     = "#cc241d"
theme.fg_minimize   = "#fbf1c7"

-- layout "icons"
theme.layout_txt_tile = "[]="
theme.layout_txt_max= "[M]"
theme.layout_txt_floating= "[F]"

-- gaps and border options
theme.useless_gap   = dpi(0)
theme.border_width  = dpi(0)
theme.border_normal = "#1d2021"
theme.border_focus  = "#cc241d"
theme.border_marked = "#cc241d"
theme.taglist_spacing = 8 

-- Generate taglist squares:
local taglist_square_size = dpi(4)
theme.taglist_squares_sel = theme_assets.taglist_squares_sel(
    taglist_square_size, theme.fg_normal
)
theme.taglist_squares_unsel = theme_assets.taglist_squares_unsel(
    taglist_square_size, theme.fg_normal
)

theme.icon_theme = nil

return theme

-- vim: filetype=lua:expandtab:shiftwidth=4:tabstop=8:softtabstop=4:textwidth=80
