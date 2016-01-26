import Char
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import String
import Task exposing (..)


-- VIEW

view : String -> String -> String -> Result String (List String) -> Html
view string1 string2 string3 result =
  let field =
      div [] [
        input
          [ placeholder "Owner"
          , value string1
          , on "input" targetValue (Signal.message query.address)
          , fieldStyle
          ]
          [] ,
        input
          [ placeholder "Repo"
          , value string2
          , on "input" targetValue (Signal.message repo.address)
          , fieldStyle
          ]
          [] ,
        input
          [ placeholder "File"
          , value string3
          , on "input" targetValue (Signal.message file.address)
          , fieldStyle
          ]
          []
      ]

      messages =
        case result of
          Err msg ->
              [ div [ myStyle ] [ text msg ] ]

          Ok cities ->
              List.map (\city -> div [ myStyle ] [ text city ]) cities
  in
      div [] (field :: messages)

fieldStyle : Attribute
fieldStyle =
  style
    [ ("width", "31%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]

myStyle : Attribute
myStyle =
  style
    [ ("width", "100%")
    , ("height", "40px")
    , ("padding", "10px 0")
    , ("font-size", "2em")
    , ("text-align", "center")
    ]


-- WIRING

main =
  Signal.map4 view query.signal repo.signal file.signal results.signal

query : Signal.Mailbox String
query =
  Signal.mailbox ""

repo : Signal.Mailbox String
repo =
  Signal.mailbox ""

file : Signal.Mailbox String
file =
  Signal.mailbox ""

results : Signal.Mailbox (Result String (List String))
results =
  Signal.mailbox (Err "A valid US zip code is 5 numbers.")


port requests : Signal (Task x ())
port requests =
  Signal.map lookupZipCode query.signal
    |> Signal.map (\task -> Task.toResult task `andThen` Signal.send results.address)


lookupZipCode : String -> Task String (List String)
lookupZipCode query =
  let toUrl =
        if String.length query == 5 && String.all Char.isDigit query
          then succeed ("http://api.zippopotam.us/us/" ++ query)
          else fail "Give me a valid US zip code!"
  in
      toUrl `andThen` (mapError (always "Not found :(") << Http.get places)


places : Json.Decoder (List String)
places =
  let place =
        Json.object2 (\city state -> city ++ ", " ++ state)
          ("place name" := Json.string)
          ("state" := Json.string)
  in
      "places" := Json.list place
