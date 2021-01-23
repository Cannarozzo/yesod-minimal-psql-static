{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Handler.Pessoa.Pessoa where

import Foundation
import Yesod.Core
import Yesod

getPessoaR :: PessoaId -> Handler Html
getPessoaR pessoaId = do
    pessoa <- runDB $ get404 pessoaId
    defaultLayout 
        [whamlet| 
            <p>
                #{show pessoa}
        |]

postPessoaR :: PessoaId -> Handler Html
postPessoaR pessoaId = error ""