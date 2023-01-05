local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local layoutkeys = gtable.join(
    awful.key( {apps.modkey}, "l", function()
	    local grabber
	    grabber =
		awful.keygrabber.run(
		    function(_, key, event)
			if event == "release" then return end

			if key == "l" then
			    awful.tag.incmwfact( 0.05)

			elseif key == "h" then
			    awful.tag.incmwfact(-0.05)

			elseif key == "j" then
			    awful.client.focus.byidx(1)

			elseif key == "k" then
			    awful.client.focus.byidx(-1)

			elseif key == "f" then
			    awful.layout.set(awful.layout.suit.floating)

			elseif key == "t" then
			    awful.layout.set(awful.layout.suit.tile)

			elseif key == "m" then
			    awful.layout.set(awful.layout.suit.max)
			end
			awful.keygrabber.stop(grabber)
		    end
		)
    end,
	{description = "layout", group = "layout"}
    )
)

return layoutkeys
