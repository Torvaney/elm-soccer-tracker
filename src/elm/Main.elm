module Main exposing (..)

import Html exposing (program)

import Types exposing (..)
import State exposing (init, update, subscriptions)
import View exposing (view)


-- MAIN


main : Program Never Model Msg
main =
    program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }
