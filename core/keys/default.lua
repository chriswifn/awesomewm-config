local gtable = require("gears.table")
local awful = require("awful")
local hotkeys_popup = require("awful.hotkeys_popup")
local apps = require("core.apps")

local function rename_tag()
  awful.prompt.run {
    prompt       = "New tag name: ",
    textbox      = awful.screen.focused().mypromptbox.widget,
    exe_callback = function(new_name)
      if not new_name or #new_name == 0 then return end

      local t = awful.screen.focused().selected_tag
      if t then
	t.name = t.name .. " [" .. new_name .. "]"
      end
    end
  }
end

local defaultkeys = gtable.join(
  -- awesome specific keybindings
  awful.key( {apps.modkey}, "x", function()
      local grabber
      grabber =
	awful.keygrabber.run(
	  function(_, key, event)
	    if event == "release" then return end

	    if key == "s" then -- Show a popup that helps with keybindings
	      hotkeys_popup.show_help()

	    elseif key == "Left" then -- Show the previous tag  
	      awful.tag.viewprev()

	    elseif key == "Right" then -- Show the next tag
	      awful.tag.viewnext()

	    elseif key == "e" then -- restore history
	      awful.tag.history.restore()

	    elseif key == "h" then -- focus other monitor
	      awful.screen.focus_relative(1)

	    elseif key == "l" then -- focus other monitor
	      awful.screen.focus_relative(-1)

	    elseif key == "r" then -- reload the configuration
	      awesome.restart()

	    elseif key == "q" then -- quit awesomewm
	      awesome.quit()

	    elseif key == "t" then -- toggle layouts
	      awful.layout.inc(1)

	    elseif key == "p" then -- run launcher 
	      awful.util.spawn("rofi -show run")

	    elseif key == "w" then -- show all open windows
	      awful.util.spawn("rofi -show window")

	    elseif key == "n" then
	      rename_tag()

	    end
	    awful.keygrabber.stop(grabber)
	  end
	)
  end,
    {description = "awesome keys", group = "awesome"}
  ),

  -- resize
  awful.key({ apps.modkey,           }, "l",     function () awful.tag.incmwfact( 0.05)          end,
    {description = "increase master width factor", group = "layout"}),
  awful.key({ apps.modkey,           }, "h",     function () awful.tag.incmwfact(-0.05)          end,
    {description = "decrease master width factor", group = "layout"})
)

return defaultkeys
