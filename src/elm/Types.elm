module Types exposing (..)

import Keyboard.Extra


type Msg
    = Clear
    | Undo
    | MouseMsg Position


type alias Position =
  { x : Float
  , y : Float
  }


type alias Model =
    { events : List Position
    , keyboardState : Keyboard.Extra.State
    }


type PitchEnd
    = PitchLeft
    | PitchRight


type PitchDimension
    = PitchX
    | PitchY
