-- Standard awesome library
local awful = require("awful")

-- checks if process is running or starts the process 
local function run_once(cmd_arr)
    for _, cmd in ipairs(cmd_arr) do
        awful.spawn.with_shell(string.format("pgrep -u $USER -fx '%s' > /dev/null || (%s)", cmd, cmd))
    end
end

-- programs that should autostart
run_once({ 
  -- gui polkit
  "lxsession", 
  -- nobody needs caps lock 
  "setxkbmap -option caps:escape",
  -- to fix java bugs in applications
  "wmname LG3D",
  -- emacs-server for SPEEEEEEEEED!!!
  "/usr/bin/emacs --daemon",
})
