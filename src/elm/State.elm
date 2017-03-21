module State exposing (init, update, subscriptions)

-- Module for the initial state of the app,
-- the supscriptions and the update function


{--
TODO:
 * Convert coordinates to 100x100
--}

import Types exposing (..)
import Ports exposing ( addPitchListener, pitchXY )


init : ( Model, Cmd Msg )
init =
    ( [], addPitchListener "")


-- UPDATE

update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
      Clear ->
        ( [ ], Cmd.none )
      Undo ->
        ( undoList model, Cmd.none )
      MouseMsg position ->
        ( model ++ [ position ], Cmd.none )


undoList : List a -> List a
undoList lst =
  List.take ((List.length lst) - 1) lst


-- SUBSCRIPTIONS

subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.batch
        [ pitchXY MouseMsg
        ]
