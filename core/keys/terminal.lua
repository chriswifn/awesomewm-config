local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local terminalkeys = gtable.join(
    -- terminal applications
    awful.key ( {apps.modkey}, "t", function()
	    local grabber
	    grabber =
		awful.keygrabber.run(
		    function(_, key, event)
			if event == "release" then return end
			if key == "t" then
			    local matcher = function(c)
				return awful.rules.match(c, {class = "st-256color"}) 
			    end
			    awful.client.run_or_raise(apps.terminal .. "-e tmux new-session -A -s tempterm", matcher)
			elseif key == "n" then awful.spawn(apps.terminal)
			end
			awful.keygrabber.stop(grabber)
		    end
		)
    end,
	{description = "terminal keys", group="terminal"}
    )
)

return terminalkeys
