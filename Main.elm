module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (onClick)


main =
    beginnerProgram
        { model = model
        , update = update
        , view = view
        }



-- MODEL


type alias Release =
    { version : String
    , status : Int
    }


type alias Model =
    { releases : List Release
    , current : Int
    , show : Maybe Int
    }


model =
    { releases = []
    , current = 0
    , show = Nothing
    }



-- UPDATE


type Msg
    = ShowCurrent Int
    | ShowAll


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowCurrent id ->
            { model | show = Just id }

        ShowAll ->
            { model | show = Nothing }



-- VIEW


view : Model -> Html Msg
view model =
    let
        content =
            case model.show of
                Just id ->
                    model.current
                        |> toString
                        |> text

                Nothing ->
                    model.releases |> toString |> text
    in
        div []
            [ div []
                [ button [ onClick (ShowCurrent 0) ] [ text "Current" ]
                , button [ onClick ShowAll ] [ text "All" ]
                ]
            , div []
                [ content ]
            ]
