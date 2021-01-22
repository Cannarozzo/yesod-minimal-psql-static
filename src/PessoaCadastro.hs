{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
module PessoaCadastro where

import Foundation
import Yesod.Core
import Yesod
import Control.Applicative
import Data.Text (Text)

getPessoaCadastroR :: Handler Html
getPessoaCadastroR = defaultLayout
    [whamlet|
        <form action=@{PessoaCadastroR} method=post>
            <p>
                Nome
                <input type=text name=nome>
                <br>
                Sobre nome
                <input type=text name=sobrenome>
                <br>
                Idade
                <input type=text name=idade>
                <br>
                <input type=submit value="Cadastrar">
    |]

postPessoaCadastroR :: Handler Html
postPessoaCadastroR = do
    pessoa <- runInputPost $ Pessoa
                <$> ireq textField "nome"
                <*> ireq textField "sobrenome"
                <*> ireq intField "idade"
                
    pid <- runDB $ insert pessoa
    defaultLayout 
        [whamlet|
            <p>
                #{show pessoa}
            <p>
                O id da pessoa cadastrada: #{show pid}
        |]