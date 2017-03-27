module View exposing (..)

import Html exposing (Html, div, button, h1, p, hr, a, text)
import Html.Attributes exposing (class, height, width, id, href, downloadAs)
import Html.Events exposing (onClick)
import Svg exposing (svg, circle)
import Svg.Attributes exposing (cx, cy, r, fill, fillOpacity, stroke)
import Markdown

import Download exposing (toCsv)
import Types exposing (..)
import Pitch exposing (pitch, pitchWidth, pitchLength, pitchOffset)


view : Model -> Html Msg
view model =
  div [ class "row"]
    [ divN 1
    , div [ class "col-md-10 text-center" ]
          [ h1 [ class "text-center" ] [ text headerText ]
          , Markdown.toHtml [ class "text-left" ] introText
          , pitchSvg ( pitch ++ (List.map drawCircle model.events) )
          , div [ class "row" ]
            [ div [ class "col-md-12" ]
                [ div [ class "btn-group download-events"]
                      [ a [ class "btn btn-primary"
                        , href (toCsv model.events)
                        , downloadAs "events.csv"
                        ] [ text "Download" ]
                      ]
                , div [ class "btn-group clear-events"]
                      [ a [ class "btn btn-warning"
                          , href "#"
                          , onClick Undo
                          ] [ text "Undo last" ]
                      , a [ class "btn btn-danger"
                        , href "#"
                        , onClick Clear
                        ] [ text "Clear events" ]
                      ]
                ] ]
          , hr [] []
          , Markdown.toHtml [ class "text-left" ] appendixText
          ]
    , divN 1
    ]


pitchSvg =
  svg
      [ width <| (+) pitchLength <| (*) 2 <| pitchOffset
      , height <| (+) pitchWidth <| (*) 2 <| pitchOffset
      , id "pitchSvg"
      ]


drawCircle position =
  circle [ cx (toString position.x)
         , cy (toString position.y)
         , r "5"
         , fill "#fffd69"
         , fillOpacity "0.9"
         , stroke "black"
         ]
    []


divN : Int -> Html msg
divN n =
  div [ class ("col-md-" ++ (toString n)) ] []


-- TEXT

headerText = "Soccer event logger"


introText = """
1. Register events by clicking on the football pitch.
2. Download the events as a csv (spreadsheet).
"""


appendixText = """
If you like this, you'll probably also be interested in [Neil Charles](
https://twitter.com/neilcharles_uk)'s [chalkboard app](
http://apps.hilltop-analytics.com/chalkboard/).

This project was inspired by [John Burn-Murdoch](
https://twitter.com/jburnmurdoch)'s [pitch tracker](
http://johnburnmurdoch.github.io/football-pitch-tracker/).

This app was written in Elm. Find the source code on [Github](
https://github.com/Torvaney/elm-soccer-tracker).
"""
