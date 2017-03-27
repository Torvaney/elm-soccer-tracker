module State exposing (init, update, subscriptions)

-- Module for the initial state of the app,
-- the supscriptions and the update function


import Keyboard.Extra

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
        ( { model | events = undoList model.events }, Cmd.none )
      MouseMsg position ->
        ( { model | events = model.events ++ [ position ] }, Cmd.none )


undoList : List a -> List a
undoList lst =
  List.take ((List.length lst) - 1) lst


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pitchXY MouseMsg
        ]
