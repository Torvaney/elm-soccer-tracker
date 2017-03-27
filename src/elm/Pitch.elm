module Pitch exposing (pitch, pitchOffset, pitchWidth, pitchLength)

import Html exposing (Html)
import Html.Attributes exposing (id, height, width)
import Svg exposing (svg, circle, rect, line)
import Svg.Attributes exposing (class, x, y, x1, y1, x2, y2, cx, cy, r,fill, fillOpacity, stroke)
import Debug

import Types exposing (..)

{-- Abandon hope all ye who have to read this... --}

pitchClass =
  "pitch"

pitchLength =
  560

pitchWidth =
  380

pitchOffset =
  10


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
         , y <| toString <| pitchOffset
         , x <| toString <| pitchOffset
         ] []
  , line [ class pitchClass
         , x1 <| toString <| (scaleCoord 50 PitchX)
         , y1 <| toString <| (scaleCoord 0 PitchY)
         , x2 <| toString <| (scaleCoord 50 PitchX)
         , y2 <| toString <| (scaleCoord 100 PitchY)
         ] []
  ]


centreCircle =
  [ circle [ class pitchClass
           , cy <| toString <| (scaleCoord 50 PitchY)
           , cx <| toString <| (scaleCoord 50 PitchX)
           , r <| toString <| (scaleCoord 11.5 PitchY)
           , fillOpacity "0"
           ] []
  , circle [ class pitchClass
           , cy <| toString <| (scaleCoord 50 PitchY)
           , cx <| toString <| (scaleCoord 50 PitchX)
           , r "2"
           ] []
  ]


penaltyBox pitchEnd =
  [ circle [ class pitchClass
           , cy <| toString <| scaleCoordY <| 50
           , cx <| toString <| scaleCoordX <| distFromEnd 11.5 pitchEnd
           , r <| toString <| scaleCoordY <| 11.5
           , fillOpacity "0"
           ] []
  , pitchRect 17 57.8 0 pitchEnd
  , pitchRect 5.8 26.4 0 pitchEnd
  , circle [ class pitchClass
           , cy <| toString <| scaleCoordY <| 50
           , cx <| toString <| scaleCoordX <| distFromEnd 11.5 pitchEnd
           , r <| toString <| 2
           , fillOpacity "0"
           ] []
  ]


goal pitchEnd =
  [
  pitchRect 1 11.6 -1 pitchEnd
  ]


-- Scale coordinates from 100x100 to pitchLength x pitchWidth
scaleValue val offset pitchDim =
  case pitchDim of
    PitchX ->
      (val / 100.0) |>
        (*) pitchLength |>
        (+) offset
    PitchY ->
      (val / 100.0) |>
        (*) pitchWidth |>
        (+) offset


scaleCoord val pitchDim =
  scaleValue val pitchOffset pitchDim


scaleLength val pitchDim =
  scaleValue val 0 pitchDim


scaleCoordX val =
  scaleCoord val PitchX


scaleCoordY val =
  scaleCoord val PitchY


distFromEnd val pitchEnd =
  case pitchEnd of
    PitchLeft ->
      val
    PitchRight ->
      100 - val


xFromEnd xLeft elemWidth pitchEnd =
  case pitchEnd of
    PitchLeft ->
      xLeft
    PitchRight ->
      100 - xLeft - elemWidth


pitchRect rectWidth rectHeight xLeft pitchEnd =
  rect [ class pitchClass
        , height <| round <| scaleLength rectHeight PitchY
        , width <| round <| scaleLength rectWidth PitchX
        , y <| toString <| scaleCoordY <| (-) 50 <| rectHeight / 2.0
        , x <| toString <| scaleCoordX <| xFromEnd xLeft rectWidth pitchEnd
        ] []
