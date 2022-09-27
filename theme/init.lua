local beautiful = require("beautiful")
local gears = require("gears")
local awful = require("awful")

-- Selected theme
beautiful.init(string.format("%s/.config/awesome/theme/modus-vivendi/theme.lua", os.getenv("HOME")))


-- function to remove border in case of only 1 client on screen
function border_adjust(c)
   if c.maximized then 
      c.border_width = 0
   elseif #awful.screen.focused().clients > 1 then
      c.border_width = beautiful.border_width
      c.border_color = beautiful.border_focus
   end
end

client.connect_signal("focus", border_adjust)
client.connect_signal("property::maximized", border_adjust)
client.connect_signal("unfocus", function(c) c.border_color = beautiful.border_normal end)
