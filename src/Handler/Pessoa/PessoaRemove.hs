{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
module Handler.Pessoa.PessoaRemove where

import Foundation
import Yesod.Core
import Yesod
import Control.Applicative
import Data.Text (Text)

-- Por query string ou por formulario
getPessoaRemoveR :: PessoaId -> Handler Html
getPessoaRemoveR pid = do
    pessoa <- runDB $ get404 pid
    runDB $ delete pid
    defaultLayout
        [whamlet| 
            <p>
                A pessoa #{ show pessoa } foi removida com sucesso
        |]
    
    

postPessoaRemoveR :: PessoaId -> Handler Html
postPessoaRemoveR pid = undefined

{-
deleteBy $ PersonName "Michael" "Snoyman"
deleteWhere [PersonFirstName ==. "Michael"]
-}