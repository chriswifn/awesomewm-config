-- standard awesome library
local awful = require("awful")

-- Tiling, Monocle and Floating are the only layouts you need
awful.layout.layouts = {
   awful.layout.suit.tile,
   awful.layout.suit.max,
}
