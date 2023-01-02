local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local function togglebar()
  for s in screen do
    s.mywibox.visible = not s.mywibox.visible
  end
end

local function togglesystray()
  awful.screen.focused().systray.visible = not awful.screen.focused().systray.visible
end

local function togglelayout()
  awful.screen.focused().mylayoutbox.visible = not awful.screen.focused().mylayoutbox.visible
end

local barkeys = gtable.join(
  -- keybindings for the wibar 
  awful.key ( {apps.modkey}, "b", function()
      local grabber
      grabber =
	awful.keygrabber.run(
	  function(_, key, event)
	    if event == "release" then return end
	    if key == "b" then
	      togglebar()
	    elseif key == "s" then
	      togglesystray()
	    elseif key == "l" then
	      togglelayout()
	    end
	    awful.keygrabber.stop(grabber)
	  end
	)
  end,
    {description = "bar keys", group="bar"}
  )
)

return barkeys
