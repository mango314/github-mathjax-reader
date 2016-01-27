import Char
import Html exposing (..)
import Html.Attributes as Attr exposing (..)
import Html.Events exposing (..)
import Http
import Json.Decode as Json exposing ((:=))
import String
import Task exposing (..)


-- VIEW

view : String -> String -> String -> Result String (List RepoInfo) -> Html
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
              List.map (\ repo -> div [ myStyle ] [ text repo.name ]) cities
  in
      div [] (field :: messages)

fieldStyle : Attribute
fieldStyle =
  style
    [ ("width", "32%")
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

results : Signal.Mailbox (Result String (List RepoInfo))
results =
  Signal.mailbox (Err "A valid US zip code is 5 numbers.")


port requests : Signal (Task x ())
port requests =
  Signal.map fetchData query.signal
    |> Signal.map (\ task -> Task.toResult task `andThen` Signal.send results.address)


-- from someone else's github gist
type alias RepoInfo =
  { id : Int
  , name : String
  }

repoInfoDecoder : Json.Decoder RepoInfo
repoInfoDecoder =
  Json.object2
    RepoInfo
    ("id" := Json.int) 
    ("name" := Json.string) 

repoInfoListDecoder : Json.Decoder (List RepoInfo)
repoInfoListDecoder =
  Json.list repoInfoDecoder

fetchData : String -> Task Http.Error (List RepoInfo)
fetchData url =
  Http.get repoInfoListDecoder url
