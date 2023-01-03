local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local dmenukeys = gtable.join(
    -- dmenu scripts
    awful.key ( {apps.modkey}, "d", function()
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
			elseif key == "t" then awful.spawn.with_shell("delight")
			elseif key == "f" then awful.spawn.with_shell("tabfocus")
			end
			awful.keygrabber.stop(grabber)
		    end
		)
    end,
	{description = "dmenu keys", group="dmenu"}
    )
)

return dmenukeys
