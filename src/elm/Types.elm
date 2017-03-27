module Types exposing (..)


type Msg
    = Clear
    | Undo
    | MouseMsg Position


type alias Position =
  { x : Float
  , y : Float
  }


type alias Model =
    List Position


type PitchEnd
    = PitchLeft
    | PitchRight


type PitchDimension
    = PitchX
    | PitchY
