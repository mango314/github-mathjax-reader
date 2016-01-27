Running into some difficulties importing my own repos.  Let's use the repl.

    > import http
    -- SYNTAX PROBLEM -------------------------------------------- repl-temp-000.elm

    I ran into something unexpected when parsing your code!

That's because I haven't installed http.  It seems to be at http://package.elm-lang.org/packages/evancz/elm-http/3.0.0/ then let's get
out of repl and try

    elm-package install evancz/elm-http
    
That worked!  Now we are ready:

    > import Http
    > import Json.Decode as Json exposing ((:=))
    > (:=)
    <function> : String -> Json.Decode.Decoder a -> Json.Decode.Decoder a
    > Http.get
    <function> : Json.Decode.Decoder a -> String -> Task.Task Http.Error a
    
While complicated, at least we understand better some of the types involved in making am Http get request.  In Elm, 
it seems Http get requests are always answered a [`Json.Decode`](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/Json-Decode)
object of some kind.  That funny looking function [`(:=)`](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/Json-Decode#:=) 
takes a `String` and a `Json.Decode.Decoder` and returns another `Json.Decode.Decoder` of the same type.

**Disclaimer** every bit of this could be wrong!
