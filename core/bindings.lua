-- standard awesome library
local awful = require("awful")
local gears = require("gears")
local beautiful = require("beautiful")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
-- variables for certain applications
local apps = require("core.apps")
require("awful.autofocus")

-- modkey should be super
local modkey = "Mod4"

-- actual keybindings
globalkeys = gears.table.join(

   -- keybindings to toggle widgets in wibar
   awful.key( {modkey}, "b", function()
         local grabber
         grabber =
            awful.keygrabber.run(
               function(_, key, event)
                  if event == "release" then return end
                  if key == "s" then awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
                  end
                  awful.keygrabber.stop(grabber)
               end
            )
   end,
      {description = "followed by RET", group="Bar"}
   ),

   -- emacs
   awful.key ( {modkey}, "e", function()
	 local grabber
	 grabber =
	    awful.keygrabber.run(
	       function(_, key, event)
		  if event == "release" then return end
		  if key == "e" then awful.spawn.with_shell(apps.editor)
		  elseif key == "b" then awful.spawn.with_shell(apps.editor .. "--eval '(ibuffer)'")
		  elseif key == "d" then awful.spawn.with_shell(apps.editor .. "--eval '(dired nil)'")
		  end
		  awful.keygrabber.stop(grabber)
	       end
	    )
   end,
      {description = "followed by KEY", group="Emacs"}
   ),

   -- terminal applications
   awful.key ( {modkey}, "t", function()
	 local grabber
	 grabber =
	    awful.keygrabber.run(
	       function(_, key, event)
		  if event == "release" then return end
		  if key == "t" then awful.spawn.with_shell(apps.terminal .. "-c 'dev' -e tmux")
		  elseif key == "n" then awful.spawn.with_shell(apps.terminal .. "-c 'nvim' -e nvim")
		  elseif key == "h" then awful.spawn.with_shell(apps.terminal .. "-e htop")
		  elseif key == "a" then awful.spawn.with_shell(apps.terminal .. "-c 'mus' -e cmus")
		  elseif key == "r" then awful.spawn.with_shell(apps.terminal .. "-c 'file' -e ranger")
		  elseif key == "p" then awful.spawn.with_shell(apps.terminal .. "-e pulsemixer")
		  end
		  awful.keygrabber.stop(grabber)
	       end
	    )
   end,
      {description = "followed by KEY", group="Terminal"}
   ),

   -- dmenu scripts
   awful.key ( {modkey}, "p", function()
	 local grabber
	 grabber =
	    awful.keygrabber.run(
	       function(_, key, event)
		  if event == "release" then return end
		  if key == "a" then awful.spawn.with_shell("dmenu_run -l 10")
		  elseif key == "m" then awful.spawn.with_shell("monitors")
		  elseif key == "b" then awful.spawn.with_shell("bookmarks")
		  elseif key == "k" then awful.spawn.with_shell("keyboard")
		  elseif key == "s" then awful.spawn.with_shell("maimmenu")
		  elseif key == "i" then awful.spawn.with_shell("network")
		  elseif key == "l" then awful.spawn.with_shell("logoutmenu")
		  elseif key == "p" then awful.spawn.with_shell("passmenu -l 10 -p 'Choose password: '")
		  elseif key == "w" then awful.spawn.with_shell("connectwifi")
		  elseif key == "e" then awful.spawn.with_shell("emojipicker")
		  elseif key == "v" then awful.spawn.with_shell("audiodevice")
		  elseif key == "c" then awful.spawn.with_shell("audioinputdevice")
		  elseif key == "t" then awful.spawn.with_shell("touchpad")
		  end
		  awful.keygrabber.stop(grabber)
	       end
	    )
   end,
      {description = "followed by KEY", group="Terminal"}
   ),


   -- scripts to control audio (both input and output), brightness and a night mode
   awful.key({ modkey,           }, "F1", function() awful.spawn.with_shell("volume mute") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F2", function() awful.spawn.with_shell("volume down") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F3", function() awful.spawn.with_shell("volume up") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F4", function() awful.spawn.with_shell("microphone mute") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F5", function() awful.spawn.with_shell("microphone down") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F6", function() awful.spawn.with_shell("microphone up") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F7", function() awful.spawn.with_shell("brightness down") end,
      {description="volume", group="volume"}),
   
   awful.key({ modkey,           }, "F8", function() awful.spawn.with_shell("brightness up") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "F9", function() awful.spawn.with_shell("gamma") end,
      {description="volume", group="volume"}),


   -- gui applications
   awful.key({ modkey,           }, "g", function() awful.spawn.with_shell("firefox") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "z", function() awful.spawn.with_shell("zathura") end,
      {description="volume", group="volume"}),

   awful.key({ modkey, "Shift"   }, "f", function() awful.spawn.with_shell("pcmanfm") end,
      {description="volume", group="volume"}),

   awful.key({ modkey,           }, "v", function() awful.spawn.with_shell("virt-manager") end,
      {description="volume", group="volume"}),

   awful.key({ modkey, "Shift"   }, "s", function() awful.spawn.with_shell("slock") end,
      {description="volume", group="volume"}),


   -- awesome specific keybindings
   awful.key({ modkey,           }, "s",      hotkeys_popup.show_help,
      {description="show help", group="awesome"}),
   awful.key({ modkey,           }, "Left",   awful.tag.viewprev,
      {description = "view previous", group = "tag"}),
   awful.key({ modkey,           }, "Right",  awful.tag.viewnext,
      {description = "view next", group = "tag"}),
   awful.key({ modkey,           }, "Escape", awful.tag.history.restore,
      {description = "go back", group = "tag"}),
   awful.key({ modkey,           }, "j",
      function ()
         awful.client.focus.byidx( 1)
      end,
      {description = "focus next by index", group = "client"}
   ),
   awful.key({ modkey,           }, "k",
      function ()
         awful.client.focus.byidx(-1)
      end,
      {description = "focus previous by index", group = "client"}
   ),
   awful.key({ modkey, "Shift"   }, "j", function () awful.client.swap.byidx(  1)    end,
      {description = "swap with next client by index", group = "client"}),
   awful.key({ modkey, "Shift"   }, "k", function () awful.client.swap.byidx( -1)    end,
      {description = "swap with previous client by index", group = "client"}),
   awful.key({ modkey, "Control" }, "j", function () awful.screen.focus_relative( 1) end,
      {description = "focus the next screen", group = "screen"}),
   awful.key({ modkey, "Control" }, "k", function () awful.screen.focus_relative(-1) end,
      {description = "focus the previous screen", group = "screen"}),
   awful.key({ modkey,           }, "u", awful.client.urgent.jumpto,
      {description = "jump to urgent client", group = "client"}),
   awful.key({ modkey,           }, "Tab",
      function ()
         awful.client.focus.history.previous()
         if client.focus then
            client.focus:raise()
         end
      end,
      {description = "go back", group = "client"}),
   awful.key({ modkey, "Shift"   }, "Return", function () awful.spawn(apps.terminal) end,
      {description = "open a terminal", group = "launcher"}),
   awful.key({ modkey, "Control" }, "r", awesome.restart,
      {description = "reload awesome", group = "awesome"}),
   awful.key({ modkey, "Shift"   }, "q", awesome.quit,
      {description = "quit awesome", group = "awesome"}),
   awful.key({ modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
      {description = "increase master width factor", group = "layout"}),
   awful.key({ modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
      {description = "decrease master width factor", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "h",     function () awful.tag.incnmaster( 1, nil, true) end,
      {description = "increase the number of master clients", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "l",     function () awful.tag.incnmaster(-1, nil, true) end,
      {description = "decrease the number of master clients", group = "layout"}),
   awful.key({ modkey, "Control" }, "h",     function () awful.tag.incncol( 1, nil, true)    end,
      {description = "increase the number of columns", group = "layout"}),
   awful.key({ modkey, "Control" }, "l",     function () awful.tag.incncol(-1, nil, true)    end,
      {description = "decrease the number of columns", group = "layout"}),
   awful.key({ modkey,           }, "space", function () awful.layout.inc( 1)                end,
      {description = "select next", group = "layout"}),
   awful.key({ modkey, "Shift"   }, "space", function () awful.layout.inc(-1)                end,
      {description = "select previous", group = "layout"}),
   awful.key({ modkey, "Control" }, "n",
      function ()
         local c = awful.client.restore()
         if c then
            c:emit_signal(
               "request::activate", "key.unminimize", {raise = true}
            )
         end
      end,
      {description = "restore minimized", group = "client"}),
   awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn("dmenu_run -l 10") end,
      {description = "run prompt", group = "launcher"})
)

clientkeys = gears.table.join(
   awful.key({ modkey,           }, "f",
      function (c)
         c.fullscreen = not c.fullscreen
         c:raise()
      end,
      {description = "toggle fullscreen", group = "client"}),
   awful.key({ modkey, "Shift"   }, "c",      function (c) c:kill()                         end,
      {description = "close", group = "client"}),
   awful.key({ modkey, "Control" }, "space",  awful.client.floating.toggle                     ,
      {description = "toggle floating", group = "client"}),
   awful.key({ modkey, "Control", "Shift" }, "Return", function (c) c:swap(awful.client.getmaster()) end,
      {description = "move to master", group = "client"}),
   awful.key({ modkey,           }, "o",      function (c) c:move_to_screen()               end,
      {description = "move to screen", group = "client"}),
   awful.key({ modkey,           }, "t",      function (c) c.ontop = not c.ontop            end,
      {description = "toggle keep on top", group = "client"}),

   awful.key({ modkey, "Shift" },   "y", awful.placement.centered),
   awful.key({ modkey,           }, "n",
      function (c)
         c.minimized = true
      end ,
      {description = "minimize", group = "client"}),
   awful.key({ modkey,           }, "m",
      function (c)
         c.maximized = not c.maximized
         c:raise()
      end ,
      {description = "(un)maximize", group = "client"}),
   awful.key({ modkey, "Control" }, "s",
      function (c)
         c.sticky = not c.sticky
      end ,
      {description = "(un)sticky", group = "client"}),
   awful.key({ modkey, "Control" }, "m",
      function (c)
         c.maximized_vertical = not c.maximized_vertical
         c:raise()
      end ,
      {description = "(un)maximize vertically", group = "client"}),
   awful.key({ modkey, "Shift"   }, "m",
      function (c)
         c.maximized_horizontal = not c.maximized_horizontal
         c:raise()
      end ,
      {description = "(un)maximize horizontally", group = "client"})
)

for i = 1, 9 do
   globalkeys = gears.table.join(globalkeys,
                                 awful.key({ modkey }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          tag:view_only()
                                       end
                                    end,
                                    {description = "view tag #"..i, group = "tag"}),
                                 awful.key({ modkey, "Control" }, "#" .. i + 9,
                                    function ()
                                       local screen = awful.screen.focused()
                                       local tag = screen.tags[i]
                                       if tag then
                                          awful.tag.viewtoggle(tag)
                                       end
                                    end,
                                    {description = "toggle tag #" .. i, group = "tag"}),
                                 awful.key({ modkey, "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:move_to_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "move focused client to tag #"..i, group = "tag"}),
                                 awful.key({ modkey, "Control", "Shift" }, "#" .. i + 9,
                                    function ()
                                       if client.focus then
                                          local tag = client.focus.screen.tags[i]
                                          if tag then
                                             client.focus:toggle_tag(tag)
                                          end
                                       end
                                    end,
                                    {description = "toggle focused client on tag #" .. i, group = "tag"})
   )
end

clientbuttons = gears.table.join(
   awful.button({ }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
   end),
   awful.button({ modkey }, 1, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.move(c)
   end),
   awful.button({ modkey }, 3, function (c)
         c:emit_signal("request::activate", "mouse_click", {raise = true})
         awful.mouse.client.resize(c)
   end)
)

root.keys(globalkeys)
