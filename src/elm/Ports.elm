port module Ports exposing (..)

import Types exposing (..)

-- Add an event listener to the pitch SVG
port addPitchListener : String -> Cmd msg

-- Get the x, y locations of the mouse click within the pitch
port pitchXY : (Position -> msg) -> Sub msg
