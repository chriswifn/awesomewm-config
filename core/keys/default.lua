local gtable = require("gears.table")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("core.apps")

local defaultkeys = gtable.join(
   -- awesome specific keybindings
   awful.key({ apps.modkey,           }, "s",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ apps.modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ apps.modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ apps.modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),
   awful.key({ apps.modkey,           }, "j",
      function ()
	 awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ apps.modkey,           }, "k",
      function ()
	 awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   awful.key({ apps.modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ apps.modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ apps.modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ apps.modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ apps.modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   awful.key({ apps.modkey,           }, "Tab",
      function ()
	 awful.client.focus.history.previous()
	 if client.focus then
	    client.focus:raise()
	 end
      end,
      {description = "go back", group = "client"}),
   awful.key({ apps.modkey, "Shift"   }, "Return", function () awful.spawn(apps.terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ apps.modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ apps.modkey, "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),
   awful.key({ apps.modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ apps.modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ apps.modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ apps.modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ apps.modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ apps.modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ apps.modkey,           }, "space", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   awful.key({ apps.modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
      {description = "select previous", group = "layout"}),
   awful.key({ apps.modkey, "Control" }, "n",
      function ()
	 local c = awful.client.restore()
	 if c then
	    c:emit_signal(
	       "request::activate", "key.unminimize", {raise = true}
	    )
	 end
      end,
      {description = "restore minimized", group = "client"}),
   awful.key({ apps.modkey, "Control" }, "Return", function () awful.util.spawn("dmenu_run -l 10") end,
      {description = "run prompt", group = "launcher"})
)

return defaultkeys
