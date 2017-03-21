module Download exposing (toCsv)

import Types exposing (Position, Model)
import Pitch exposing (pitchOffset, pitchWidth, pitchLength)


csvPrefix : String
csvPrefix =
  "data:text/csv;charset=utf-8,"


csvHeader : String
csvHeader =
  "x, y"


sep : String
sep =
  ","

rowSep : String
rowSep =
  "%0A"

-- Should make this generic
toCsv : Model -> String
toCsv model =
  model |>
    List.map convertCoords |>
    createRows |>
    rowsToCsv |>
    (++) csvPrefix


toRow : Position -> String
toRow position =
  (toString position.x) ++
    sep ++
    (toString position.y)


createRows : Model -> (List String)
createRows model =
  [ csvHeader ] ++
    (List.map toRow model)


joinRows : String -> String -> String
joinRows row1 row2 =
  row1 ++ rowSep ++ row2


rowsToCsv : (List String) -> String
rowsToCsv rows =
  List.foldr joinRows "" rows


convertCoords : Position -> Position
convertCoords rawPosition =
  { rawPosition
  | x = 100 * (rawPosition.x - pitchOffset) / pitchLength
  , y = 100 * (rawPosition.y - pitchOffset) / pitchWidth
  }
