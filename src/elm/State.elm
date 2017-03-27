module State exposing (init, update, subscriptions)

-- Module for the initial state of the app,
-- the supscriptions and the update function


import Keyboard.Extra
import Debug

import Types exposing (..)
import Ports exposing ( addPitchListener, pitchXY )


init : ( Model, Cmd Msg )
init =
    ( initModel, addPitchListener "")


initModel =
  { keyboardState = Keyboard.Extra.initialState
  , events = [ ]
  }

-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Clear ->
        ( { model | events = [ ] }, Cmd.none )
      Undo ->
        ( undoEvent model, Cmd.none )
      MouseMsg position ->
        ( addEvent model position, Cmd.none )
      KeyboardMsg keyMsg ->
        ( setKeyState model keyMsg, Cmd.none )


undoList : List a -> List a
undoList lst =
  List.take ((List.length lst) - 1) lst


undoEvent : Model -> Model
undoEvent model =
  { model | events = undoList model.events }


addEvent : Model -> Position -> Model
addEvent model position =
  { model
  | events = model.events ++ [ createEvent model position ]
  }


setKeyState model keyMsg =
  { model
  | keyboardState =
      Keyboard.Extra.update
      keyMsg
      model.keyboardState
  }


createEvent : Model -> Position -> Event
createEvent model position =
  { x = position.x
  , y = position.y
  , mod1 = Debug.log "mod1" <| isPressed model Mod1
  , mod2 = isPressed model Mod2
  , mod3 = isPressed model Mod3
  }


isPressed : Model -> Modifier -> Bool
isPressed model modifier =
  Keyboard.Extra.isPressed
    (modifierKey modifier)
    model.keyboardState


modifierKey modifier =
  case modifier of
    Mod1 -> Keyboard.Extra.Number1
    Mod2 -> Keyboard.Extra.Number2
    Mod3 -> Keyboard.Extra.Number3


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pitchXY MouseMsg
        , Sub.map KeyboardMsg Keyboard.Extra.subscriptions
        ]
