module User.Update exposing (..)

import User.Messages exposing (Msg(..))
import User.Models exposing (..)
import User.Commands exposing (..)
import Helpers.Task exposing (dispatch)
import Constants exposing (emptyString)


update : Msg -> Model -> ( Model, Cmd Msg )
update message userStore =
    case message of
        FetchData ->
            ( { userStore
                | status = Loading
                , error = emptyString
              }
            , fetchAll
            )

        FetchAllDone (Ok maybeUser) ->
            let
                ( model, cmd ) =
                    case maybeUser of
                        Just user ->
                            ( { userStore
                                | user = user
                                , error = emptyString
                                , status = LoggedIn
                              }
                            , dispatch LoginDone
                            )

                        Nothing ->
                            ( { initialModel
                                | status = LoggedOut
                              }
                            , Cmd.none
                            )
            in
                ( model, cmd )

        FetchAllDone (Err error) ->
            let
                errorMsg =
                    "Fail Loading User ! " ++ (toString error)
            in
                ( { initialModel
                    | error = errorMsg
                    , status = Error
                  }
                , Cmd.none
                )

        LoginDone ->
            ( userStore, Cmd.none )
