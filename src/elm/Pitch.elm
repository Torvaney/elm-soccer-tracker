module Pitch exposing (pitch, pitchOffset, pitchWidth, pitchLength)

import Html exposing (Html)
import Html.Attributes exposing (id, height, width)
import Svg exposing (svg, circle, rect, line)
import Svg.Attributes exposing (class, x, y, x1, y1, x2, y2, cx, cy, r,fill, fillOpacity, stroke)

import Types exposing (..)

{--
TODO:
  * Make all numbers relative to pitch size and offset
--}


pitchClass =
  "pitch"

pitchLength = 560

pitchWidth = 380

pitchOffset = 5


pitch =
    pitchOutline ++
    centreCircle ++
    penaltyBox PitchLeft ++
    penaltyBox PitchRight ++
    goal PitchLeft ++
    goal PitchRight


pitchOutline =
  [ rect [ class pitchClass
         , height pitchWidth
         , width pitchLength
         , y "5"
         , x "5"
         ] []
  , line [ class pitchClass
         , x1 <| toString <| (+) pitchOffset <| (pitchLength / 2)
         , y1 <| toString <| pitchOffset
         , x2 <| toString <| (+) pitchOffset <| (pitchLength / 2)
         , y2 <| toString <| (pitchOffset + pitchWidth)
         ] []
  ]


centreCircle =
  [ circle [ class pitchClass
           , cy <| toString <| (+) pitchOffset <| (pitchWidth / 2)
           , cx <| toString <| (+) pitchOffset <| (pitchLength / 2)
           , r "50"  -- is this actually correct...?
           , fillOpacity "0"
           ] []
  , circle [ class pitchClass
           , cy <| toString <| (+) pitchOffset <| (pitchWidth / 2)
           , cx <| toString <| (+) pitchOffset <| (pitchLength / 2)
           , r "2"
           ] []
  ]


distanceFromEnd offsetDist elemWidth pitchEnd =
  case pitchEnd of
    PitchLeft ->
      pitchOffset + offsetDist
    PitchRight ->
      (pitchOffset + pitchLength) - offsetDist - elemWidth


penaltyBox pitchEnd =
  [ circle [ class pitchClass
           , cy "190"
           , cx <| toString <| (distanceFromEnd 74.4 0 pitchEnd) -- "490.6"
           , r "50"
           ] []
  , rect [ class pitchClass
         , height 219
         , width 95
         , y "85"
         , x <| toString <| (distanceFromEnd 0 95 pitchEnd) -- "470"
         ] []
  , rect [ class pitchClass
         , height 100
         , width 32
         , y "140"
         , x <| toString <| (distanceFromEnd 0 32 pitchEnd) -- 533
         ] []
  , circle [ class pitchClass
           , cy "190"
           , cx <| toString <| (distanceFromEnd 74.4 0 pitchEnd) -- "490.6"
           , r "2"
           ] []
  ]


goal pitchEnd =
  [
  rect [ class pitchClass
       , height 45
       , width 5
       , y "167.5"
       , x <| toString <| (distanceFromEnd (-pitchOffset) pitchOffset pitchEnd)
       ] []
  ]
