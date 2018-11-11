module Main exposing (main)

import Browser
import Date
import Html exposing (Html, a, div, input, span, text)
import Html.Attributes exposing (class, href, maxlength, size, value)
import Html.Events exposing (onInput)
import String exposing (fromInt)
import Task



-- MAIN


type alias Flags =
    {}


main =
    Browser.element
        { init = init
        , update = update
        , subscriptions = subscriptions
        , view = view
        }


type Msg
    = InputChanged String -- when user changes input ratadie
    | SetToday (Maybe Date.Date) -- set current date when task finishes


type alias Model =
    { input : Int
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { input = 0
      }
    , Task.perform (Just >> SetToday) Date.today -- get current date
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChanged inputValue ->
            let
                inputInt =
                    Maybe.withDefault 0 (String.toInt inputValue) -- go to 0 with invalid ratadie
            in
            ( { model | input = inputInt }, Cmd.none )

        SetToday date ->
            case date of
                Just a ->
                    ( { model | input = Date.toRataDie a }, Cmd.none )

                _ ->
                    ( model, Cmd.none )


view : Model -> Html Msg
view model =
    div [ class "wrapper" ]
        [ div [ class "cell" ]
            [div [class "inputWrapper"]
            [ input [ onInput InputChanged, value (fromInt model.input), size 7 ] []
            , div [ class "label" ] [ text "RataDie" ]
            ]]
        , div [ class "cell" ]
            [ div [class "date"] [ text (Date.fromRataDie model.input |> Date.toIsoString) ]
            , div [ class "label" ] [ text "yyyy-mm-dd" ]
            ]
        , span [] []
        , a [ href "https://www.vcalc.com/wiki/MichaelBartmess/Rata+Die+%28RD%29" ] [ text "The other way" ]
        ]


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
