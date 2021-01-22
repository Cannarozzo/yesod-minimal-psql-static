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
       static@(Static settings) <- static "static"
       warp 8080 (App pool static)
       
{-
main::IO()
main = runStdoutLoggingT $ withPostgresqlPool connStr 10 $ \pool -> liftIO $ do 
       runSqlPersistMPool (runMigration migrateAll) pool
       static@(Static settings) <- static "static"
       warp 8080 (App pool static)
-}