local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local function myclient(c)
    local grabber
    grabber = awful.keygrabber.run(
	function(mod, key, event)
	    if event == "release" then return end

	    if key == "c" then -- kill a client
		c:kill()

	    elseif key == "f" then
		c.fullscreen = not c.fullscreen
		c:raise()

	    elseif key == "t" then -- toggle floating
		awful.client.floating.toggle()

	    elseif key == "m" then -- promote to master
		c:swap(awful.client.getmaster())

	    elseif key == "o" then -- move to other screen
		c:move_to_screen()

	    elseif key == "g" then -- go to the center
		awful.placement.centered()

	    elseif key == "s" then -- sticky
		c.sticky = not c.sticky

	    elseif key == "j" then -- swap
		awful.client.swap.byidx(1)

	    elseif key == "k" then -- swap
		awful.client.swap.byidx(-1)

	    elseif key == "u" then -- jump to urgent tag
		awful.client.urgent.jumpto()

	    end
	    awful.keygrabber.stop(grabber)
    end)
end

local clientkeys = gtable.join(
    awful.key( {apps.modkey}, "c", myclient,
	{description = "client keys", group = "client"})
)

return clientkeys
