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

Next let's make a Get request

    > Http.get "https://api.github.com/users/monsieurcactus/repos"
    ==================================== ERRORS ====================================
    
    -- TYPE MISMATCH --------------------------------------------- repl-temp-000.elm
    
    The argument to function `get` is causing a mismatch.
    
    5│   Http.get "https://api.github.com/users/monsieurcactus/repos"
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
    Function `get` is expecting the argument to be:
    
        Json.Decoder a
        
That didn't work.  We need to write the Json decoder first.  Kind of stuck here!

Try **#1**
    
    > repos = Json.list
    <function: decodeList> : Json.Decode.Decoder a -> Json.Decode.Decoder (List a)
    > Http.get repos "https://api.github.com/users/monsieurcactus/repos"
    -- TYPE MISMATCH --------------------------------------------- repl-temp-000.elm
    
    The 1st argument to function `get` is causing a mismatch.
    
    5│   Http.get repos "https://api.github.com/users/monsieurcactus/repos"
                  ^^^^^
    Function `get` is expecting the 1st argument to be:
    
        Json.Decoder a
    
    But it is:
    
        Json.Decoder a -> Json.Decoder (List a)

Try **#2**    
    
    > repos = Json.object1
    <function: decodeObject1>
        : (a -> b) -> Json.Decode.Decoder a -> Json.Decode.Decoder b
    > Http.get repos "https://api.github.com/users/monsieurcactus/repos"
    -- TYPE MISMATCH --------------------------------------------- repl-temp-000.elm
    
    The 1st argument to function `get` is causing a mismatch.
    
    5│   Http.get repos "https://api.github.com/users/monsieurcactus/repos"
                  ^^^^^
    Function `get` is expecting the 1st argument to be:
    
        Json.Decoder a
    
    But it is:
    
        (a -> b) -> Json.Decoder a -> Json.Decoder b

Try **#3** - at least this is not a type mismatch!  Still can't get the information I want.
    
    > Http.get (Json.string) "https://api.github.com/users/monsieurcactus/repos"
    { tag = "AndThen", task = { tag = "Catch", task = { tag = "Async", asyncFunction = <function> }, callback = <function> }, callback = <function> }
        : Task.Task Http.Error String
        
Try **#4** Json.[Encode](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/Json-Encode) Json.[Decode](http://package.elm-lang.org/packages/elm-lang/core/1.0.0/Json-Decode) - my primitive way of testing data

    > import Json.Encode
    > import Json.Decode
    > Json.Decode.decodeValue Json.Decode.int (Json.Encode.int 5)
    Ok 5 : Result.Result String Int
    
---

## Getting Pure Data from an Impure World

All this grief is consistent with the nature of functional programming.  Elm is pure, the real world is not.  How do we reconcile this?? Very carefully :-/
    
Try **#5** My data is a list here's a similified version of the output from Github:

    [ {"id": 12, "name": "project"}, {}]

Here's getting Json Encod/Decode to work on lists.

    > import Json.Encode
    > List.map Json.Encode.int [1,2,3,4,5]
    [1,2,3,4,5] : List Json.Encode.Value
    > Json.Encode.list (List.map Json.Encode.int [1,2,3,4,5])
    { 0 = 1, 1 = 2, 2 = 3, 3 = 4, 4 = 5 } : Json.Encode.Value


**Disclaimer** every bit of this could be wrong!
