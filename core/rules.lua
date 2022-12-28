-- standard awesome library
local awful = require("awful")
-- theme library
local beautiful = require("beautiful")

-- some window rules
-- * spawn programs on specific workspaces
-- * floating
-- * center stuff
-- * make clients sticky
awful.rules.rules = {
   { rule = { },
     properties = { border_width = beautiful.border_width,
                    border_color = beautiful.border_normal,
                    focus = awful.client.focus.filter,
                    raise = true,
                    keys = clientkeys,
                    buttons = clientbuttons,
                    screen = awful.screen.preferred,
                    placement = awful.placement.no_overlap+awful.placement.no_offscreen,
                    size_hints_honor = false,
                    swallow = true
     }
   },

   { rule = { class = "firefox" },
     properties = { tag = "1", switchtotag = true } },

   { rule_any = {
        instance = {
           "copyq",
        },
        class = {
           "Sxiv",
           "Tor Browser",
	   "MATLAB R2022b - academic use",
        },
        name = {
           "bash",
           "Save File"
        },
        role = {
           "pop-up",
        }
   }, properties = { floating = true, placement = "centered", tag = false}},

   { rule_any = {type = { "normal", "dialog" }
                }, properties = { titlebars_enabled = false }
   },
}
