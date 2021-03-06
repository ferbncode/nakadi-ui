module Pages.NotFound.View exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)
import Models exposing (AppModel)
import Types exposing (AppHtml)
import Helpers.Panel exposing (page, panel)
import Html exposing (text, Html)
import Routing.Models exposing (Route(HomeRoute))
import Routing.Messages exposing (Msg(Redirect))
import Messages exposing (Msg(RoutingMsg))


view : AppModel -> AppHtml
view model =
    page []
        [ panelWithButton
            4
            "404 Not found"
            [ text "Oops! Sorry, but the page you are looking for doesn't exist here." ]
            "Go to Home page"
            HomeRoute
        ]


panelWithButton : Int -> String -> List (Html Messages.Msg) -> String -> Route -> Html Messages.Msg
panelWithButton gridSize title desc btnText route =
    panel gridSize
        title
        [ p [] desc
        , div [ class "dc--text-center" ]
            [ button [ class "dc-btn dc-btn--primary dc--text-center", onClick (RoutingMsg (Redirect route)) ] [ text btnText ]
            ]
        ]
