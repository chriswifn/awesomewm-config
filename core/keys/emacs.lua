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
		  if key == "e" then
		    local matcher = function(c)
		      return awful.rules.match(c, {class = "Emacs"})
		    end
		    awful.client.run_or_raise(apps.editor, matcher)

		  elseif key == "b" then awful.spawn.with_shell(apps.editor .. "--eval '(ibuffer)'")
		  end
		  awful.keygrabber.stop(grabber)
	       end
	    )
   end,
      {description = "emacs keys", group="emacs"}
   )
)

return emacskeys
