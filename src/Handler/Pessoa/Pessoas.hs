{-# LANGUAGE OverloadedStrings #-}
{-# LANGUAGE QuasiQuotes       #-}

{-# LANGUAGE MultiParamTypeClasses #-}
{-# LANGUAGE OverloadedStrings     #-}
{-# LANGUAGE QuasiQuotes           #-}
{-# LANGUAGE TemplateHaskell       #-}
{-# LANGUAGE TypeFamilies          #-}
module Handler.Pessoa.Pessoas where

import Foundation
import Yesod.Core
import Yesod
import Control.Applicative
import Data.Text (Text)

getPessoasR :: Handler Html
getPessoasR = do
    pessoasEntity <- runDB $ selectList [] [Desc PessoaNome] 
    --let pessoas = fmap (\ (Entity pid pessoa) -> pessoa) pessoasEntity
   -- liftIO $ putStrLn $ show pessoas
    defaultLayout 
        [whamlet|
            $forall (Entity pid pessoa) <- pessoasEntity
               <p> 
                    #{show $ pessoaNome pessoa}
                    <a href=@{PessoaR pid }>
                        Dados detalhados
                    <a href=@{PessoaRemoveR pid} >
                        Remover Pessoa
                    <a href=@{PessoaAtualizaR pid}>
                        Atualizar dados da Pessoa
                        
                   
        |]

--let pessoaId = (formSqlKey 1 :: Key Pessoa)

--selectList [PessoaId ==. pessoaId] [LimitTo 1]    
--selectList [BlogPostAuthorId ==. johnId] [LimitTo 1]  
--people <- selectList [PersonAge >. 25, PersonAge <=. 30] []

{-

people <- selectList
    (       [PersonAge >. 25, PersonAge <=. 30]
        ||. [PersonFirstName /<-. ["Adam", "Bonny"]]
        ||. ([PersonAge ==. 50] ||. [PersonAge ==. 60])
    )
    []
liftIO $ print people
-}
