-- standard awesome library
local awful = require("awful")
local gears = require("gears")
local hotkeys_popup = require("awful.hotkeys_popup")
require("awful.hotkeys_popup.keys")
-- variables for certain applications
local apps = require("core.apps")
require("awful.autofocus")

-- modkey should be super
local modkey = "Mod4"

-- dwm functionality of showing all tags at once
-- saves the current tag you're on and restores it by hitting keybinding again
-- maped to Super + 0
local state = false
function toggle_view_all_tags()
    local screen = awful.screen.focused()
    if (state == false)
        then
            current_tag = awful.screen.focused().selected_tags
            for i = 1,9 do
                local tag = screen.tags[i]
                if #tag:clients() > 0
                    then
                        tag.selected = true
                    end
            end
            awful.layout.set(awful.layout.suit.tile)
            state = true
        else
            state = false
            awful.layout.set(awful.layout.suit.tile)
            for i = 1,9 do
               local tag = screen.tags[i]
               for _, v in ipairs(current_tag) do
                  if tag == v then
                     tag.selected = true 
                  else
                     tag.selected = false 
                  end
               end
            end
        end
end

-- move client to other screen while preserving tag
move_client_to_screen = function(c, s)
	function avoid_showing_empty_tag_client_move(c)
		-- Get the current tag.
		local t = c.first_tag or awful.screen.focused().selected_tag
		-- Cycle through all clients on the current tag. If there are 2 or greater clients on the current tag then leave function.
		for _, cl in ipairs(t:clients()) do
			if cl ~= c then
				return
			end
		end
		-- This step is only run if there is one client on the current tag.
		-- Cycle through all tags on the current screen. We must skip the current tag. We then move to the lowest index tag with one or more clients on it.
		for _, tg in ipairs(awful.screen.focused().tags) do
			if tg ~= t then
				if #tg:clients() > 0 then
					tg:view_only()
					break
				end
			end
		end
	end
	avoid_showing_empty_tag_client_move(c)
	-- Move to new screen but also keep it on the same tag index.
	local index = c.first_tag.index
	c:move_to_screen(s)
	local tag = c.screen.tags[index]
	c:move_to_tag(tag)
	tag:view_only()
end

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
        elseif key == "b" then awful.screen.focused().battery.visible = not awful.screen.focused().battery.visible
        elseif key == "w" then awful.screen.focused().internet.visible = not awful.screen.focused().internet.visible
        elseif key == "c" then awful.screen.focused().mytextclock.visible = not awful.screen.focused().mytextclock.visible
        end
        awful.keygrabber.stop(grabber)
      end
      )
    end,
    {description = "followed by RET", group="Bar"}
 ),

    -- keybindings for dmenu scripts
    awful.key( {modkey}, "p", function()
      local grabber
      grabber =
      awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if     key == "a" then awful.spawn.with_shell("dmenu_run -l 20")
        elseif key == "m" then awful.spawn.with_shell("monitors")
        elseif key == "b" then awful.spawn.with_shell("bookmarks")
        elseif key == "k" then awful.spawn.with_shell("keyboard")
        elseif key == "s" then awful.spawn.with_shell("maimmenu")
        elseif key == "i" then awful.spawn.with_shell("network")
        elseif key == "l" then awful.spawn.with_shell("logoutmenu")
        elseif key == "p" then awful.spawn.with_shell("passmenu -l 20 -p 'Choose password: '")
        elseif key == "w" then awful.spawn.with_shell("connectwifi")
        elseif key == "e" then awful.spawn.with_shell("emojipicker")
        end
        awful.keygrabber.stop(grabber)
      end
      )
    end,
    {description = "followed by KEY", group = "Scripts"}
    ),

    -- keybindings for terminal applications
    awful.key( {modkey}, "t", function()
      local grabber
      grabber =
      awful.keygrabber.run(
      function(_, key, event)
        if event == "release" then return end

        if     key == "t" then awful.spawn.with_shell(apps.terminal .. " -c dev -e tmux")
        elseif key == "h" then awful.spawn.with_shell(apps.terminal .. " -e htop")
        elseif key == "a" then awful.spawn.with_shell(apps.terminal .. " -c mus -e cmus")
        elseif key == "r" then awful.spawn.with_shell(apps.terminal .. " -c file -e lf-run")
        elseif key == "p" then awful.spawn.with_shell(apps.terminal .. " -e pulsemixer")
        elseif key == "v" then awful.spawn.with_shell(apps.terminal .. " -e alsamixer")
        elseif key == "n" then awful.spawn.with_shell(apps.terminal .. " -c nvim -e nvim")
        end
        awful.keygrabber.stop(grabber)
      end
      )
    end,
    {description = "followed by KEY", group = "Terminal apps"}
    ),

    -- keybindings for emacs things
    awful.key( {modkey}, "e", function()
	  local grabber
	  grabber =
	     awful.keygrabber.run(
		function(_, key, event)
		   if event == "release" then return end

		   if     key == "e" then awful.spawn.with_shell(apps.editor)
		   elseif key == "b" then awful.spawn.with_shell(apps.editor .. "--eval '(ibuffer)'")
		   elseif key == "d" then awful.spawn.with_shell(apps.editor .. "--eval '(dired nil)'")
                   elseif key == "t" then awful.spawn.with_shell(apps.editor .. "--eval '(+vterm/here nil)'")
		   end
		   awful.keygrabber.stop(grabber)
		end
	     )
    end,
       {description = "followed by KEY", group = "Emacs"}
    ),
	  
    -- browser 
    awful.key( {modkey,}, "g", function() 
      awful.spawn( "firefox -no-default-browser-check" )
    end,
    {description = "firefox", group = "custom"}),

    -- show all tags at once
    awful.key( {modkey,}, "0", toggle_view_all_tags,
    {description = "view all tags", group = "custom"}),

    -- pdf-viewer
    awful.key( {modkey,}, "z", function()
      awful.spawn( "zathura" )
    end,
    {description = "zathura", group = "custom"}),

    -- file browser
    awful.key( {modkey, "Shift"}, "f", function()
      awful.spawn( "pcmanfm" )
    end,
    {description = "pcmanfm", group = "custom"}),

    -- virtual machines
    awful.key( {modkey}, "v", function()
      awful.spawn( "virt-manager" )
    end,
    {description = "virt-manager", group = "custom"}),

    -- lockscreen
    awful.key( {modkey, "Shift"}, "s", function()
      awful.spawn( "slock" )
    end,
    {description = "slock", group = "custom"}),

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
    awful.key({ modkey, "Shift" }, "b",
        function ()
          for s in screen do
            s.mywibox.visible = not s.mywibox.visible
            if s.mybottomwibox then
              s.mybottomwibox.visible = not s.mybottomwibox.visible
            end
          end
        end,
        {description = "Toggle wibox", group = "awesome"}),
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
    awful.key({ modkey, "Control" }, "Return", function () awful.util.spawn("dmenu_run -l 20") end,
              {description = "run prompt", group = "launcher"}),
    awful.key({ modkey }, "x",
              function ()
                  awful.prompt.run {
                    prompt       = "Run Lua code: ",
                    textbox      = awful.screen.focused().mypromptbox.widget,
                    exe_callback = awful.util.eval,
                    history_path = awful.util.get_cache_dir() .. "/history_eval"
                  }
              end,
              {description = "lua execute prompt", group = "awesome"})
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
        {description = "(un)maximize horizontally", group = "client"}),

    awful.key({ modkey, "Mod1" }, "h", function (c) move_client_to_screen(c, c.screen.index-1) end,
       {description = "move client one screen left", group = "client"}),

    awful.key({ modkey, "Mod1" }, "l", function (c) move_client_to_screen(c, c.screen.index+1) end,
       {description = "move client one screen right", group = "client"})
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
