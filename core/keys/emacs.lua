local gtable = require("gears.table")
local awful = require("awful")
local apps = require("core.apps")

local emacskeys = gtable.join(
   -- emacs
   awful.key ( {apps.modkey}, "e", function()
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
   )
)

return emacskeys
