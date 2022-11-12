local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local clientkeys = gtable.join(
   awful.key({ apps.modkey,           }, "f",
      function (c)
	 c.fullscreen = not c.fullscreen
	 c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ apps.modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ apps.modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ apps.modkey, "Control", "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ apps.modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ apps.modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top", group = "client"}),

   awful.key({ apps.modkey, "Shift" },   "y", awful.placement.centered),
   awful.key({ apps.modkey,           }, "n",
      function (c)
         c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ apps.modkey,           }, "m",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
   awful.key({ apps.modkey, "Control" }, "s",
      function (c)
         c.sticky = not c.sticky
      end ,
      {description = "(un)sticky", group = "client"}),
   awful.key({ apps.modkey, "Control" }, "m",
      function (c)
         c.maximized_vertical = not c.maximized_vertical
         c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
   awful.key({ apps.modkey, "Shift"   }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"})
)

return clientkeys
