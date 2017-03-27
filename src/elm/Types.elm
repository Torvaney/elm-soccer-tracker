module Types exposing (..)

import Keyboard.Extra


type Msg
    = Clear
    | Undo
    | MouseMsg Position
    | KeyboardMsg Keyboard.Extra.Msg


-- Model types


type alias Position =
  { x : Float
  , y : Float
  }


type Modifier
  = Mod1
  | Mod2
  | Mod3


type alias Event =
  { x : Float
  , y : Float
  , mod1 : Bool
  , mod2 : Bool
  , mod3 : Bool
  }


type alias Model =
    { events : List Event
    , keyboardState : Keyboard.Extra.State
    }


-- Pitch types


type PitchEnd
    = PitchLeft
    | PitchRight


type PitchDimension
    = PitchX
    | PitchY
