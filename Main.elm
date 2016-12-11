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


type Page
    = Current
    | All


type alias Release =
    { version : String
    , status : Int
    }


type alias Model =
    { releases : List Release
    , current : String
    , show : Page
    }


releases =
    [ { version = "0.1", status = 0 }
    , { version = "0.2", status = 0 }
    , { version = "0.3", status = 0 }
    ]


model =
    { releases = releases
    , current = "0.3"
    , show = Current
    }



-- UPDATE


type Msg
    = ShowCurrent
    | ShowAll


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShowCurrent ->
            { model | show = Current }

        ShowAll ->
            { model | show = All }



-- VIEW


renderList : List a -> Html Msg
renderList list =
    ul [] (list |> List.map (\elt -> li [] [ elt |> toString |> text ]))


renderReleaseVersion : String -> Html Msg
renderReleaseVersion version =
    let
        target =
            model.releases |> List.filter (\release -> release.version == version) |> List.head
    in
        case target of
            Just release ->
                renderRelease release

            Nothing ->
                text "404"


renderRelease : Release -> Html Msg
renderRelease release =
    div []
        [ h1 [] [ release.version |> text ]
        , div [] [ release.status |> toString |> text ]
        ]


view : Model -> Html Msg
view model =
    let
        content =
            case model.show of
                Current ->
                    renderReleaseVersion model.current

                All ->
                    model.releases |> renderList
    in
        div []
            [ div []
                [ button [ onClick ShowCurrent ] [ text "Current" ]
                , button [ onClick ShowAll ] [ text "All" ]
                ]
            , div []
                [ content ]
            ]
