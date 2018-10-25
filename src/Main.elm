module Main exposing (main)

import Browser
import Html exposing (Html, input, div, span, text)
import Html.Events exposing (onInput)
import Date


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
    = InputChanged String


type alias Model =
    { output : String
    }


init : Flags -> ( Model, Cmd Msg )
init _ =
    ( { output = ""
      }
    , Cmd.none
    )


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        InputChanged inputValue ->
            let
                inputInt =
                    Maybe.withDefault 0 (String.toInt inputValue)
            in
                ( { model | output = Date.fromRataDie inputInt |> Date.toIsoString }, Cmd.none )


view : Model -> Html Msg
view model =
    div []
        [ input [ onInput InputChanged ] []
        , span [] [ text model.output ]
        ]



-- SUBSCRIPTIONS


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none
