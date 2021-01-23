{-# LANGUAGE OverloadedStrings #-}

import Application () -- for YesodDispatch instance
import Foundation
import Yesod.Core
import Yesod.Static

import Database.Persist.Postgresql
import Control.Monad.Logger (runStdoutLoggingT)
import Control.Monad.IO.Class (liftIO)

connStr = "dbname=proj host=localhost user=fulano password=123 port=5432"

main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do
       liftIO $ putStrLn "teste"
       flip runSqlPersistMPool pool $ do
              runMigration migrateAll
              --insert $ Pessoa "Felipe" "Cannarozzo" 34
              let pid = (toSqlKey 2 :: Key Pessoa)
             -- nn <- update pid [PessoaIdade +=. 1]
             -- liftIO $ print nn
              pessoa <- get pid
              liftIO $ print pessoa
       static@(Static settings) <- static "static"
       warp 8080 (App pool static)
-- Pattern Match
       
{-
main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do 
       runSqlPersistMPool (runMigration migrateAll) pool
       static@(Static settings) <- static "static"
       warp 8080 (App pool static)
-}