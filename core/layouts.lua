-- standard awesome library
local awful = require("awful")
local gears = require("gears")
-- Theme handling library
local beautiful = require("beautiful")

-- draws the wallpaper (a black screen)
local function set_wallpaper(s)
   gears.wallpaper.set("#000000")
end

awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.max,
}

screen.connect_signal("property::geometry", set_wallpaper)

awful.screen.connect_for_each_screen(function(s)
      -- set the wallpaper
      set_wallpaper(s)
      -- tag declaration
      awful.tag({ "1", "2", "3", "4", "5", "6", "7", "8", "9" },
	 s,
	 {awful.layout.layouts[2],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[1],
	  awful.layout.layouts[2],
      })
end)
