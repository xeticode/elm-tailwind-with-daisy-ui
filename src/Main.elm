module Main exposing (..)

import Browser
import Browser.Navigation as Nav
import Css.Global
import Html.Styled as H
import Html.Styled.Attributes as HA
import Tailwind.Theme as TWT
import Tailwind.Utilities as TWU
import Url


main : Program Flags Model Msg
main =
    Browser.application
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        , onUrlChange = ChangedUrl
        , onUrlRequest = ClickedLink
        }


type alias Flags =
    {}


type alias Model =
    { key : Nav.Key
    , url : Url.Url
    }


init : Flags -> Url.Url -> Nav.Key -> ( Model, Cmd Msg )
init flags url key =
    let
        model =
            { key = key
            , url = url
            }

        cmd =
            Cmd.none
    in
    ( model, cmd )


type Msg
    = NoOp
    | ChangedUrl Url.Url
    | ClickedLink Browser.UrlRequest


update : Msg -> Model -> ( Model, Cmd Msg )
update msg model =
    case msg of
        NoOp ->
            ( model, Cmd.none )

        ClickedLink urlRequest ->
            case urlRequest of
                Browser.Internal url ->
                    ( model
                    , Nav.pushUrl model.key (Url.toString url)
                    )

                Browser.External url ->
                    ( model
                    , Nav.load url
                    )

        ChangedUrl url ->
            ( { model | url = url }, Cmd.none )


subscriptions : Model -> Sub Msg
subscriptions model =
    Sub.none


view : Model -> Browser.Document Msg
view model =
    { title = "New Project"
    , body =
        List.map H.toUnstyled
            [ Css.Global.global TWU.globalStyles
            , pageView model
            ]
    }


pageView : Model -> H.Html Msg
pageView model =
    H.h1
        [ HA.css [ TWU.p_6, TWU.bg_color TWT.amber_200 ] ]
        [ H.text "Welcome to my new project." ]