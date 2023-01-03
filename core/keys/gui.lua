local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local guikeys = gtable.join(
    -- gui applications
    awful.key ( {apps.modkey}, "g", function()
	    local grabber
	    grabber =
		awful.keygrabber.run(
		    function(_, key, event)
			if event == "release" then return end
			if key == "g" then
			    local matcher = function(c)
				return awful.rules.match(c, {class = "firefox"})
			    end
			    awful.client.run_or_raise(apps.browser, matcher)
			elseif key == "z" then awful.spawn.raise_or_spawn("zathura", {class = "zathura"})
			elseif key == "f" then awful.spawn.raise_or_spawn("pcmanfm", {class = "pcmanfm"})
			elseif key == "v" then awful.spawn.raise_or_spawn("virt-manager", {class = "Virt-manager"}) 
			elseif key == "s" then awful.spawn.with_shell("slock")
			end
			awful.keygrabber.stop(grabber)
		    end
		)
    end,
	{description = "gui keys", group = "gui"})
)

return guikeys
