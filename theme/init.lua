local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")
local io = require("io")

-- configure naughty to be in the center at the top
local naughty = require("naughty")
local nconf = naughty.config
nconf.defaults.position = "top_middle"

-- active_theme = "modus-vivendi"
local handle = assert(io.open(
			string.format("%s/.config/awesome/theme/local_theme",
				      os.getenv("HOME"))))
local active_theme = string.gsub(assert(handle:read("*a")), "\n", "")
handle:close()

-- Selected theme
beautiful.init(string.format("%s/.config/awesome/theme/".. active_theme .. "/theme.lua", os.getenv("HOME")))

-- remove border from single clients and max layout
screen.connect_signal("arrange", function (s)
			local max = s.selected_tag.layout.name == "max"
			local only_one = #s.tiled_clients == 1 -- use tiled_clients so that other floating windows don't affect the count
			-- but iterate over clients instead of tiled_clients as tiled_clients doesn't include maximized windows
			for _, c in pairs(s.clients) do
			  if (max or only_one) and not c.floating or c.maximized then
			    c.border_width = 0
			  else
			    c.border_width = beautiful.border_width
			  end
			end
end)

client.connect_signal("focus", function(c) c.border_color = beautiful.border_focus end)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
