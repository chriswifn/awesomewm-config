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
     properties = { tag = "*1:WWW*", switchtotag = true } },

   { rule = { class = "st" },
     properties = { tag = "*3:TERM*", switchtotag = true } },

   { rule = { class = "Alacritty" },
     properties = { tag = "*3:TERM*", switchtotag = true } },

   { rule = { class = "Emacs"},
     properties = { tag = "*2:EMACS*", switchtotag = true } },

   { rule = { class = "Zathura"},
     properties = { tag = "*6:DOC*", switchtotag = true } },

   { rule = { class = "mpv"},
     properties = { tag = "*8:VID*", switchtotag = true } },

   { rule = { class = "mus"},
     properties = { tag = "*7:MUS*", switchtotag = true } },

   { rule = { class = "Virt-manager"},
     properties = { tag = "*9:VIRT*", switchtotag = true } },

   { rule_any = { class = { "file", "Pcmanfm" } },
     properties = { tag = "*4:FILE*", switchtotag = true } },

   { rule_any = { class = { "nvim", "dev" } },
     properties = { tag = "*5:NVIM*", switchtotag = true } },

   { rule_any = {
        instance = {
           "copyq",
        },
        class = {
           "Sxiv",
           "Tor Browser",
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
