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
		  if key == "t" then awful.spawn.with_shell(apps.terminal .. "-c 'dev' -e tmux")
		  elseif key == "n" then awful.spawn.with_shell(apps.terminal .. "-c 'nvim' -e nvim")
		  elseif key == "h" then awful.spawn.with_shell(apps.terminal .. "-e htop")
		  elseif key == "a" then awful.spawn.with_shell(apps.terminal .. "-c 'mus' -e cmus")
		  elseif key == "r" then awful.spawn.with_shell(apps.terminal .. "-c 'file' -e lf-run")
		  elseif key == "p" then awful.spawn.with_shell(apps.terminal .. "-e pulsemixer")
		  end
		  awful.keygrabber.stop(grabber)
	       end
	    )
   end,
      {description = "followed by KEY", group="Terminal"}
   )
)

return terminalkeys
