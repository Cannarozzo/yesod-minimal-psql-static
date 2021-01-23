{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}
module Home where

import Foundation
import Yesod.Core
import Yesod


getHomeR :: Handler Html
getHomeR = do
    pessoas <- runDB $ selectList [] [Asc PessoaIdade]
    defaultLayout $ do
        setTitle "Cadastro Pessoas"
        
        [whamlet|
            <ul>
                $forall (Entity pessoaId pessoa) <- pessoas
                    <li>
                          <a href=@{PessoaR pessoaId}>#{pessoaNome pessoa}
        |]
     
{-
    [whamlet|
        <img src=@{StaticR ft_jpg}/>
    |]
-}
{-
[whamlet|
            <p>
                <a href=@{AddR 5 7}>HTML addition
            <p>
                <a href=@{AddR 5 7}?_accept=application/json>JSON addition
        |]
-}