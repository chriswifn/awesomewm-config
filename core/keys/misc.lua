local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local misckeys = gtable.join(
   -- keybindings to control audio (both input and output)
   awful.key({ apps.modkey, "Mod1", }, "k", function() awful.spawn.with_shell("volume up") end,
      {description="volume", group="volume"}),
   awful.key({ apps.modkey, "Mod1", }, "j", function() awful.spawn.with_shell("volume down") end,
      {description="volume", group="volume"}),
   awful.key({ apps.modkey, "Mod1", }, "m", function() awful.spawn.with_shell("volume mute") end,
      {description="volume", group="volume"}),
   awful.key({ apps.modkey, "Mod1", "Control"}, "k", function() awful.spawn.with_shell("microphone up") end,
      {description="volume", group="volume"}),
   awful.key({ apps.modkey, "Mod1", "Control"}, "j", function() awful.spawn.with_shell("microphone down") end,
      {description="volume", group="volume"}),
   awful.key({ apps.modkey, "Mod1", "Control"}, "m", function() awful.spawn.with_shell("microphone mute") end,
      {description="volume", group="volume"}),

   -- keybindings to control brightness
   awful.key({ apps.modkey, "Mod1" }, "Up", function() awful.spawn.with_shell("brightnessctl set 100%") end,
      {description="brightness", group="brightness"}),
   awful.key({ apps.modkey, "Mod1" }, "Right", function() awful.spawn.with_shell("brightnessctl set 50%") end,
      {description="brightness", group="brightness"}),
   awful.key({ apps.modkey, "Mod1" }, "Left", function() awful.spawn.with_shell("brightnessctl set 10%") end,
      {description="brightness", group="brightness"}),
   awful.key({ apps.modkey, "Mod1" }, "Down", function() awful.spawn.with_shell("gamma") end,
      {description="brightness", group="brightness"})
)

return misckeys
